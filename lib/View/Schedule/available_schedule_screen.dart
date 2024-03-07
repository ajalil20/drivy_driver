// import 'package:flutter/material.dart';
// import 'package:drivy_driver/Component/custom_horizontal_calender.dart';
// import 'package:timeline_list/timeline.dart';
// import 'package:timeline_list/timeline_model.dart';
//
// class AvailableScheduleScreen extends StatefulWidget {
//   AvailableScheduleScreen({super.key});
//
//   static Map<String, dynamic> list = {
//     "ScheduleList": [
//       {
//         'location': "Lorem Ipsum",
//         'startTime': "12:00 PM",
//         'endTime': "12:00 AM"
//       },
//       {
//         'location': "Lorem Ipsum",
//         'startTime': "01:00 PM",
//         'endTime': "02:00 PM"
//       },
//       {
//         'location': "Lorem Ipsum",
//         'startTime': "12:00 AM",
//         'endTime': "04:00 AM"
//       },
//       {
//         'location': "Lorem Ipsum",
//         'startTime': "11:00 PM",
//         'endTime': "12:30 PM"
//       },
//       {
//         'location': "Lorem Ipsum",
//         'startTime': "03:30 PM",
//         'endTime': "12:00 AM"
//       },
//       {
//         'location': "Lorem Ipsum",
//         'startTime': "12:00 PM",
//         'endTime': "12:00 PM"
//       },
//     ],
//   };
//
//   @override
//   State<AvailableScheduleScreen> createState() =>
//       _AvailableScheduleScreenState();
// }
//
// class _AvailableScheduleScreenState extends State<AvailableScheduleScreen> {
//   int length = AvailableScheduleScreen.list['ScheduleList'].length;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               const Text(
//                 "Available Schedule",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // HorizontalCalendar(
//               //   selectedDate: (value) {
//               //     print("value $value");
//               //     if (value == "Sunday September, 10 2023") {
//               //       setState(() {
//               //         length = 3;
//               //         print(length);
//               //       });
//               //     } else if (value == "Tuesday September, 12 2023") {
//               //       setState(() {
//               //         length = 5;
//               //         print(length);
//               //       });
//               //     } else if (value == "Thursday September, 14 2023") {
//               //       setState(() {
//               //         length = 1;
//               //         print(length);
//               //       });
//               //     } else if (value == "Saturday September, 16 2023") {
//               //       setState(() {
//               //         length = 2;
//               //         print(length);
//               //       });
//               //     } else {
//               //       setState(() {
//               //         length =
//               //             AvailableScheduleScreen.list['ScheduleList'].length;
//               //       });
//               //     }
//               //   },
//               // ),
//               const SizedBox(height: 10),
//               _timeLine(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _timeLine() {
//     return Expanded(
//       child: Timeline.builder(
//         position: TimelinePosition.Left,
//         iconSize: 15,
//         lineColor: Colors.grey,
//         itemBuilder: (BuildContext context, int index) {
//           return TimelineModel(
//             _container(
//               location: AvailableScheduleScreen.list['ScheduleList'][index]
//                   ['location'],
//               startTime: AvailableScheduleScreen.list['ScheduleList'][index]
//                   ['startTime'],
//               endTime: AvailableScheduleScreen.list['ScheduleList'][index]
//                   ['endTime'],
//             ),
//             icon: Icon(
//               index == 0 ? Icons.panorama_fisheye_sharp : Icons.lens_outlined,
//               color: index == 0 ? Colors.white : Colors.pink,
//             ),
//             iconBackground: index == 0 ? Colors.pink : Colors.white,
//           );
//         },
//         itemCount: length,
//       ),
//     );
//   }
//
//   Widget _container({String? location, String? startTime, String? endTime}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Align(
//         alignment: Alignment.topLeft,
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.grey,
//                 offset: Offset(
//                   1.0,
//                   1.0,
//                 ),
//                 blurRadius: 10.0,
//                 spreadRadius: 0,
//               ),
//             ],
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   location!,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "Start Time $startTime",
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 12,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "End Time $endTime",
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
