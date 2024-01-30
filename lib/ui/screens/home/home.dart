import 'package:TouchVision/ui/utils/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:avatar_glow/avatar_glow.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  stt.SpeechToText speechToText = stt.SpeechToText();

  String text = "Hold the button and start speaking";
  bool isListening = false;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            'We are here to listen!',
            style: TextStyle(fontSize: 24.sp, color: ColorStyles.mainColor, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
          ),
          actions: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0.w, ),
              child: Image.asset('assets/images/logo.png', height: 50.h, width: 50.w,),
            )
          ],
        ),

        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
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
                      blurRadius: 5.0.r,
                      offset: Offset(0.w, 1.5.h), // Offset of the shadow
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
                            borderRadius: BorderRadius.circular(8.0),
                            child:  const Image(
                              fit: BoxFit.fill,
                              height: 150,
                              image: NetworkImage(
                                'https://jbrary.com/wp-content/uploads/2018/03/the-dress-and-the-girl.jpg',
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  child: Text('Read Now',
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
