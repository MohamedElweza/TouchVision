import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles/color_styles.dart';


class CustomOnBoardingScreen extends StatelessWidget {
  const CustomOnBoardingScreen({
    super.key, required this.subtitle, required this.image,
  });

  final String subtitle;
  final String image ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image, height: 310.h, width: 310.w,),
          SizedBox(height: 30.h,),
          Text(subtitle,textAlign: TextAlign.center, style: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.bold, color: ColorStyles.mainColor, fontFamily: 'Tajawal'),),
          SizedBox(height: 10.h,),

        ],
      ),
    );
  }
}