// import 'package:flutter/material.dart';
// import 'package:drivy_user/Controller/home_controller.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';
// import '../../Utils/utils.dart';
//
// class HorizontalCalendar extends StatefulWidget {
//   HorizontalCalendar({Key? key}) : super(key: key);
//   @override
//   State<HorizontalCalendar> createState() => _HorizontalCalendarState();
// }
//
// class _HorizontalCalendarState extends State<HorizontalCalendar> {
//   DateTime? selectedDay; // = DateTime.now();
//   DateTime focusedDay = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     return TableCalendar(
//       focusedDay: DateTime.now(),
//       lastDay: DateTime(2050),
//       firstDay: DateTime.now(),
//       daysOfWeekHeight: 4.5.h,
//       calendarFormat: CalendarFormat.week,
//       startingDayOfWeek: StartingDayOfWeek.sunday,
//       daysOfWeekVisible: true,
//       onDaySelected: (DateTime selectDay,
//           DateTime focusDay) async {
//         setState(() {
//           selectedDay = selectDay;
//           focusedDay = focusDay;
//         });
//         String date=Utils.formatChatTimeMethod(createdDate: focusedDay.toString(),format: "yyyy-mm-dd").toString();
//         await HomeController.i.getCourseByDate(date: date);
//         setState(() {});
//       },
//       selectedDayPredicate: (DateTime date) {
//         return isSameDay(selectedDay, date);
//       },
//       calendarStyle: CalendarStyle(
//         outsideDecoration: BoxDecoration(
//             color: Theme
//                 .of(context)
//                 .hintColor
//                 .withOpacity(0.1),
//             shape: BoxShape.circle,
//             borderRadius: null
//         ),
//         isTodayHighlighted: true,
//         selectedDecoration: BoxDecoration(
//           color: Theme.of(context).primaryColor,
//           shape: BoxShape.rectangle,
//           // borderRadius: BorderRadius.circular(5.0),
//         ),
//         selectedTextStyle: const TextStyle(color: Colors.white),
//         todayDecoration: BoxDecoration(
//           color: Theme
//               .of(context)
//               .primaryColor,
//           shape: BoxShape.rectangle,
//           // borderRadius: null
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         // defaultDecoration: BoxDecoration(
//         //     color: Theme
//         //         .of(context)
//         //         .hintColor
//         //         .withOpacity(0.1),
//         //     shape: BoxShape.circle,
//         //     borderRadius: null
//         // ),
//         // weekendDecoration: BoxDecoration(
//         //     color: Theme
//         //         .of(context)
//         //         .hintColor
//         //         .withOpacity(0.1),
//         //     shape: BoxShape.circle,
//         //     borderRadius: null
//         // ),
//       ),
//       calendarBuilders: CalendarBuilders(
//         dowBuilder: (context, day) {
//           final text = DateFormat.E().format(day);
//           return Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 6.0, vertical: 0),
//             child: CircleAvatar(
//               radius: 17,
//               backgroundColor: Colors.transparent,
//               child: Text(
//                 text[0] + text[1].toUpperCase(),
//                 style: TextStyle(color: Theme
//                     .of(context)
//                     .primaryColor,
//                     fontSize: 13
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       headerVisible: false,
//     );
//   }
// }
