// import 'package:drivy_driver/Controller/home_controller.dart';
// import 'package:drivy_driver/Utils/my_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import '../../Component/custom_buttom.dart';
// import '../../Component/custom_text.dart';
// import '../../Component/custom_textfield.dart';
// import '../../Utils/responsive.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// class RatingAlert extends StatelessWidget {
//   RatingAlert({required this.id,required this.index,required this.requestID,required this.refreshData});
//   String id,requestID;
//   int index;
//   Responsive responsive = Responsive();
//   RxDouble rate =0.0.obs;
//   Function refreshData;
//   TextEditingController feedback = TextEditingController();
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
//                     // color: Theme.of(context).primaryColorDark,
//                     borderRadius: BorderRadius.vertical(
//                         top: Radius.circular(20)
//                     )),
//
//                 child: ListTile(
//                     title: Center(child: Align(
//                       alignment: const Alignment(.2, 0),
//                       child: MyText(title: "RATINGS",clr:Theme.of(context).primaryColor,center: true,weight: "Semi Bold",),)),
//                     trailing:GestureDetector(
//                         onTap: (){Get.back();},
//                         child: Icon(Icons.cancel,color:Theme.of(context).primaryColorDark,))
//                 )
//               // Align(
//               //   alignment: Alignment.center,
//               //   child: Row(
//               //     children: [
//               //       Spacer(),
//               //       MyText(title: "title",center: true,),
//               //       Spacer(),
//               //       IconButton(onPressed: (){
//               //         Get.back();
//               //       }, icon: Icon(Icons.cancel,color: Colors.white,)),
//               //     ],
//               //   ),
//               // ),
//             ),
//
//
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(8)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: responsive.setHeight(2),
//                   ),
//                   Stack(
//                     children: [
//                       Center(
//                         child: Card(
//                             color: Colors.white,
//                             // elevation: 10,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: Row(
//                               children: [
//                                 SizedBox(width: 15.w),
//                                 Container(
//                                     alignment: Alignment.center,
//                                     padding: EdgeInsets.all(2.w),
//                                     // margin: EdgeInsets.only(left:4.w),
//                                     child: RatingBar.builder(
//                                       initialRating: rate.value,
//                                       minRating: 0,
//                                       itemSize:25,
//                                       direction: Axis.horizontal,
//                                       allowHalfRating: true,
//                                       updateOnDrag: true,
//                                       itemCount: 5,
//                                       glowColor:Colors.amber,
//                                       unratedColor: MyColors().hintColor,
//                                       itemPadding: EdgeInsets.symmetric(horizontal: .4.w),
//                                       itemBuilder: (context, _) => const Icon(
//                                         Icons.star,
//                                         color: Colors.amber,
//                                       ),
//                                       onRatingUpdate: (rating) {
//                                         rate.value=rating;
//                                         rate.refresh();
//                                         print(rate);
//                                       },
//                                     ))
//
//                               ],
//                             )
//                         ),
//                       ),
//                       CircleAvatar(backgroundColor: Theme.of(context).primaryColor,
//                         radius: 33,
//                         child: Obx(()=> MyText(title: "${rate.value}",weight: "Semi Bold",)),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 2.h,),
//                   const Divider(),
//                   SizedBox(height: 2.h,),
//
//                   const MyText(
//                     title: "FEEDBACK:",
//                     clr: Colors.black,
//                     weight: "Semi Bold",
//                     size: 13,
//                   ),
//                   SizedBox(
//                     height: responsive.setHeight(1),
//                   ),
//
//                   MyTextField(
//                     height: 15.h,
//                     // backgroundColor:Colors.redAccent,
//                     minLines: 5,
//                     maxLines: 5,
//                     borderColor: Theme.of(context).hintColor.withOpacity(.1),
//                     width: 90.w,
//                     showLabel: false,
//                     hintText: "Share your feedback here",
//                     controller: feedback,
//                   ),
//
//                   SizedBox(
//                     height: responsive.setHeight(3.5),
//                   ),
//                   MyButton(
//                     onTap: (){onSubmit();},
//                     title: "SUBMIT"
//                   ),
//                   SizedBox(
//                     height: responsive.setHeight(3.5),
//                   ),
//                 ],
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//   onSubmit(){
//     Get.back();
//     HomeController.i.rating=rate.value.toString();
//     HomeController.i.feedback=feedback.text;
//     HomeController.i.giveReview(onSuccess: (){
//       refreshData();
//     }, id: id,index: index,requestID: requestID);
//   }
//  }
