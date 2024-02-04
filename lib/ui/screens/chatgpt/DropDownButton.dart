// import 'package:TouchVision/ui/utils/styles/color_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../controllers/ChatGPT/ChatGPT.dart';
// import '../../../data/models/ChatGPT/ChatGPT_Model.dart';
// import 'TextWidget.dart';
//
// class ModelsDrowDownWidget extends StatefulWidget {
//   const ModelsDrowDownWidget({super.key});
//
//   @override
//   State<ModelsDrowDownWidget> createState() => _ModelsDrowDownWidgetState();
// }
//
// class _ModelsDrowDownWidgetState extends State<ModelsDrowDownWidget> {
//   String? currentModel;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSelectedValue();
//   }
//
//   void _loadSelectedValue() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       currentModel = prefs.getString('CurrentModel') ?? '';
//     });
//   }
//
//   void _saveSelectedValue(String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('CurrentModel', value);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
//     currentModel = modelsProvider.getCurrentModel;
//     return FutureBuilder<List<ModelsModel>>(
//         future: modelsProvider.getAllModels(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: TextWidget(label: snapshot.error.toString()),
//             );
//           }
//           return snapshot.data == null || snapshot.data!.isEmpty
//               ? const SizedBox.shrink()
//               : FittedBox(
//             child: DropdownButton(
//               dropdownColor: ColorStyles.white,
//               iconEnabledColor: Colors.white,
//               items: List<DropdownMenuItem<String>>.generate(
//                   snapshot.data!.length,
//                       (index) => DropdownMenuItem(
//                       value: snapshot.data![index].id,
//                       child: TextWidget(
//                         label: snapshot.data![index].id,
//                         fontSize: 15,
//                       ))),
//               value: currentModel,
//               onChanged: (value) {
//                 setState(() {
//                   currentModel = value.toString();
//                 });
//                 _saveSelectedValue(value!);
//                 modelsProvider.setCurrentModel(
//                   value.toString(),
//                 );
//               },
//             ),
//           );
//         });
//   }
// }