// import 'package:flutter/material.dart';
// import '../../utils/styles/color_styles.dart';
// import 'DropDownButton.dart';
// import 'TextWidget.dart';
//
// class Services {
//
//   static Future<void> showModalSheet({required BuildContext context}) async {
//     await showModalBottomSheet(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(20),
//           ),
//         ),
//         backgroundColor: ColorStyles.white,
//         context: context,
//         builder: (context) {
//           return const Padding(
//             padding: EdgeInsets.all(18.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children:  [
//                 Flexible(
//                   child: TextWidget(
//                     label: "Chosen Model:",
//                     fontSize: 16,
//                   ),
//                 ),
//                 Flexible(
//                     flex: 2,
//                     child: ModelsDrowDownWidget(),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }