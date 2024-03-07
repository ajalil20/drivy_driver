// import 'package:drivy_driver/Component/custom_text.dart';
// import 'package:drivy_driver/View/Widget/rating.dart';
// import 'package:flutter/material.dart';
//
// class GiveReview extends StatelessWidget {
//   GiveReview({required this.id,required this.index,required this.requestID,required this.refreshData});
//   String id;
//   String requestID;
//   int index;
//   Function refreshData;
//   @override
//   Widget build(BuildContext context) {
//     return  GestureDetector(
//       onTap: () {
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 backgroundColor: Colors.transparent,
//                 contentPadding: const EdgeInsets.fromLTRB(
//                     0, 0, 0, 0),
//                 content: RatingAlert(id: id,index: index,requestID: requestID,refreshData: refreshData,),
//               );
//             }
//         );
//       },
//       child: MyText(
//         title:"GIVE REVIEW",
//         under: true,
//         size: 13,
//         clr:  Theme.of(context).primaryColorDark,
//         weight: "Semi Bold",
//       ),
//     );
//   }
// }
