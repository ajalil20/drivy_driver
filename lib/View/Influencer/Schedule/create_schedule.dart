import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:month_year_picker/month_year_picker.dart';
import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_calendar.dart';
import 'package:drivy_driver/Component/custom_card.dart';
import 'package:drivy_driver/Component/custom_dropdown.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_radio_tile.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Component/custom_textfield.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/Utils/utils.dart';
import 'package:drivy_driver/View/Products/add_product.dart';
import 'package:drivy_driver/View/Widget/counter.dart';
import 'package:drivy_driver/View/Widget/upload_media.dart';
import 'package:drivy_driver/View/base_view.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CreateSchedule extends StatefulWidget {
  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  DateTime? startDate;
  DateTime?endDate;
  int st=0,et=0;
  List<TextEditingController> startTime = [TextEditingController()],endTime = [TextEditingController()];
  List<TextEditingController> name = [TextEditingController()], description = [TextEditingController()];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: BaseView(
          screenTitle: 'Create New Schedule',
          showAppBar: true,
          showBackButton: true,
          onTapBackButton: (){
            onWillPop(context);
          },
          resizeBottomInset: true,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCalendar(
                  rangeStart:(v){
                    startDate=v;//??DateTime.now();
                    // startDate= v==null?'': Utils.formatDateTime(inputDateTime: DateTime.parse(v.toString()),parseFormat: AppStrings.MONTH_YEAR);
                  },
                  selectedDay:(v) async{
                    startDate=v;
                    await getNewDate();
                    },
                  rangeEnd: (v){ endDate=v;//??DateTime.now();
                    // endDate= v==null?'': Utils.formatDateTime(inputDateTime: DateTime.parse(v.toString()),parseFormat: AppStrings.MONTH_YEAR);
                  },startRange: startDate,endRange: endDate,
                   highLightedDay: startDate,
                ),
                SizedBox(height: 2.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MyButton(title:'Add another slot',width: 40.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: (){
                        createScheduleValidation(context,onSuccess: (){addAnotherSlot();});
                      },//bgColor: startTimeController.length>1?null:Colors.grey,
                      ),
                      SizedBox(height: 2.h,),
                      // Align(alignment: Alignment.topRight, child: IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_rounded),color: MyColors().pinkColor,)),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: startTime.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: EdgeInsets.only(bottom: 1.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 1.h,),
                                  if(index!=0)
                                    IconButton(onPressed: (){
                                      removeSlot(index);
                                    }, icon: Icon(Icons.remove_circle_rounded),color: MyColors().pinkColor,),
                                  Row(children: [
                                    Flexible(
                                      child: CustomCard(
                                        padding: EdgeInsets.zero,
                                        margin: EdgeInsets.zero,
                                        child: MyTextField(
                                          backgroundColor: Colors.transparent,
                                          hintText: 'Start Time',
                                          controller: startTime[index],
                                          textColor: Colors.black,
                                          readOnly: true,
                                          onTap: () async {
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            startTime[index].text = await Utils().selectTime(context,onTap: (v){
                                              st=Utils().convertTimeToMinutes(h: v.hour, m: v.minute);
                                            });
                                          },
                                          hintTextColor: MyColors().greyColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3.w,),
                                    Flexible(
                                      child: CustomCard(
                                        padding: EdgeInsets.zero,
                                        margin: EdgeInsets.zero,
                                        child: MyTextField(
                                          backgroundColor: Colors.transparent,
                                          hintText: 'End Time',
                                          controller: endTime[index],
                                          textColor: Colors.black,
                                          readOnly: true,
                                          onTap: () async {
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            endTime[index].text = await Utils().selectTime(context,onTap: (v){
                                              et=Utils().convertTimeToMinutes(h: v.hour, m: v.minute);
                                            });
                                          },
                                          hintTextColor: MyColors().greyColor,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: 3.w,),
                                    // if(startTimeController.length==index+1)
                                    // IconButton(onPressed: (){
                                    //
                                    //   }, icon: Icon(Icons.add))
                                    // else
                                    //   IconButton(onPressed: (){
                                    //     startTimeController.removeAt(index);
                                    //     endTimeController.removeAt(index);
                                    //     setState(() {});
                                    //   }, icon: Icon(Icons.remove)),

                                  ],),
                                  SizedBox(height: 2.h,),
                                  CustomCard(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    child: MyTextField(
                                      backgroundColor: Colors.transparent,
                                      hintText: 'Title',
                                      controller: name[index],
                                      maxLength: 35,
                                      textColor: Colors.black,
                                      hintTextColor: MyColors().greyColor,
                                    ),
                                  ),
                                  SizedBox(height: 2.h,),
                                  CustomCard(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,child: MyTextField(height: 13.h,hintText: 'Description', maxLines: 7,minLines: 7,borderColor: Colors.transparent,backgroundColor: Colors.transparent,textColor: Colors.black,controller: description[index],
                                    hintTextColor: MyColors().greyColor,borderRadius: 10,maxLength: 1000,)),
                                ],
                              ),
                            );
                          }),
                      // Row(children: [
                      //   Flexible(
                      //     child: CustomCard(
                      //       padding: EdgeInsets.zero,
                      //       margin: EdgeInsets.zero,
                      //       child: MyTextField(
                      //         backgroundColor: Colors.transparent,
                      //         hintText: 'Start Time',
                      //         controller: startTime,
                      //         textColor: Colors.black,
                      //         readOnly: true,
                      //         onTap: () async {
                      //           FocusManager.instance.primaryFocus?.unfocus();
                      //           startTime.text = await Utils().selectTime(context,onTap: (v){
                      //             st=Utils().convertTimeToMinutes(h: v.hour, m: v.minute);
                      //           });
                      //         },
                      //         hintTextColor: MyColors().greyColor,
                      //       ),
                      //     ),
                      //   ),
                      //   SizedBox(width: 3.w,),
                      //   Flexible(
                      //     child: CustomCard(
                      //       padding: EdgeInsets.zero,
                      //       margin: EdgeInsets.zero,
                      //       child: MyTextField(
                      //         backgroundColor: Colors.transparent,
                      //         hintText: 'End Time',
                      //         controller: endTime,
                      //         textColor: Colors.black,
                      //         readOnly: true,
                      //         onTap: () async {
                      //           FocusManager.instance.primaryFocus?.unfocus();
                      //           endTime.text = await Utils().selectTime(context,onTap: (v){
                      //             et=Utils().convertTimeToMinutes(h: v.hour, m: v.minute);
                      //           });
                      //         },
                      //         hintTextColor: MyColors().greyColor,
                      //       ),
                      //     ),
                      //   ),
                      //   SizedBox(width: 3.w,),
                      //   IconButton(onPressed: (){}, icon: Icon(Icons.add)),
                      // ],),

                      MyButton(title: 'Save', onTap: () {
                        onSubmit(context);
                      },),
                      SizedBox(height: 2.h,),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
  onWillPop(context) async {
    AppNavigation.navigatorPop(context);
    AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,arguments: ScreenArguments(index: 1));
    return false;
  }
  onSubmit(context){
    createScheduleValidation(context,onSuccess: (){
      var h =HomeController.i;
      h.startDate=Utils.convertTimeToUTC(time:Utils.dayStartTime, date: startDate!);
      h.endDate=Utils.convertTimeToUTC(time:Utils.dayEndTime, date: startDate!);
      h.scheduleList=[];
      for(int i=0;i<endTime.length;i++){if(startDate!=null){h.scheduleList.add(Utils.createScheduleJson(start:startDate!,end: startDate!,title: name[i].text,description: description[i].text, startTime: startTime[i].text,endTime: endTime[i].text));}}
      h.addSchedule(context, onSuccess: (){AppNavigation.navigatorPop(context);});
    });
  }
  createScheduleValidation(context,{required Function onSuccess}){
    FocusManager.instance.primaryFocus?.unfocus();
    createTimeList();
    if(startDate==null){
      CustomToast().showToast('Error', 'Please select the date.', true);
    }else if(startTime.last.text.isEmpty){
      CustomToast().showToast('Error', 'Start time field can\'t be empty', true);
    }else if(endTime.last.text.isEmpty){
      CustomToast().showToast('Error', 'End time field can\'t be empty', true);
    }else if(st>et){
      CustomToast().showToast('Error', 'Start time should be less than end time', true);
    }
    // else if(Utils.uniqueTimeCheck(sTime: sTime,eTime: eTime, startTime: st, endTime: et)){
    //   CustomToast().showToast('Error', 'Slots must be unique', true);
    // }
    else if(name.last.text.isEmpty){
      CustomToast().showToast('Error', 'Title field can\'t be empty', true);
    }else if(description.last.text.isEmpty){
      CustomToast().showToast('Error', 'Description field can\'t be empty', true);
    } else{
      onSuccess();
    }
  }
  addAnotherSlot(){
    startTime.add(TextEditingController());
    endTime.add(TextEditingController());
    name.add(TextEditingController());
    description.add(TextEditingController());
    setState(() {});
  }
  removeSlot(index){
    startTime.removeAt(index);
    endTime.removeAt(index);
    name.removeAt(index);
    description.removeAt(index);
    setState(() {});
  }
  getData(){
    startDate=HomeController.i.selectedDate.value;
    if(HomeController.i.schedule.isNotEmpty){
      startTime= [];
      endTime= [];
      name= [];
      description= [];
      // startDate= DateTime.parse(HomeController.i.startDate);
    }
    for(var v in HomeController.i.schedule){
      // startDate
      // print(Utils.convertToLocalTime(time:v.startTime ));
      startTime.add(TextEditingController(text: Utils.convertToLocalTime(time:v.startTime)));
      endTime.add(TextEditingController(text: Utils.convertToLocalTime(time:v.endTime)));
      name.add(TextEditingController(text: v.title));
      description.add(TextEditingController(text: v.description));
      // List<TextEditingController> startTime = [TextEditingController()];
      // List<TextEditingController> endTime = [TextEditingController()];
      // List<TextEditingController> name = [TextEditingController()];
      // List<TextEditingController> description = [TextEditingController()];
    }
    setState(() {});
  }
  getNewDate()async{
    startTime = [TextEditingController()];endTime = [TextEditingController()];
    name = [TextEditingController()]; description = [TextEditingController()];
    setState(() {});
    await HomeController.i.getSchedule(context, d: startDate.toString(),id: AuthController.i.user.value.id);
    getData();
  }
  createTimeList(){
    for(int i=0;i<startTime.length;i++){
      // sTime.add(TimeOfDay.fromDateTime(DateFormat("hh:mm a").format(DateTime.parse(startTime[i].text))));
      // sTime.add(TimeOfDay.fromDateTime());
      // eTime.add(TimeOfDay.fromDateTime(DateTime.parse(endTime[i].text)));
    }
  }
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;

