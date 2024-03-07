// import 'package:drivy_driver/Component/custom_empty_data.dart';
// import 'package:drivy_driver/Component/custom_text.dart';
// import 'package:drivy_driver/Controller/home_controller.dart';
// import 'package:drivy_driver/Utils/image_path.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// class CoursesList extends StatefulWidget {
//   CoursesList({Key? key,this.onTap,required this.i}) : super(key: key);
//   Function? onTap;
//   int i = 10000;
//
//   @override
//   State<CoursesList> createState() => _CoursesListState();
// }
//
// class _CoursesListState extends State<CoursesList> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Obx(()=>
//           HomeController.i.sortedCourse.isEmpty? CustomEmptyData(title: "No courses",image: ImagePath.noCourse,):
//           ListView.builder(
//           itemCount: HomeController.i.sortedCourse.length,
//           shrinkWrap: true,
//           physics: BouncingScrollPhysics(),
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: 2.w),
//               child: GestureDetector(
//                 onTap: () {
//                   widget.i = index;
//                   print(HomeController.i.sortedCourse);
//                   HomeController.i.currentCourse.value=HomeController.i.sortedCourse[index];
//                   if(widget.onTap!=null){widget.onTap!();}
//                   setState(() {});
//                   print(widget.i);
//                 },
//                 child: ClipPath(
//                   clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color:widget.i != index ? Colors.white : Theme.of(context).primaryColor,
//                       border:widget.i == index ?null: Border(right: BorderSide(color: Theme.of(context).primaryColorDark, width: 15)),
//                     ),
//                     child:
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 3.w,horizontal: 3.w),
//                       child: Row(
//                         children: [
//                           MyText(
//                             title:HomeController.i.sortedCourse[index].startTime??"",
//                             size: 13,
//                             clr: widget.i == index ? Colors.white : Theme.of(context).primaryColor,
//                           ),
//                           SizedBox(width: 5.w,),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MyText(
//                                   title:HomeController.i.sortedCourse[index].courseName??"",
//                                   size: 13,
//                                   clr: widget.i == index ? Colors.white : const Color(0xff282828),
//                                 ),
//                                 if(HomeController.i.sortedCourse[index].location!=null)...[
//                                   if(HomeController.i.sortedCourse[index].location!.location!=null)...[
//                                     MyText(
//                                       title: HomeController.i.sortedCourse[index].location!.location??"",
//                                       size: 13,
//                                       clr: widget.i == index ? Colors.white : const Color(0xff282828),
//                                     ),
//                                   ]
//                                 ]
//
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
