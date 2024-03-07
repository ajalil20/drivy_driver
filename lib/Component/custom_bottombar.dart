// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Controller/bottombar_controller.dart';
// import 'package:sizer/sizer.dart';
// import 'dart:async';
//
// import '../Controller/global_controller.dart';
// import '../Utils/enum.dart';
// import 'custom_text.dart';
//
// class CustomBottomBar extends StatefulWidget {
//   const CustomBottomBar({Key? key}) : super(key: key);
//
//   @override
//   State<CustomBottomBar> createState() => _CustomBottomBarState();
// }
//
// class _CustomBottomBarState extends State<CustomBottomBar> with TickerProviderStateMixin{
//   final BottomBarController controller = Get.put(BottomBarController());
//   late AnimationController _hideBottomBarAnimationController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _hideBottomBarAnimationController = AnimationController(
//       duration: Duration(milliseconds: 200),
//       vsync: this,
//     );
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _hideBottomBarAnimationController.dispose();
//     super.dispose();
//   }
//
//
//  @override
//   Widget build(BuildContext context) {
//     return
//       // BottomNavigationBar(
//       //   type: BottomNavigationBarType.fixed,
//       //   currentIndex: controller.currentIndex.value,
//       //   showUnselectedLabels: false,
//       //   selectedItemColor: Colors.red,
//       //   unselectedItemColor: Colors.white,
//       //   selectedFontSize: 0.0,
//       //   elevation: 0.0,
//       //   backgroundColor:Colors.blue, //.withOpacity(0.5),
//       //   onTap: (index) async {
//       //     controller.onTap(index, context);
//       //   },
//       //   items: controller.itemsAssitance.map((BottomNavModel item) {
//       //     return BottomNavigationBarItem(
//       //         icon:  Image.asset(
//       //           (GlobalController.values.userRole.value == UserRole.Dentist ||GlobalController.values.userRole.value == UserRole.Doctor )?
//       //           item.imagePath!:
//       //           item.imagePath!,
//       //           width: 6.w,//(controller.items[index].imageWidth?.w??4.w),
//       //           height:6.w,//(controller.items[index].imageHeight?.w??4.w),
//       //           scale: 2,
//       //         ),
//       //         label:''
//       //     );
//       //   }).toList(),
//       // );
//       Obx(() => AnimatedBottomNavigationBar.builder(
//       height: (9.h),
//         hideAnimationController: _hideBottomBarAnimationController,
//       itemCount:
//       (GlobalController.values.userRole.value == UserRole.Dentist ||GlobalController.values.userRole.value == UserRole.Doctor )?
//       controller.items.length:controller.itemsAssitance.length,
//       onTap: (index) async {
//         controller.onTap(index, context);
//       },
//       gapLocation: GapLocation.none,
//       notchSmoothness: NotchSmoothness.defaultEdge,
//       tabBuilder: (int index, bool isActive) {
//         final color = isActive ?Theme.of(context).primaryColorDark : Colors.white;
//         return  Padding(
//           padding:  EdgeInsets.symmetric(vertical:(.3.h),horizontal: (0.w) ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               isActive ?
//               CircleAvatar(backgroundColor: Theme.of(context).primaryColorDark,radius: 5,):
//               const SizedBox(),
//               Image.asset(
//                 (GlobalController.values.userRole.value == UserRole.Dentist ||GlobalController.values.userRole.value == UserRole.Doctor )?
//                 controller.items[index].imagePath!:
//                 controller.itemsAssitance[index].imagePath!,
//                 width: 6.w,//(controller.items[index].imageWidth?.w??4.w),
//                 height:6.w,//(controller.items[index].imageHeight?.w??4.w),
//                 scale: 2,
//                 color: color,
//               ),
//               MyText(title:
//               (GlobalController.values.userRole.value == UserRole.Dentist ||GlobalController.values.userRole.value == UserRole.Doctor )?
//               controller.items[index].name!:
//               controller.itemsAssitance[index].name!,size: 8,weight: "Semi Bold",clr: isActive ?Theme.of(context).primaryColorDark:Colors.white ),
//
//             ],
//           )
//         );
//       },
//       activeIndex: controller.currentIndex.value,
//       backgroundColor: Theme.of(context).primaryColor,
//     ),);
//   }
// }