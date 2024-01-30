import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/styles/color_styles.dart';

class CustomToast {
  static darkToast({
    required String msg,
    ToastGravity? gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorStyles.white,
      textColor: ColorStyles.mainColor,
      fontSize: 16.0.sp,
    );
  }

  static lightToast({
    required String msg,
    ToastGravity? gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorStyles.white,
      textColor: ColorStyles.mainColor,
      fontSize: 16.0.sp,
    );
  }
}