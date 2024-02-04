import 'package:TouchVision/ui/utils/styles/color_styles.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../chatgpt/chatgpt.dart';
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
  String text = "";
  bool isListening = false;
  bool isArabicMode = false;


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
              print(text);
              print(isArabicMode);
            });
          },
          partialResults: true,
          localeId:isArabicMode? 'ar-SA' : 'en-US',
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
                      duration: const Duration(milliseconds: 5000),
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
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, PageTransition(
                                child: const ChatGPT(), type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 700)));
                          },
                            child: Image.asset('assets/images/chatgpt.png', height: 50.h, width: 50.w,)),
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


