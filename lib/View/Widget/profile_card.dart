// import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
// import 'package:drivy_driver/Component/custom_icon_container.dart';
// import 'package:drivy_driver/Component/custom_image.dart';
// import 'package:drivy_driver/Component/custom_padding.dart';
// import 'package:drivy_driver/Component/custom_refresh.dart';
// import 'package:drivy_driver/Controller/global_controller.dart';
// import 'package:drivy_driver/Utils/enum.dart';
// import 'package:drivy_driver/Utils/my_colors.dart';
// import 'package:drivy_driver/View/Widget/bordered_container.dart';
// import 'package:drivy_driver/View/Widget/profile_card.dart';
// import 'package:drivy_driver/View/Widget/search_tile.dart';
//
// import 'package:drivy_driver/View/Widget/view_all_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:drivy_driver/View/base_view.dart';
// import '../../../Utils/image_path.dart';
// import '../../Component/custom_text.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// class ProfileCard extends StatelessWidget {
//   ProfileCard({super.key,this.isSeller=false});
//   bool isSeller;
//   @override
//   Widget build(BuildContext context) {
//     bool user=GlobalController.values.userRole.value == UserRole.user;
//     print(user);
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       elevation: 3,
//       color: MyColors().whiteColor,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           // color: Colors.pink
//         ),
//         padding: EdgeInsets.all(2.5 .w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CircleAvatar(
//                   radius:3.5.h,
//                   backgroundColor: MyColors().pinkColor,
//                   child: CircleAvatar(
//                     radius:3.3.h,
//                     backgroundColor: MyColors().whiteColor,
//                     child: CustomImage(
//                       height: 6.5.h,
//                       width: 6.5.h,
//                       isProfile: true,
//                       photoView: false,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Column(
//                       children: [
//                         const MyText(title: '54K',size: 16,fontWeight: FontWeight.w600,line: 1,),
//                         const MyText(title: 'Followers',size: 14,fontWeight: FontWeight.w400,line: 1,),
//                       ],
//                     ),
//                     SizedBox(width: 3.w,),
//                     Column(
//                       children: [
//                         const MyText(title: '519',size: 16,fontWeight: FontWeight.w600,line: 1,),
//                         const MyText(title: 'Following',size: 14,fontWeight: FontWeight.w400,line: 1,),
//                       ],
//                     ),
//                   ],
//                 ),
//
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(1.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const MyText(title: 'Jay Smith',size: 14,fontWeight: FontWeight.w600,line: 1,),
//                   if(user && isSeller)...[
//                     MyText(title: 'Seller',size: 12,fontWeight: FontWeight.w500,line: 1,fontStyle: FontStyle.italic,),
//                     MyText(title: 'Lorem ipsum dolor sit amet, consectetur adip iscing elit, sed do eiusmod tempor incididunt ut. Lorem ipsum dolor sit amet, consectetur adip iscing elit, sed do eiusmod tempor incididunt ut.',size: 12,fontWeight: FontWeight.w500,line: 3,),
//                   ],
//                   if(!isSeller)...[
//                     MyText(title: 'Age : 29',size: 12,fontWeight: FontWeight.w500,line: 1,fontStyle: FontStyle.italic,),
//                     MyText(title: 'Email: jaysmith@example.com',size: 12,fontWeight: FontWeight.w500,line: 1,),
//                     MyText(title: 'Phone: +123-123-12374',size: 12,fontWeight: FontWeight.w500,line: 1,),
//                     MyText(title: 'Location: Lorem ipsum dummy, NY',size: 12,fontWeight: FontWeight.w500,line: 1,),
//                   ],
//
//                   MyText(title: 'Social Links:',size: 12,fontWeight: FontWeight.w500,line: 1,),
//                   Row(
//                     children: [
//                       Image.asset(ImagePath.facebookIcon,width: 5.w,color: MyColors().fbColor,),
//                       SizedBox(width: 1.w,),
//                       MyText(title: 'www.facebook.com/jay_smith',size: 12,fontWeight: FontWeight.w500,line: 1,under: true,),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Image.asset(ImagePath.twitterIcon,width: 5.w,color: MyColors().twitterColor,),
//                       SizedBox(width: 1.w,),
//                       MyText(title: 'www.twitter.com/jay_smith',size: 12,fontWeight: FontWeight.w500,line: 1,under: true),
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//             // SizedBox(height: 0.5.h),
//
//           ],),
//       ),
//     );
//   }
// }
