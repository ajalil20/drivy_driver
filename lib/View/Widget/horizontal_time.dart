// import 'package:drivy_user/Component/custom_text.dart';
// import 'package:drivy_user/Controller/home_controller.dart';
// import 'package:drivy_user/Model/selected_time.dart';
// import 'package:drivy_user/View/home_view.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';
//
// import '../../Utils/my_colors.dart';
//
// class HorizontalTime extends StatefulWidget {
//   HorizontalTime({Key? key,required this.onTap}) : super(key: key);
//   Function onTap;
//   @override
//   State<HorizontalTime> createState() => _HorizontalTimeState();
// }
//
// class _HorizontalTimeState extends State<HorizontalTime> {
//   RxInt i = 0.obs;
//   // List<String> t = ["ALL","9 am","10 am","11 am","12 pm","1 pm","2 pm","3 pm","4 pm","5 pm","6 pm","7 pm","8 pm","9 pm","10 pm","11 pm","12 am","1 am","2 am","3 am","4 am","5 am","6 am","7 am","8 am",];
//   List<SelectedTimeModel> t = [
//     SelectedTimeModel(time: "ALL",isSelected: false),
//     SelectedTimeModel(time: "9 am",isSelected: false),
//     SelectedTimeModel(time: "10 am",isSelected: false),
//     SelectedTimeModel(time: "11 am",isSelected: false),
//     SelectedTimeModel(time: "12 pm",isSelected: false),
//     SelectedTimeModel(time: "1 pm",isSelected: false),
//     SelectedTimeModel(time: "2 pm",isSelected: false),
//     SelectedTimeModel(time: "3 pm",isSelected: false),
//     SelectedTimeModel(time: "4 pm",isSelected: false),
//     SelectedTimeModel(time: "5 pm",isSelected: false),
//     SelectedTimeModel(time: "6 pm",isSelected: false),
//     SelectedTimeModel(time: "7 pm",isSelected: false),
//     SelectedTimeModel(time: "8 pm",isSelected: false),
//     SelectedTimeModel(time: "9 pm",isSelected: false),
//     SelectedTimeModel(time: "10 pm",isSelected: false),
//     SelectedTimeModel(time: "11 pm",isSelected: false),
//     SelectedTimeModel(time: "12 am",isSelected: false),
//     SelectedTimeModel(time: "1 am",isSelected: false),
//     SelectedTimeModel(time: "2 am",isSelected: false),
//     SelectedTimeModel(time: "3 am",isSelected: false),
//     SelectedTimeModel(time: "4 am",isSelected: false),
//     SelectedTimeModel(time: "5 am",isSelected: false),
//     SelectedTimeModel(time: "6 am",isSelected: false),
//     SelectedTimeModel(time: "7 am",isSelected: false),
//     SelectedTimeModel(time: "8 am",isSelected: false),
//   ];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getCourseTime();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 9.h,
//       child: ListView.builder(
//         itemCount: t.length,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemBuilder: (BuildContext context, int index) {
//           return Obx(() {
//             return Padding(
//               padding: EdgeInsets.only(right: 2.w),
//               child: GestureDetector(
//                 onTap: () {
//                   i.value = index;
//                   HomeController.i.courseTime=t[index].time!;
//                   var time;
//                   if(HomeController.i.courseTime!="ALL"){
//                     time =  "${t[index].time!.split(' ')[0].length==1?'0${t[index].time!.split(' ')[0]}':t[index].time!.split(' ')[0]}:00 ${t[index].time!.split(' ')[1].toUpperCase()}";
//                   }
//                   print(t[index]);
//                   print(time);
//                   HomeController.i.sortCourseByTime(time: time);
//                   setState(() {});
//                   widget.onTap();
//                   i.refresh();
//                 },
//                 child: CircleAvatar(
//                   radius: 25,
//                   backgroundColor: (i.value == index) ? Theme.of(context).primaryColorDark:t[index].isSelected==true? MyColors().yellowColor : Colors.white,
//                   child: MyText(
//                     title: t[index].time!,
//                     size: 13,
//                     clr:(i.value == index || t[index].isSelected==true) ? Colors.white : Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//             );
//           });
//         },
//       ),
//     );
//   }
//   // getCourseTime(){
//   //   for(int i=0;i<HomeController.i.courses.length;i++)
//   //   {
//   //     for(int j=0;j<t.length;j++){
//   //       if(t[j].time!='ALL'){
//   //         String time ="${t[j].time!.split(' ')[0].length==1?t[j].time!.split(' ')[0]:t[j].time!.split(' ')[0]}:00 ${t[j].time!.split(' ')[1].toUpperCase()}";
//   //         if (time==HomeController.i.courses[i].startTime.toString()) {
//   //           t[j].isSelected=true;
//   //         }
//   //       }
//   //
//   //     }
//   //   }
//   // }
//   getCourseTime(){
//     for(int i=0;i<HomeController.i.courses.length;i++)
//     {
//       for(int j=0;j<t.length;j++){
//         if(t[j].time!='ALL'){
//           String time ="${t[j].time!.split(' ')[0].length==1?t[j].time!.split(' ')[0]:t[j].time!.split(' ')[0]} ${t[j].time!.split(' ')[1].toUpperCase()}";
//           String ctime ="${HomeController.i.courses[i].startTime.toString().split(':')[0]} ${HomeController.i.courses[i].startTime.toString().split(' ')[1]}";
//           if (time==ctime) {
//             t[j].isSelected=true;
//           }
//         }
//
//       }
//     }
//   }
//
// }
