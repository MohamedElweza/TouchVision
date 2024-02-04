import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../component/custom_onBoarding_screen.dart';
import '../../component/indicator.dart';
import '../../utils/styles/color_styles.dart';
import '../navigation_bar/navigation_bar.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController pageController;
  int? pageIndex = 0;
  late AudioPlayer audioPlayer;

  List<String> audioFiles = [
    'on_1.mp3',
    'speak_question.mp3',
    'explore_know_fast2.mp3',
  ];

  List onBoardingsSubtitle = [
    'Welcome to Touch Vision. Ask, listen, learn.',
    'Speak your questions, we\'re here to listen.',
    'Explore a world of knowledge, independently.'
  ];

  List onBoardingsImage = [
    'assets/images/on1.png',
    'assets/images/on2.png',
    'assets/images/on4.png'
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    audioPlayer = AudioPlayer();
    playAudio();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  void playAudio() {
    audioPlayer.play(AssetSource(audioFiles[pageIndex!]));
    print(audioFiles[pageIndex!]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorStyles.grey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15.h,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30.0.w, top: 30.0.h),
                child: SizedBox(
                  height: 40.h,
                  width: 85.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyles.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const NavigatorBar(),
                          ),
                        );
                    },
                    child: Center(
                      child: Text(
                           'Skip',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Colors.white,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: onBoardingsSubtitle.length,
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                    playAudio();
                  });
                },
                itemBuilder: (context, index) => CustomOnBoardingScreen(
                  subtitle: onBoardingsSubtitle[index],
                  image:  onBoardingsImage[index],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    onBoardingsSubtitle.length,
                        (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                      child: Indicator(
                        isActive: index == pageIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 30.0.w, bottom: 30.0.h),
                child: SizedBox(
                  height: 45.h,
                  width: 150.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyles.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      if (pageIndex == onBoardingsSubtitle.length - 1) {
                        // Navigate to home when on the last page
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const NavigatorBar(),
                          ),
                        );
                      } else {
                        // Go to the next page
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );

                      }
                    },
                    child: Center(
                      child: Text(
                        pageIndex == onBoardingsSubtitle.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Colors.white,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
