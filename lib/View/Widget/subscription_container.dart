// import 'package:flutter/material.dart';
// import '../../../Component/custom_text.dart';
// import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';
// import '../../Controller/user_controller.dart';
// import '../../Model/subscription_model.dart';
// import '../Subscription/subscription_detail.dart';
//
//
// class SubscriptionContainer extends StatelessWidget {
//   UserController controller = Get.find();
//
//   SubscriptionModel? packages;
//   bool? isDrawer;
//   int? index;
//
//   SubscriptionContainer({super.key, this.packages, this.isDrawer, this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Container(
//         width: double.infinity,
//         margin: EdgeInsets.symmetric(horizontal: 10.w) +
//             EdgeInsets.only(bottom: 5.w),
//         child: Column(children: [
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color:  controller.selectedIndex.value != index?Colors.white : packages!.titleBgColor?? const Color(0xff00557E),
//                 borderRadius: BorderRadius.vertical(
//                     top: const Radius.circular(10),
//                   bottom: Radius.circular(controller.selectedIndex.value != index?10:0)
//                 )
//             ),
//             alignment: Alignment.center,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 3.5.w),
//               child:
//               controller.selectedIndex.value != index ?
//
//               Row(
//                 children: [
//                   const Spacer(),
//                   MyText(
//                     title: packages!.title ?? '',
//                     weight: "Semi Bold",
//                     clr: const Color(0xff00557E),
//                   ),
//                   const Spacer(),
//                   Padding(
//                     padding: EdgeInsets.only(right: 0.w),
//                     child: const Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.black,
//                       size: 25,
//                     ),
//                   )
//                 ],
//               )
//                   :
//               MyText(
//                 title: packages!.subTitle ?? '',
//                 clr:  controller.selectedIndex.value != index? const Color(0xff00557E):Colors.white,
//               ),
//             ),
//           ),
//           if(controller.selectedIndex.value == index)
//             Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//               ),
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                       itemCount:
//                       packages!.viewMore==false?packages!.packages!.length:
//                       packages!.packages!.length > 4 ? 4 : packages!
//                           .packages!.length,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (BuileContext, int index) {
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: .65.h),
//                               child: const Icon(
//                                 Icons.radio_button_unchecked_outlined,
//                                 size: 9,
//                                 color: Color(0xff00557E),
//                               ),
//                             ),
//                             SizedBox(width: 3.w,),
//                             Expanded(
//                               child: MyText(
//                                 title: packages!.packages![index],
//                                 clr: const Color(0xff858585),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                     if(packages!.viewMore!=false)
//                     SizedBox(height: 5.w,),
//                     if(packages!.viewMore!=false)
//                     InkWell(
//                       onTap: () {
//                         print("Tapped");
//                         controller.currentPackage.value = packages!;
//                         Get.to(SubscriptionDetail(isDrawer: isDrawer,));
//                       },
//                       child: MyText(
//                         title: "View More".toUpperCase(),
//                         under: true,
//                         weight: "Semi Bold",
//                         clr: const Color(0xff00557E),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           if(controller.selectedIndex.value == index)
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: packages!.packageColor,
//                   borderRadius: const BorderRadius.vertical(
//                       bottom: Radius.circular(10)
//                   )
//               ),
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 3.5.w, vertical: 3.5.w),
//                 child: MyText(
//                     title: packages!.cost??'\$${packages!.monthly}/MONTH OR \$${packages!
//                         .yearly}/YEAR'
//                 ),
//               ),
//             ),
//         ],),
//       );
//     });
//   }
// }
