// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:logger/logger.dart';
// import 'package:my_therapists/auth/provider/user_provider.dart';
// import 'package:my_therapists/core/payment/routing_arguments/booking_routing_arguments.dart';
// import 'package:my_therapists/core/schedule/blocs/get_slots_bloc.dart';
// import 'package:my_therapists/core/schedule/models/masseurs_listing.dart';
// import 'package:my_therapists/core/schedule/models/slots_model.dart';
// import 'package:my_therapists/core/schedule/widgets/slot_widget.dart';
// import 'package:my_therapists/utils/app_colors.dart';
// import 'package:my_therapists/utils/app_dialogs.dart';
// import 'package:my_therapists/utils/constants.dart';
// import 'package:my_therapists/utils/routing/app_navigation.dart';
// import 'package:my_therapists/utils/routing/app_route_name.dart';
// import 'package:my_therapists/utils/static_data.dart';
// import 'package:my_therapists/utils/strings/app_strings.dart';
// import 'package:my_therapists/widgets/appbar.dart';
// import 'package:my_therapists/widgets/custom_diaog.dart';
// import 'package:my_therapists/widgets/custom_loader.dart';
// import 'package:my_therapists/widgets/custom_text.dart';
// import 'package:my_therapists/widgets/no_data_found.dart';
// import 'package:my_therapists/widgets/simple_button.dart';
// import 'package:provider/provider.dart';
// ​
// class ScheduleTimeScreen extends StatefulWidget {
//   final List<String?>? bookingIds;
//   final String? serviceName,
//       date,
//       serviceId,
//       slotId,
//       serviceImagePath,
//       amount,
//       bio;
//   final String? slotDuration;
//   final bool? isAMP;
//   final MasseurListData? masseurDetail;
//
//   const ScheduleTimeScreen(
//       {super.key,
//         this.bookingIds,
//         this.masseurDetail,
//         this.date,
//         this.serviceName,
//         this.serviceId,
//         this.slotId,
//         this.serviceImagePath,
//         this.amount,
//         this.bio,
//         this.slotDuration,
//         this.isAMP});
//   ​
//   @override
//   _ScheduleTimeScreenState createState() => _ScheduleTimeScreenState();
// }
// ​
// class _ScheduleTimeScreenState extends State<ScheduleTimeScreen> {
//   bool toggleBorder = true;
//   int outerIndex = -1;
//   int innerIndex = -1;
//   String? slotId;
//   GetSlotsBloc getSlotsBloc = GetSlotsBloc();
//   bool? isSlotAllowed = false;
//   ​
//   @override
//   void initState() {
//     log("Slot Duration");
//     log("=================date===============");
//     log(widget.date ?? "");
//     log(widget.slotDuration ?? "");
//     _fetchSlots();
//     super.initState();
//   }
//   ​
//   Future<void> _fetchSlots() async {
//     await getSlotsBloc.fetchSlots(
//         context: context,
//         bookingIds: widget.bookingIds,
//         selectedDate: widget.date);
//   }
//   ​
//   Widget _timeSelectionListView({required List<SlotsModel>? slotsModel}) {
//     return Expanded(
//       child: Column(
//         children: [
//           _slotsListViewWidget(slotsModel),
//           SizedBox(height: 15.h),
//           _selectSlotButton(),
//           SizedBox(height: 20.h),
//         ],
//       ),
//     );
//   }
//   ​
//   Widget _slotsListViewWidget(List<SlotsModel>? slotsModel) {
//     return Expanded(
//       child: ListView.separated(
//         itemCount: slotsModel?.length ?? 0,
//         shrinkWrap: true,
//         //   physics: NeverScrollableScrollPhysics(),
//         itemBuilder: (BuildContext context, int index) {
//           return GridView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4,
//               crossAxisSpacing: 5.0,
//               childAspectRatio: 1.4,
//               mainAxisSpacing: 10.0,
//             ),
//             itemCount: slotsModel?[index].slots?.length ?? 0,
//             itemBuilder: (BuildContext context, int i) {
//               Slot? slot = slotsModel?[index].slots?[i];
//               return _timeSelectionButton(
//                 iIndex: i,
//                 oIndex: index,
//                 endIndex: slotsModel?[index].slots?.length ?? 0,
//                 slot: slot,
//               );
//             },
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           //  return  SizedBox(height: 10.h);
//           return Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.h),
//               child: const Divider(height: 3, color: AppColors.green));
//         },
//       ),
//     );
//   }
//   ​
//   Widget _slotsWidget() {
//     return StreamBuilder<MasseurSlotsResponseModel?>(
//       stream: getSlotsBloc.dataStream,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final MasseurSlotsResponseModel? slotsObject = snapshot.data;
//           if ((slotsObject?.slotsModel ?? []).isEmpty) {
//             return _notFoundWidget();
//             // return Container();
//           }
//           return _timeSelectionListView(slotsModel: slotsObject?.slotsModel);
//         } else if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Expanded(child: CustomLoader());
//         } else if (snapshot.hasError) {
//           return _notFoundWidget();
//         } else {
//           return _notFoundWidget();
//         }
//       },
//     );
//   }
//   ​
//   Widget _notFoundWidget() {
//     // return CustomText(text: "fsfsfd");
//     return NoDataFoundWidget(
//       topHeight: 240.h,
//       message: AppStrings.NO_SLOTS_FOUND,
//       onRefresh: () => _fetchSlots(),
//       isRefreshIndicator: true,
//     );
//   }
//   ​
//   Widget _timeSelectionButton(
//       {required int iIndex,
//         required int oIndex,
//         required int endIndex,
//         required Slot? slot}) {
//     bool checked = (iIndex == innerIndex) && (oIndex == outerIndex);
//     return SlotWidget(
//       onTap: () => setState(() {
//         innerIndex = iIndex;
//         outerIndex = oIndex;
//         slotId = slot?.id?.toString();
//         //   print("slot Duration");
//         //    print(widget.slotDuration == '90');
//         if (widget.slotDuration == '90') {
//           if (endIndex - innerIndex >= Constants.ONE_AND_HALF_HOUR_SLOT_LIMIT) {
//             // Logger().i("Condition on 90");
//             //  print(endIndex - innerIndex >= 6);
//             isSlotAllowed = true;
//           } else {
//             isSlotAllowed = false;
//           }
//         }
//         if (widget.slotDuration == '60') {
//           // Logger().i("Inside 60 condition");
//           // Logger().i("Difference ${endIndex - innerIndex}");
//           if (endIndex - innerIndex >= Constants.ONE_HOUR_SLOT_LIMIT) {
//             Logger().i("Condition Allowed");
//             isSlotAllowed = true;
//           } else {
//             Logger().i("Condition Not Allowed");
//             isSlotAllowed = false;
//           }
//         }
//         Logger().i(slotId);
//       }),
//       borderColor: checked ? AppColors.green : Colors.grey,
//       time: _localTime(utcTime: "${slot?.dateTime}"),
//     );
//   }
//   ​
//   String _localTime({required String utcTime}) {
//     return Constants.parseDateTimeToLocalString(
//       showFormat: AppStrings.DATE_MONTH_YEAR_24_HOUR_FORMAT_HH_MM,
//       parseFormat:
//       AppStrings.DATE_MONTH_YEAR_24_HOUR_FORMAT_YYYY_MM_DD_HH_MINUTES_SS,
//       inputTime: utcTime,
//     );
//   }
//   ​
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: AppStrings.SCHEDULE,
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(left: 25.sp, right: 25.sp),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 30.h),
//             _selectTimeLabel(),
//             SizedBox(height: 15.h),
//             _slotsWidget(),
//             SizedBox(height: 25.h),
//           ],
//         ),
//       ),
//     );
//   }
//   ​
//   Widget _selectTimeLabel() {
//     return CustomText(
//       fontSize: 18.sp,
//       text: AppStrings.SELECT_A_TIME,
//       fontFamily: Constants.PLAYFAIR_DISPLAY_FONT_FAMILY_SEMIBOLD,
//     );
//   }
//   ​
//   Widget _selectSlotButton() {
//     return CustomButton(
//       backgroundColor: AppColors.green,
//       labelFontSize: 18,
//       text: AppStrings.SELECT_SLOT,
//       onTap: () async {
//         if (context.read<UserProvider>().isGuest == true) {
//           print("dfssddsfdsfdsfds");
//           CustomDialog(context, description: AppStrings.LOGIN_TO_CONTINUE,
//               btnOkOnPress: () {
//                 StaticData.currentRoute = Constants.getCurrentRoute(context);
//                 AppNavigation.navigateTo(
//                     context, AppRouteName.PRELOGIN_SCREEN_ROUTE);
//               }).show();
//         ​
//         return;
//         }
//         if ((slotId ?? "").isEmpty) {
//         AppDialogs.showToast(message: AppStrings.SELECT_SLOT_FIRST);
//         return;
//         }
//         if (isSlotAllowed == true) {
//         _navigateToPaymentScreen(context);
//         } else {
//         AppDialogs.showToast(message: AppStrings.CANT_SELECT_THIS_SLOT);
//         }
//       },
//     );
//   }
//   ​
//   void _navigateToPaymentScreen(BuildContext context) {
//     AppNavigation.navigateTo(
//       context,
//       AppRouteName.BOOK_NOW_SCREEN_ROUTE,
//       arguments: BookingRoutingArguments(
//         slotId: slotId,
//         serviceName: widget.serviceName,
//         serviceId: widget.serviceId,
//         serviceImagePath: widget.serviceImagePath,
//         amount: widget.amount,
//         bio: widget.bio,
//         slotDuration: widget.slotDuration,
//       ),
//     );
//   }
// }