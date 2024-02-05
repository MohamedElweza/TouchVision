import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../../utils/styles/color_styles.dart';
import '../onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5), // Fade in during the first half (2 seconds)
      ),
    );


    _animationController.forward();

    Timer(const Duration(milliseconds: 4500), () {
      Navigator.of(context).pushReplacement(
        PageTransition(
          childCurrent: const SplashScreen(),
          type: PageTransitionType.fade,
          child: const OnBoarding(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.grey,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png', // Replace with your splash image path
                width: 350.0.w,
                height: 200.h,
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 3),
                child: AnimatedTextKit(
                  totalRepeatCount: 2,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'TOUCH VISION',
                      textStyle:  TextStyle(
                        color: ColorStyles.mainColor,
                        fontSize: 35.0.sp,
                        fontWeight: FontWeight.bold,
                      ),),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
