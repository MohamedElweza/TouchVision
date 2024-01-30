import 'package:TouchVision/ui/utils/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    this.isActive=false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height:isActive? 16.h:6,
      width: 6.w,
      decoration: BoxDecoration(
          color: isActive?ColorStyles.mainColor:Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}