import 'package:TouchVision/ui/screens/home/home.dart';
import 'package:TouchVision/ui/screens/navigation_bar/navigation_bar.dart';
import 'package:TouchVision/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:  const Size(390, 844),
        builder: (context, child) {
          return MaterialApp(
            builder: (context, child) {
              return MediaQuery(data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0)),
                  child: child!);
            },
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        }
    );
  }
}


