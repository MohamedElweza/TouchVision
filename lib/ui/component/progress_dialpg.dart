
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles/color_styles.dart';

class ShowProgressIndicator {
  final Color? androidIndicatorColor;

  ShowProgressIndicator(BuildContext context,
      {this.androidIndicatorColor = Colors.white,}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent.withOpacity(0),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 50.h,
              height: 50.h,
              child: const CircularProgressIndicator(
                color: ColorStyles.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



