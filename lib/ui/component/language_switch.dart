import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controllers/language_provider.dart';

Widget languageSwitch(bool isArabicMode){
  return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        bool isArabicMode = languageProvider.isArabicMode;
       return Row(
          children: [
            Text(
              'AR',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: 'SplashName',
                  fontSize: 17.sp,
                  color: Colors.white),
            ),
            SizedBox(width: 5.w),
            Switch(
              value: isArabicMode,
              activeColor: Colors.grey,
              onChanged: (value) {
                languageProvider.setLanguageMode(value);
              },
            ),
            Text(
              'EN',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: 'SplashName',
                  fontSize: 17.sp,
                  color: Colors.white),
            ),
            SizedBox(width: 15.w),
          ],
        );
      }
  );
}