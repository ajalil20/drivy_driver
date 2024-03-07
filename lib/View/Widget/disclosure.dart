// import 'package:drivy_user/Component/custom_toast.dart';
// import 'package:drivy_user/Controller/global_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import '../../Component/custom_text.dart';
// import '../../Controller/home_controller.dart';
// import '../../Utils/enum.dart';
// import '../../Utils/responsive.dart';
//
// class DisclosureAlert extends StatelessWidget {
//   Responsive responsive = Responsive();
//   Function? onTapYes;
//
//   DisclosureAlert({super.key,this.onTapYes});
//
//   @override
//   Widget build(BuildContext context) {
//     responsive.setContext(context);
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       // height: responsive.setHeight(75),
//       width: responsive.setWidth(100),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//                 decoration: const BoxDecoration(
//                   // color: Theme.of(context).primaryColorDark,
//                     borderRadius: BorderRadius.vertical(
//                         top: Radius.circular(20)
//                     )),
//
//                 child: ListTile(
//                     title: Center(child: Align(
//                       alignment: const Alignment(.2, 0),
//                       child: MyText(title: "Disclosure".toUpperCase(),clr:Theme.of(context).primaryColor,center: true,weight: "Semi Bold",),)),
//                     trailing:GestureDetector(
//                         onTap: (){Get.back();},
//                         child: Icon(Icons.cancel,color:Theme.of(context).primaryColorDark,))
//                 )
//             ),
//
//
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(8)),
//               child: Column(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   // SizedBox(height: 2.h,),
//                   MyText(
//                     title:
//                     GlobalController.values.userRole.value == UserRole.Dentist?
//                     'Thank you for utilizing our consultation service. One of our master dental clinicans are here to help. Please note that in using this service it is understood that this service is not intended to provide nor replace any clinical diagnosis. Information exchanged is for educational purposes only. All clinical final diagnosis,treatment planning, and treatment are the responsibility of the primary care dentist. Protect your patients privacy and identity. Do not upload or send PPI. Non-identifiable photos, X-rays, etc are Allowed for better understanding of the case. Any evident PPI violation will be deleted immediately.':
//                     'Thank you for utilizing our consultation service. One of our clinicans are here to help. Please note that in using this service it is understood that this service is not intended to provide nor replace any clinical diagnosis Unless otherwise stated during the tele-med consultation. Information exchanged is for peer to peer educational purpose only. All clinical final diagnosis, treatment planning, and treatment are the responsibility of the primary care physician. To meet HIPPA. Protect your patients privacy and identity. Do not upload or send PPI. Non-identifiable photos, X-rays, etc are allowed for better understanding of the case. Any evident PPI violation will be deleted immediately.',
//                     //'Thank you for utilizing our consultation service. One of our master dental clinicans are here to help. Please note that in using this service it is understood that this service is not intended to provide nor replace any clinical diagnosis. Information exchanged is for educational purposes only. All clinical final diagnosis,treatment planning, and treatment are the responsibility of the primary care dentist. Protect your patients privacy and identity. Do not upload or send PPI. Non-identifiable photos, X-rays, etc are Allowed for better understanding of the case. Any evident PPI violation will be deleted immediately.',
//                     // weight: "Semi Bold",
//                     clr: const Color(0xff858585),
//                     size: 14,
//                     center: true,
//                     toverflow: TextOverflow.ellipsis,
//                     line: 12,
//                     // size: 18,
//                   ),
//                   SizedBox(height: 2.h,),
//                   MyText(title: "Confirm Consult Request".toUpperCase(),clr:Theme.of(context).primaryColor,center: true,weight: "Semi Bold",),
//                   SizedBox(height: 2.h,),
//                   const MyText(
//                     title: 'Do you want to purchase this lead for 5 tokens?',
//                      // weight: "Semi Bold",
//                     clr: Color(0xff858585),
//                     // center: true,
//                     size: 14,
//                     line: 5,
//                     // size: 18,
//                   ),
//                   SizedBox(height: 1.h,),
//                   Row(
//                     children: [
//                       Obx(()=>  Checkbox(
//                           value: HomeController.i.confirmPurchase.value,
//                           onChanged: (val) {
//                             HomeController.i.confirmPurchase(val);
//                           },
//                           activeColor: Theme.of(context).primaryColor
//                       ),),
//                       const Expanded(
//                         child: MyText(
//                           title: 'I have read the consult disclosure',
//                           clr: Color(0xff858585),
//                           size: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 2.h,),
//
//
//                 ],
//               ),
//             ),
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
//                     // Get.back();
//                     if(HomeController.i.confirmPurchase.value==false)
//                       {
//                         CustomToast().showToast(
//                             "Error", "Please check disclosure checkbox", true);
//                       }
//                     else {
//                       Get.back();
//                       CustomToast().showToast("Success", "Lead purchased successfully", false);
//                      if(onTapYes!=null){ onTapYes!();}
//                     }
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
//           ],
//         ),
//       ),
//     );
//   }
// }
