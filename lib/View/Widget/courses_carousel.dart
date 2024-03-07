// import 'package:drivy_driver/Component/custom_buttom.dart';
// import 'package:drivy_driver/Component/custom_html_text.dart';
// import 'package:drivy_driver/Component/custom_image.dart';
// import 'package:drivy_driver/Component/custom_text.dart';
// import 'package:drivy_driver/Controller/home_controller.dart';
// import 'package:drivy_driver/Utils/image_path.dart';
// import 'package:drivy_driver/View/Courses/course_detail.dart';
// import 'package:drivy_driver/View/Widget/patient_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../Component/custom_empty_data.dart';
// import '../../Utils/app_strings.dart';
//
// class CoursesCarousel extends StatefulWidget {
//   const CoursesCarousel({Key? key}) : super(key: key);
//
//   @override
//   State<CoursesCarousel> createState() => _CoursesCarouselState();
// }
//
// class _CoursesCarouselState extends State<CoursesCarousel> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // loadCourse();
//   }
//   loadCourse() async {
//    await HomeController.i.getCoursesAll(courseType: AppStrings.ONLINE_COURSE);
//    setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(()=>
//         HomeController.i.coursesAll.isEmpty?
//         Expanded(child: CustomEmptyData(title: "No courses",image: ImagePath.noCourse,)):
//         Column(
//         children: [
//           SizedBox(height: 1.h),
//           CarouselSlider(
//             options: CarouselOptions(
//                 height: 55.h,
//                 viewportFraction: 1.0,
//                 enlargeCenterPage: false,
//                 autoPlay: true,
//                 onPageChanged: (index, reason) {
//                   HomeController.i.currentCourseIndex = index;
//                   setState(() {});
//                 }
//             ),
//             items: HomeController.i.coursesAll.map((item) => PatientTile(
//               imageHeight:25.h,
//               width: 90.w,
//               paddingRight: 0,
//               image: item.courseImage,
//               child: Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical: 3.w, horizontal: 3.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             MyText(title: item.courseName??"",
//                                 size: 14,
//                                 weight: "Semi Bold",
//                                 clr: const Color(0xff282828)),
//                             SizedBox(height: .5.h),
//                             Expanded(
//                               child: CustomHtmlText(text:item.courseDetails??"",
//                                 line:7,
//                                 txtOverflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             SizedBox(height: 1.h),
//
//                             // Expanded(
//                             //   child: MyText(title:
//                             //   item.courseDetails??"",
//                             //       line: 7,
//                             //       size: 12,
//                             //       weight: "Semi Bold",
//                             //       toverflow: TextOverflow.ellipsis,
//                             //       clr: Color(0xff858585)),
//                             // ),
//
//                           ],
//                         ),
//                       ),
//                       const MyText(
//                           title: "Trainer:",
//                           size: 14,
//                           weight: "Semi Bold",
//                           clr: Color(0xff282828)),
//                       SizedBox(height: .5.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           CustomImage(
//                             url: item.directorImage,height: 15.w,
//                             fit: BoxFit.cover,
//                             width: 15.w,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           Container(
//                             width:  2.w,),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MyText(
//                                     title:  item.directorName??"",
//                                     size: 14,
//                                     weight: "Semi Bold",
//                                     clr: Color(0xff282828)),
//                                 SizedBox(height: .5.h),
//                                 MyText(title: item.directorQualification??"",
//                                     size: 12,
//                                     weight: "Semi Bold",
//                                     under: true,
//                                     clr: Color(0xff858585)),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             children: [
//                               SizedBox(height: 2.h,),
//                               Row(
//                                 children: [
//                                   const MyText(
//                                       title: "Cost: ",
//                                       size: 14,
//                                       weight: "Semi Bold",
//                                       clr: Color(0xff282828)),
//                                   MyText(
//                                       title:"\$${item.coursePrice?.toStringAsFixed(2)}",
//                                       size: 14,
//                                       under: true,
//                                       weight: "Semi Bold",
//                                       clr: Theme
//                                           .of(context)
//                                           .primaryColor),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           MyButton(title: "Enroll",
//                             height: 5.h,
//                             fontSize: 14,
//                             width: 25.w,onTap: (){
//                               HomeController.i.selectedEnrollCoursesIndex.value=2;
//                               HomeController.i.currentCourse.value=item;
//                               Get.to(CourseDetail());
//                             },)
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//                 .toList(),
//           ),
//           SizedBox(height: 3.h),
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: HomeController.i.coursesAll.asMap().entries.map((entry) {
//           //     return GestureDetector(
//           //       onTap: () => HomeController.i.carouselController.value.animateToPage(entry.key),
//           //       child: Container(
//           //         width:  HomeController.i.currentCourseIndex == entry.key?13.0:8,
//           //         height:   HomeController.i.currentCourseIndex == entry.key?13.0:8,
//           //         margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//           //         decoration: BoxDecoration(
//           //             shape: BoxShape.circle,
//           //             color:  HomeController.i.currentCourseIndex == entry.key
//           //                 ? Colors.transparent
//           //                 : Theme.of(context).primaryColor,
//           //             // .withOpacity(_current == entry.key ? 0.9 : 0.4)
//           //             border: Border.all(
//           //               color:  HomeController.i.currentCourseIndex == entry.key? Colors.black:Theme.of(context).primaryColor,
//           //             )
//           //         ),
//           //       ),
//           //     );
//           //   }).toList(),
//           // ),
//         ],
//       ),
//     );
//   }
// }