// import 'package:drivy_driver/Utils/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import '../../../Utils/image_path.dart';
// import 'package:get/get.dart';
//
// import '../notifications.dart';
//
// class NotificationTile extends StatelessWidget {
//    NotificationTile({Key? key}) : super(key: key);
//   Responsive responsive = Responsive();
//
//   @override
//   Widget build(BuildContext context) {
//     responsive.setContext(context);
//     return  GestureDetector(
//       onTap: (){
//         Get.to
//           (Notifications(),transition: Transition.leftToRight,duration:const Duration(milliseconds: 300));
//         // Get.to(Notifications());
//       },
//       child: Container(
//         height: responsive.setHeight(5.5),
//         alignment: Alignment.center,
//         padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(3.8), vertical: responsive.setHeight(1.2)),
//         margin: EdgeInsets.only(right: responsive.setWidth(3.8)),
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(ImagePath.notificationLogo)
//             )
//         ),
//       ),
//     );
//   }
// }
