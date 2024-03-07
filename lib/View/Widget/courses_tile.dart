// import 'package:drivy_user/Controller/home_controller.dart';
// import 'package:drivy_user/Utils/app_strings.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Component/custom_image.dart';
// import '../../Component/custom_text.dart';
// import '../../Model/courses_model.dart';
// import '../../Utils/utils.dart';
// import '../Courses/course_detail.dart';
// import 'package:sizer/sizer.dart';
//
// class CoursesTile extends StatelessWidget {
//   CoursesTile({Key? key,required this.c,this.registered,this.margin}) : super(key: key);
//   Courses c;
//   bool? registered;
//   EdgeInsetsGeometry? margin;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Get.to(CourseDetail(registered: registered,));
//         HomeController.i.currentCourse.value=c;
//         if(registered==true){
//           HomeController.i.selectedEnrollCoursesIndex.value=0;
//         }
//       },
//       child: Container(
//         // width: 42.w,
//           margin: margin??EdgeInsets.symmetric(horizontal: 5.w),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10)
//           ),
//           child:  Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
//                     child: CustomImage(url:c.courseImage,height:  19.h,photoView: false,)
//                 ),
//               ),
//               Padding(
//                 // padding: EdgeInsets.symmetric(vertical: 3.w,horizontal: 3.w),
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MyText(title:c.courseName??"",size: 14,weight: "Semi Bold",clr:  const Color(0xff282828)),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         if(c.courseType!=AppStrings.ONLINE_COURSE)...[
//                           Icon(
//                             Icons.calendar_month_outlined,
//                             color: Theme.of(context).primaryColor,
//                             size: 15,
//                           ),
//                           const SizedBox(width: 3,),
//                           MyText(title:Utils().formattedDate(c.startDate??""),
//                               size: 12,
//                               weight: "Semi Bold",
//                               line: 1,
//                               toverflow: TextOverflow.ellipsis,
//                               clr: Color(0xff858585)),
//                           const SizedBox(width: 3,),
//                         ],
//                         if(c.location!=null)...[
//                           if(c.location!.location!=null)...[
//                             Icon(
//                               Icons.location_on,
//                               color: Theme
//                                   .of(context)
//                                   .primaryColor,
//                               size: 15,
//                             ),
//                             const SizedBox(width: 3,),
//                             Expanded(
//                               child: MyText(title:c.location!.location??"",
//                                   size: 12,
//                                   weight: "Semi Bold",
//                                   line: 1,
//                                   toverflow: TextOverflow.ellipsis,
//                                   clr: Color(0xff858585)),
//                             )]
//                         ]  ,
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//       ),
//     );
//   }
// }
