import 'package:TouchVision/ui/utils/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  stt.SpeechToText speechToText = stt.SpeechToText();

  String text = "Hold the button and start speaking";
  bool isListening = false;
  bool isArabicMode = false;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorStyles.white,
          shadowColor: Colors.white,
          elevation: .2,
          automaticallyImplyLeading: true,
          title: Padding(
            padding: EdgeInsets.only(top: 15.0.h),
            child: Text(
              'Here to listen!',
              style: TextStyle(fontSize: 30.sp, color: ColorStyles.mainColor, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
            ),
          ),
          actions: [
            Row(
              children: [
                Text('EN', style: TextStyle(fontWeight: FontWeight.w800, fontFamily: 'SplashName', fontSize: 17.sp),),
                SizedBox(width: 5.w),
                Switch(
                  value: isArabicMode,
                  onChanged: (value) {
                    setState(() {
                      isArabicMode = value;
                    });
                  },
                ),
                SizedBox(width: 1.w),
                Text('AR', style: TextStyle(fontWeight: FontWeight.w800, fontFamily: 'SplashName', fontSize: 17.sp),),
                SizedBox(width: 15.w),
              ],
            ),
          ],
        ),

        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 4.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorStyles.secondColor, // Shadow color
                      blurRadius: 3.0.r,
                      offset: Offset(0.w, 1.25.h), // Offset of the shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0.w, top: 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child:  Image(
                              fit: BoxFit.fill,
                              height: 150.h,
                              image: const NetworkImage(
                                'https://jbrary.com/wp-content/uploads/2018/03/the-dress-and-the-girl.jpg',
                              ),
                            )),
                      ),
                       SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The Dress and the Girl',
                              overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 21.sp, color: ColorStyles.mainColor, fontFamily: "Tajawal", fontWeight: FontWeight.bold)
                            ),

                             Text(
                               'Romantic',
                                 style: TextStyle(fontSize: 17.sp, color: ColorStyles.mainColor, fontFamily: "Tajawal", fontWeight: FontWeight.normal)
                             ),

                             Row(
                               children: [
                                 Padding(
                                   padding: EdgeInsets.only(bottom: 8.0.h),
                                   child: const Icon(
                                     Icons.star,
                                     color: Colors.orange,
                                   ),
                                 ),
                                 SizedBox(
                                   width: 8.w,
                                 ),
                                 Text(
                                   '8.4',
                                     style: TextStyle(fontSize: 15.sp, color: ColorStyles.mainColor, fontFamily: "Tajawal", fontWeight: FontWeight.bold)
                                 ),
                               ],
                             ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorStyles.mainColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                      'Read Now',
                                      style: TextStyle(
                                          fontSize: 15.sp, color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

}
