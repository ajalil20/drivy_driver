// import 'package:flutter/material.dart';
// import 'package:drivy_driver/Utils/responsive.dart';
//
// import '../../Component/custom_text.dart';
// import '../../Utils/image_path.dart';
//
// class NotificationCard extends StatelessWidget {
//   NotificationCard({Key? key}) : super(key: key);
//   Responsive responsive = Responsive();
//
//   @override
//   Widget build(BuildContext context) {
//     responsive.setContext(context);
//     return GestureDetector(
//       onTap: (){
//
//         // Navigator.of(context).push(CustomPageRoute(child: TaskDetails()));
//       },
//       child: Container(
//           width: responsive.setWidth(100),
//           padding: EdgeInsets.symmetric(
//               horizontal: responsive.setHeight(1),
//               vertical: responsive.setHeight(1.25)),
//           margin: EdgeInsets.only(
//               bottom: responsive.setHeight(2))+EdgeInsets.symmetric(
//             horizontal: responsive.setWidth(5),
//           ),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(
//                   color: Theme
//                       .of(context)
//                       .hintColor
//                       .withOpacity(.1)
//               )
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment
//                 .start,
//             children: [
//               const CircleAvatar(
//
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: responsive.setWidth(
//                           3),
//                       vertical: responsive.setHeight(
//                           0)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment
//                         .start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//
//                       MyText(
//                         title: "Lorem ipsum dolor sit amet. Aut quis maiores qui molestiae odit ut amet galisum. Et aliquam recusandae sit recusandae autem eum excepturi officiis et dignissimos nobis qui consequatur nostrum sed quaerat praesentium non repudiandae illo. Et fugit temporibus sit numquam fugiat non impedit modi placeat animi rem aliquid voluptatibus et aspernatur saepe sit eaque expedita! Error consequatur laboriosam mollitia eum expedita praesentium eos facilis quasi nam illo asperiores qui adipisci nihil.",
//                         weight: "Bold",
//                         clr: Theme
//                             .of(context)
//                             .primaryColorLight,
//                         line: 2,),
//                       SizedBox(height: responsive.setHeight(0.7),),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           MyText(title: "Jan 21, 2022",
//                             size: 13,
//                             clr: Theme.of(context).hintColor,),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.watch_later_outlined,
//                                 size: 15,
//                                 color: Theme
//                                     .of(context)
//                                     .primaryColorDark,
//                               ),
//                               MyText(title: " 12:00",
//                                 size: 13,
//                                 clr: Theme.of(context).hintColor,),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],)
//       ),
//     );
//   }
// }
