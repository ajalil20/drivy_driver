// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import '../../Component/custom_text.dart';
// import '../../Utils/image_path.dart';
// import '../Chat/chatting.dart';
// import 'package:get/get.dart';
//
// class MessageCard extends StatelessWidget {
//   const MessageCard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Get.to( ChatScreen("a1","s"));
//       },
//       child: Container(
//           width: 100.w,
//           padding: EdgeInsets.symmetric(
//               horizontal: 1.h,
//               vertical: 1.25.h),
//           margin: EdgeInsets.only(
//               bottom: 2.h)+EdgeInsets.symmetric(
//             horizontal: 5.w,
//           ),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(100),
//               border: Border.all(
//                   color: Theme
//                       .of(context)
//                       .hintColor
//                       .withOpacity(.1)
//               )
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment
//                 .center,
//             children: [
//               const CircleAvatar(
//                   // radius: 51.0,
//                   backgroundImage: AssetImage(ImagePath.randomImage)
//               ),
//               // Container(
//               // // height: 3.8.w,
//               // // width: 2.h,
//               //   // margin: EdgeInsets.symmetric(horizontal: responsive.setWidth(3),vertical: responsive.setHeight(0)),
//               //     padding: EdgeInsets.symmetric(
//               //         horizontal: 3.8.w,
//               //         vertical: 2.h
//               //     ),
//               //     decoration: BoxDecoration(
//               //         color: Theme
//               //             .of(context)
//               //             .hintColor
//               //             .withOpacity(0.1),
//               //         borderRadius: BorderRadius
//               //             .circular(100)
//               //     ),
//               //     // alignment: Alignment.center,
//               //     child: Image.asset(ImagePath.randomImage,
//               //       height: 2.h,
//               //       width: 2.h,fit: BoxFit.fill,)),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 3.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment
//                         .start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const MyText(title: "John Smith",
//                         clr: Colors.black,),
//                       MyText(
//                         title: "Yesterday",
//                         weight: "Bold",
//                         clr: Theme
//                             .of(context)
//                             .primaryColorLight,
//                         line: 1,),
//                     ],
//                   ),
//                 ),
//               ),
//             ],)
//       ),
//     );
//   }
// }
