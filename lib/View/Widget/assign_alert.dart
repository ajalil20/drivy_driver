// import 'package:drivy_driver/Controller/global_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:drivy_driver/Component/custom_toast.dart';
// import 'package:sizer/sizer.dart';
// import '../../Component/custom_text.dart';
// import '../../Utils/enum.dart';
// import '../../Utils/responsive.dart';
//
//
// class CustomAlertPopup extends StatelessWidget {
//   Responsive responsive = Responsive();
//   CustomAlertPopup({super.key,this.title,this.description,required this.yes});
//   String? title,description;
//   Function? yes;
//
//   @override
//   Widget build(BuildContext context) {
//     responsive.setContext(context);
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           ),
//       // height: responsive.setHeight(75),
//       width: responsive.setWidth(100),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               height: 2.h,
//             ),
//             MyText(
//               title: title??"CONFIRM PURCHASE",
//               clr: Theme.of(context).primaryColorDark,
//               weight: "Semi Bold",
//               size: 18,
//             ),
//             SizedBox(
//               height: 2.h,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal:  10.w),
//               child: MyText(
//                 title: description?? (GlobalController.values.userRole.value == UserRole.seller ?"Do you want to purchase this lead for 5 tokens?":"Do you want to purchase this lead for 5 credits?"),
//                   size: 13,
//                   center: true,
//                   clr: const Color(0xff858585)
//
//               ),
//             ),
//             SizedBox(height: 2.h,),
//             Row(
//               children: [
//                 Expanded(child: GestureDetector(
//                   onTap: (){
//                     Get.back();
//                   },
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color:  Color(0xffCFCFCF),
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10)
//                       ),
//                     ),
//                     alignment: Alignment.center,
//                     height: 7.h,
//                   child:const MyText(
//                       title: "NO",
//                       size: 16,
//                       center: true,
//                       clr: Color(0xff858585)
//                   ),
//                   ),
//                 )),
//                 Expanded(child: GestureDetector(
//                   onTap: (){
//                     yes!();
//                     // Get.back();
//                     // Get.back();
//                     // CustomToast().showToast("Success", "Lead purchased successfully", false);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColorDark,
//                       borderRadius: const BorderRadius.only(
//                           bottomRight: Radius.circular(10)
//                       ),
//                     ),
//                     alignment: Alignment.center,
//                     height: 7.h,
//                     child:const MyText(
//                         title: "YES",
//                         size: 16,
//                         center: true,
//                         clr: Colors.white
//                     ),
//                   ),
//                 )),
//               ],
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }