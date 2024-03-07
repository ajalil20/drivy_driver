// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
// import 'package:drivy_driver/Controller/home_controller.dart';
// import 'package:drivy_driver/Utils/my_colors.dart';
//
// import '../Utils/app_strings.dart';
//
// class HorizontalCalendar extends StatelessWidget {
//   HorizontalCalendar({Key? key,this.selectedDate,required this.currentDate}) : super(key: key);
//   Function(String,String)? selectedDate;
//   Rx<DateTime> currentDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return  SizedBox(
//       height: 100,
//       child: Obx(()=> AnimatedHorizontalCalendar(
//             tableCalenderButtonColor:  MyColors().purpleColor,
//             selectedBoxShadow: BoxShadow(
//               color: Colors.grey.withOpacity(0.25),
//               spreadRadius: 0.0,
//               blurRadius: 10,
//               offset: const Offset(0, 4), // changes position of shadow
//             ),
//             unSelectedBoxShadow: BoxShadow(
//               color: Colors.blue.withOpacity(0.0),
//               spreadRadius: 2.0,
//               blurRadius: 10,
//               offset: const Offset(0, 4), // changes position of shadow
//             ),
//             tableCalenderIcon: Icon(
//               Icons.calendar_today,
//               color: MyColors().whiteColor,
//             ),
//             date:currentDate.value,//??DateTime.now(),
//             initialDate: DateTime.now().subtract(const Duration(days: 7)),
//             lastDate: DateTime.now().add(const Duration(days: 365)),
//             colorOfMonth: Colors.black,
//             colorOfWeek: Colors.black,
//             backgroundColor: MyColors().whiteColor,
//             selectedColor: MyColors().purpleColor,
//             onDateSelected: (date, day) {selectedDate!( DateFormat(AppStrings.YYYY_MM_DD).format(DateTime.parse(date)).toString(),DateFormat(AppStrings.YEAR_MONTH_DATE).format(DateTime.parse(date)).toString());}
//         ),
//       ),
//     );
//   }
// }
