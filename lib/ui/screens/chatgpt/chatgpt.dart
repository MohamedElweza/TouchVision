import 'dart:async';
import 'dart:developer';
import 'package:TouchVision/ui/utils/styles/color_styles.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../../../controllers/ChatGPT/ChatGPT.dart';
import '../../../controllers/ChatGPT/Chat_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'ChatWidget.dart';
import 'TextWidget.dart';

class ChatGPT extends StatefulWidget {
  const ChatGPT({super.key});

  @override
  State<ChatGPT> createState() => _ChatGPTState();
}

class _ChatGPTState extends State<ChatGPT> {
  bool _isTyping = false;
  stt.SpeechToText speechToText = stt.SpeechToText();
  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  String text = "";
  bool isArabicMode = false;
  FlutterTts flutterTts = FlutterTts();
  TextToSpeechConverter ttsConverter = TextToSpeechConverter();
  Completer<void> listeningCompleter = Completer<void>();

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  bool isListening = false;

  Future<void> _startListening() async {
    if (!isListening) {
      var available = await speechToText.initialize();
      if (available) {
        setState(() {
          isListening = true;
        });

        speechToText.listen(
          onResult: (result) {
            setState(() {
              text = result.recognizedWords;
            });
          },
          partialResults: true,
          localeId: isArabicMode ? 'en-US' : 'ar-SA',
        );
      }
    }
  }

  Future<void> _stopListening() async {
    if (isListening) {
      await speechToText.stop();
      setState(() {
        isListening = false;
      });
    }
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: ColorStyles.mainColor,
      appBar: AppBar(
        backgroundColor: ColorStyles.mainColor,
        centerTitle: true,
        elevation: 2,
        actions: [
          Row(
            children: [
              Text(
                'AR',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'SplashName',
                    fontSize: 17.sp,
                    color: Colors.white),
              ),
              SizedBox(width: 5.w),
              Switch(
                value: isArabicMode,
                activeColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    isArabicMode = value;
                  });
                },
              ),
              Text(
                'EN',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'SplashName',
                    fontSize: 17.sp,
                    color: Colors.white),
              ),
              SizedBox(width: 15.w),
            ],
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.r)),
              child: Image.asset(
                'assets/images/logo.png',
              )),
        ),
        title: Padding(
          padding: EdgeInsets.only(right: 40.0.w, top: 8.h),
          child: const Text(
            "BOT VISION",
            style: TextStyle(
                color: ColorStyles.white,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: chatProvider.getChatList.isEmpty
                  ? Center(
                      child: Text(
                        'How can I help you!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SplashName',
                          fontSize: 40.sp,
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _listScrollController,
                      itemCount:
                          chatProvider.getChatList.length, //chatList.length,
                      itemBuilder: (context, index) {
                        return ChatWidget(
                          msg: chatProvider
                              .getChatList[index].msg, // chatList[index].msg,
                          chatIndex: chatProvider.getChatList[index]
                              .chatIndex, //chatList[index].chatIndex,
                          shouldAnimate:
                              chatProvider.getChatList.length - 1 == index,
                        );
                      }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: ColorStyles.red,
                size: 18,
              ),
            ],
            Center(
              heightFactor: .8.h,
              child: AvatarGlow(
                endRadius: 75.r,
                animate: isListening,
                duration: const Duration(milliseconds: 2000),
                glowColor: ColorStyles.white,
                repeat: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: GestureDetector(
                  onTapDown: (details) {
                    _startListening();
                  },
                  onTapUp: (details) async {
                    await _stopListening();
                    await Future.delayed(const Duration(milliseconds: 500));
                    await sendMessageFCT(
                      modelsProvider: modelsProvider,
                      chatProvider: chatProvider,
                      inputText: text,
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: ColorStyles.red,
                    radius: 35.r,
                    child: Icon(
                      isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Colors.white),
                    child: IconButton(
                        alignment: Alignment.center,
                        color: ColorStyles.mainColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 40.sp,
                        ))))
          ],
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessageFCT({
    required ModelsProvider modelsProvider,
    required ChatProvider chatProvider,
    String? inputText,
  }) async {
    String msg = inputText ?? textEditingController.text;
    if (msg.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      setState(() {
        _isTyping = true;
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
        msg: msg,
        chosenModelId: modelsProvider.getCurrentModel,
      );

      String lastMessage = chatProvider.getChatList.last.msg;

      await ttsConverter.convertTextToSpeech(lastMessage);

      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: error.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}

class TextToSpeechConverter {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> convertTextToSpeech(String text) async {
    await flutterTts
        .setLanguage("en-US"); // Set the language (adjust as needed)
    await flutterTts.setPitch(1.0); // Set the pitch (adjust as needed)
    await flutterTts
        .setSpeechRate(0.5); // Set the speech rate (adjust as needed)

    await flutterTts.speak(text);
  }
}
