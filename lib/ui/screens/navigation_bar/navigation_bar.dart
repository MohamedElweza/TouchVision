import 'dart:convert';
import 'package:TouchVision/ui/utils/styles/color_styles.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../chatgpt/chatgpt.dart';
import '../home/home.dart';
import 'custon_paint.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int currentIndex = 0;

  stt.SpeechToText speechToText = stt.SpeechToText();
  String text = "";
  bool isListening = false;
  bool isArabicMode = false;

  final WebSocketChannel channel =
  IOWebSocketChannel.connect('ws://192.168.82.18:8000/ws');

  Future<void> _startListening() async {
    if (!isListening) {
      var available = await speechToText.initialize();
      if (available) {
        setState(() {
          isListening = true;
        });

        await speechToText.listen(
          onResult: (result) {
            setState(() {
              text = result.recognizedWords;
              print(text);
            });

            // Check if the result is final
            if (result.finalResult) {
              // Perform actions for final result (e.g., sendMessage)
              sendMessage(text);
            }
          },
          partialResults: true,
          localeId: isArabicMode ? 'ar-SA' : 'en-US',
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

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<void> sendMessage(String text) async {
    // Send the text to the WebSocket server
    channel.sink.add(text);
  }

  late AudioPlayer audioPlayer;

  void playReceivedAudio(String audioFile) {
    audioPlayer.play(AssetSource(audioFile));
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    channel.stream.listen((message) {
      // Handle the received message
      handleWebSocketMessage(message);
    });
  }

  // Handle the received message
  void handleWebSocketMessage(dynamic message) {
    if (kDebugMode) {
      print('Received Message: $message');
    }

    // Assuming the server sends a JSON object
    try {
      Map<String, dynamic> data = json.decode(message);

      // Access the specific fields (signal, voice_comment, GPT_response)
      String signal = data['signal'];
      String voiceComment = data['voice_comment'];
      // String gptResponse = data['GPT_response'];

      if (kDebugMode) {
        print(voiceComment);
      }

      if (signal == "1") {
        Navigator.push(
          context,
          PageTransition(
            child: const ChatGPT(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 700),
          ),
        );
      }

      // Display the information using a SnackBar
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content:
      //     Text('Signal: $signal\nVoice Comment: $voiceComment\nGPT Response: $gptResponse'),
      //   ),
      // );
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing JSON: $e');
      }
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<Widget> pages = [
      const Home(),
      const ChatGPT(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 40.0.h),
            child: pages[currentIndex],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 80.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    size: Size(size.width, size.height),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.4.h,
                    child: AvatarGlow(
                      endRadius: 75.r,
                      animate: isListening,
                      duration: const Duration(milliseconds: 5000),
                      glowColor: ColorStyles.mainColor,
                      repeat: true,
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      child: GestureDetector(
                        onTapDown: (details) {
                          _startListening();
                          // sendMessage(text);
                        },
                        onTapUp: (details) async {
                          await _stopListening();
                          sendMessage(text);
                          if (kDebugMode) {
                            print(text);
                          }
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
                  SizedBox(
                    width: size.width,
                    height: 80.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color: currentIndex == 0
                                ? ColorStyles.mainColor
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                          },
                          splashColor: Colors.white,
                        ),
                        Container(
                          width: size.width * 0.40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const ChatGPT(),
                                type: PageTransitionType.bottomToTop,
                                duration: const Duration(milliseconds: 700),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/chatgpt.png',
                            height: 50.h,
                            width: 50.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
