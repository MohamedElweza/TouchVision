import 'package:TouchVision/ui/screens/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../component/custom_onBoarding_screen.dart';
import '../../component/indicator.dart';
import '../../utils/styles/color_styles.dart';
import '../home/home.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController pageController;
  int? pageIndex = 0;

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
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
                child: SizedBox(
                  height: 40.h,
                  width: 85.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyles.mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r))),
                      onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const NavigatorBar(),
                            ),
                          );
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      },
                      child: Center(
                        child: pageIndex! == 3 - 1 ?
                        Text(
                         'Next',
                          style: TextStyle(fontFamily: 'Tajawal', color: Colors.white, fontSize: 17.sp),
                        ) : Text(
                          'Skip',
                          style: TextStyle(fontFamily: 'Tajawal', color: Colors.white, fontSize: 17.sp),
                        ),
                      )),
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
                  });
                },
                itemBuilder: (context, index) => CustomOnBoardingScreen(
                  subtitle: onBoardingsSubtitle[index],
                  image:  onBoardingsImage[index],
                ),
              ),
            ),
        
            Padding(
              padding: EdgeInsets.only(bottom: 120.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                      child: Indicator(
                        isActive: index == pageIndex,
                      ),
                    ),
                  ),
        
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
