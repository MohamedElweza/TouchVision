import 'package:TouchVision/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'controllers/ChatGPT/ChatGPT.dart';
import 'controllers/ChatGPT/Chat_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:  Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        builder: (context, child) {
          return MaterialApp(
            builder: (context, child) {
              return MediaQuery(data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0)),
                  child: child!);
            },
            debugShowCheckedModeBanner: false,
            home:  const SplashScreen(),
          );
        }
    );
  }
}


