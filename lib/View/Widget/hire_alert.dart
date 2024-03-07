// import 'package:drivy_driver/View/Hire/my_hire.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:drivy_driver/Component/custom_toast.dart';
// import 'package:sizer/sizer.dart';
// import '../../Component/custom_text.dart';
//
// class HireAlert extends StatelessWidget {
//   HireAlert({super.key,required this.onYes});
//   Function onYes;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       // height: responsive.setHeight(75),
//       width: 100.w,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               height: 2.h,
//             ),
//             MyText(
//               title: "CONFIRM HIRE",
//               clr: Theme.of(context).primaryColorDark,
//               weight: "Semi Bold",
//               size: 18,
//             ),
//             SizedBox(
//               height: 2.h,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal:  10.w),
//               child: const MyText(
//                   title:"Do you want to hire this lead for 4 tokens?",
//                   size: 13,
//                   center: true,
//                   clr: Color(0xff858585)
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
//                     height: 7.h,
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
//                     onYes();
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