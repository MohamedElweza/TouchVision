import 'package:TouchVision/ui/utils/styles/color_styles.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_sound/flutter_sound.dart';
import '../home/home.dart';
import 'custon_paint.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int currentIndex = 0;

  stt.SpeechToText speechToText = stt.SpeechToText();
  late FlutterSoundPlayer _player;
  late FlutterSoundRecorder _recorder;
  String text = "";
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    _player = FlutterSoundPlayer();
    _recorder = FlutterSoundRecorder();
  }

  Future<void> _startListening() async {
    if (!isListening) {
      var available = await speechToText.initialize();
      if (available) {
        setState(() {
          isListening = true;
        });

        // Get the path to the lib folder
        final documentsDirectory = await getApplicationDocumentsDirectory();
        final filePath = '${documentsDirectory.path}/audio.pcm';

        await _recorder.openRecorder();
        await _recorder.startRecorder(
          toFile: filePath,
          codec: Codec.pcm16,
        );

        speechToText.listen(
          onResult: (result) {
            setState(() {
              text = result.recognizedWords;
              print(text);
            });
          },
        );
      }
    }
  }

  Future<void> _stopListening() async {
    if (isListening) {
      await _recorder.stopRecorder();
      await _recorder.closeRecorder();
      await speechToText.stop();
      setState(() {
        isListening = false;
      });

      final documentsDirectory = await getApplicationDocumentsDirectory();
      final filePath = '${documentsDirectory.path}/audio.pcm';

      print('Audio saved at: $filePath');
    }
  }

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _player.closePlayer();
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<Widget> pages = [
      Home(),
      // const Courses(isGuest: false, isTeasher: false),
      // ChatScreen(),
      // const ProfileScreen(),
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
                clipBehavior: Clip.none, children: [
                  CustomPaint(
                    size: Size(size.width,size.height),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.4.h,
                    child: AvatarGlow(
                      endRadius: 75.r,
                      animate: isListening,
                      duration: const Duration(milliseconds: 2000),
                      glowColor: ColorStyles.mainColor,
                      repeat: true,
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      child: GestureDetector(
                        onTapDown: (details) => _startListening(),
                        onTapUp: (details) => _stopListening(),
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
                                ?   ColorStyles.mainColor
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
                        Image.asset('assets/images/chatgpt.png', height: 50.h, width: 50.w,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Display the selected page based on currentIndex

        ],
      ),
    );
  }
}


