// import 'package:drivy_driver/Controller/global_controller.dart';
// import 'package:drivy_driver/Utils/my_colors.dart';
// import 'package:drivy_driver/Utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:drivy_driver/Component/custom_toast.dart';
// import 'package:sizer/sizer.dart';
// import '../../Component/custom_text.dart';
// import '../../Utils/enum.dart';
//
// class LogoutAlert extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       width: 100.w,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               height: 2.h,
//             ),
//             MyText(
//               title: "LOG OUT",
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
//                   title: "Log out of your account?",
//                   size: 13,
//                   center: true,
//                   clr: const Color(0xff858585)
//
//               ),
//             ),
//             /*  SizedBox(height: 1.h,),
//             Row(
//               children: [
//                 Obx(()=>  Checkbox(
//                     value: HomeController.instance.confirmPurchase.value,
//                     onChanged: (val) {
//                       HomeController.instance.confirmPurchase(val);
//                     },
//                     activeColor: Theme.of(context).primaryColor
//                 ),),
//                 Expanded(
//                   child: MyText(
//                     title: 'I have read the patient lead tx disclosure',
//                     clr: Color(0xff858585),
//                     size: 13,
//                   ),
//                 ),
//               ],
//             ),*/
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
//                           bottomLeft: Radius.circular(10)
//                       ),
//                     ),
//                     alignment: Alignment.center,
//                     height: 8.h,
//                     child:const MyText(
//                         title: "NO",
//                         size: 16,
//                         center: true,
//                         clr: Color(0xff858585)
//                     ),
//                   ),
//                 )),
//                 Expanded(child: GestureDetector(
//                   onTap: (){
//                     Get.back();
//                     Utils().logout(fromLogout: true);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColorDark,
//                       borderRadius: const BorderRadius.only(
//                           bottomRight: Radius.circular(10)
//                       ),
//                     ),
//                     alignment: Alignment.center,
//                     height: 8.h,
//                     child: MyText(
//                         title: "LOG OUT",
//                         size: 16,
//                         center: true,
//                         clr: MyColors().whiteColor
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