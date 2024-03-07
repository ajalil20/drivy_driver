import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:month_year_picker/month_year_picker.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_dropdown.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_radio_tile.dart';
import 'package:drivy_user/Component/custom_textfield.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Products/add_product.dart';
import 'package:drivy_user/View/Widget/Dialog/success_payment.dart';
import 'package:drivy_user/View/Widget/counter.dart';
import 'package:drivy_user/View/Widget/upload_media.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CreateContract extends StatefulWidget {
  @override
  State<CreateContract> createState() => _CreateContractState();
}

class _CreateContractState extends State<CreateContract> {
  TextEditingController name = TextEditingController(text: '${HomeController.i.endUser.value.firstName} ${HomeController.i.endUser.value.lastName}'),
      startDate = TextEditingController(),
      endDate = TextEditingController(),
      startTime = TextEditingController(),
      endTime = TextEditingController(),
      gift = TextEditingController(),
      amount = TextEditingController();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(Duration(days: 1000000));
  List payment = [AppStrings.COMMISION, AppStrings.OTP,AppStrings.GIFT];
  RxString selectPayment = ''.obs;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: 'Create Contract',
        showAppBar: true,
        showBackButton: true,
        resizeBottomInset: true,
        child: Obx(()=> Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h,),
                  MyTitle(title: 'Influencer Name',),
                  SizedBox(height: 1.h,),
                  CustomCard(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    child: MyTextField(
                      backgroundColor: Colors.transparent,
                      hintText: 'Influencer Name',
                      controller: name,
                      readOnly: true,
                      maxLength: 35,
                      textColor: Colors.black,
                      hintTextColor: MyColors().greyColor,
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTitle(title: 'Start Date',),
                            SizedBox(height: 1.h,),
                            CustomCard(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              child: MyTextField(
                                backgroundColor: Colors.transparent,
                                hintText: 'mm-dd-yyyy',
                                controller: startDate,
                                textColor: Colors.black,
                                readOnly: true,
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  startDate.text = await Utils().selectDate(context, firstDate: firstDate, lastDate: lastDate,initialDate: startDate.text.isEmpty?null:DateFormat("MM-dd-yyyy").parse(startDate.text));
                                },
                                hintTextColor: MyColors().greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 4.w,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTitle(title: 'End Date',),
                            SizedBox(height: 1.h,),
                            CustomCard(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              child: MyTextField(
                                backgroundColor: Colors.transparent,
                                hintText: 'mm-dd-yyyy',
                                controller: endDate,
                                textColor: Colors.black,
                                readOnly: true,
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  endDate.text = await Utils().selectDate(context, firstDate: firstDate, lastDate: lastDate,initialDate: endDate.text.isEmpty?null:DateFormat("MM-dd-yyyy").parse(endDate.text));
                                },
                                hintTextColor: MyColors().greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 2.h,),
                  // Row(
                  //   children: [
                  //     Flexible(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           MyTitle(title: 'Start Time',),
                  //           SizedBox(height: 1.h,),
                  //           CustomCard(
                  //             padding: EdgeInsets.zero,
                  //             margin: EdgeInsets.zero,
                  //             child: MyTextField(
                  //               backgroundColor: Colors.transparent,
                  //               hintText: 'Start Time',
                  //               controller: startTime,
                  //               textColor: Colors.black,
                  //               readOnly: true,
                  //               onTap: () async {
                  //                 FocusManager.instance.primaryFocus?.unfocus();
                  //                 startTime.text = await Utils().selectTime(context,onTap: (v){});
                  //               },
                  //               hintTextColor: MyColors().greyColor,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(width: 4.w,),
                  //     Flexible(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           MyTitle(title: 'End Time',),
                  //           SizedBox(height: 1.h,),
                  //           CustomCard(
                  //             padding: EdgeInsets.zero,
                  //             margin: EdgeInsets.zero,
                  //             child: MyTextField(
                  //               backgroundColor: Colors.transparent,
                  //               hintText: 'End Time',
                  //               controller: endTime,
                  //               textColor: Colors.black,
                  //               readOnly: true,
                  //               onTap: () async {
                  //                 FocusManager.instance.primaryFocus?.unfocus();
                  //                 endTime.text = await Utils().selectTime(context,onTap: (v){});
                  //               },
                  //               hintTextColor: MyColors().greyColor,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 2.h,),
                  MyTitle(title: 'Mode of payment',),
                  SizedBox(height: 1.h,),
                  Wrap(
                      direction: Axis.horizontal,
                      children: List.generate(payment.length, (index) =>
                          InkWell(
                            onTap: () {
                              selectPayment.value = payment[index];
                              FocusManager.instance.primaryFocus?.unfocus();

                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.w,top: 1.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomRadioTile(
                                    v: (selectPayment.value == payment[index]).obs,),
                                  SizedBox(width: 2.w,),
                                  MyText(title: payment[index]),
                                ],
                              ),
                            ),
                          ),)),
                  SizedBox(height: 2.h,),
                  // MyTitle(title: selectPayment.value==AppStrings.GIFT?'Gift' :'Price',),
                  // SizedBox(height: 1.h,),
                  if(selectPayment.value==AppStrings.GIFT)
                  CustomCard(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    child: MyTextField(
                      backgroundColor: Colors.transparent,
                      hintText:'Gift',
                      // maxLength:selectPayment.value==AppStrings.GIFT?100:6,
                      textColor: Colors.black,
                      hintTextColor: MyColors().greyColor,
                      controller: gift,
                    ),
                  )
                  else
                  CustomCard(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      child: MyTextField(
                          backgroundColor: Colors.transparent,
                          hintText: 'Price',
                          maxLength:6,
                          prefixWidget: Icon(
                            Icons.attach_money_rounded, color: Colors.grey,
                            size: 20,),
                          textColor: Colors.black,
                          hintTextColor: MyColors().greyColor,
                          inputType: TextInputType.number,
                          controller: amount,
                          onlyNumber:true
                      ),
                    ),
                  SizedBox(height: 2.h,),
                  MyButton(title: selectPayment.value==AppStrings.GIFT?'Send Request':'Pay Now', onTap: () {onSubmit(context);},),
                  SizedBox(height: 2.h,),
                ],
              ),
            ),
          ),
        )
    );
  }
  onSubmit(context){
    var h = HomeController.i;
    h.name=name.text;
    h.startDate=startDate.text;
    h.endDate=endDate.text;
    h.paymentMethod=selectPayment.value;
    if(selectPayment.value==AppStrings.GIFT){
      h.amount=gift.text;
    }else{
      h.amount=amount.text;
    }
    h.createContractValidation(context,onSuccess: (){successDialog();});
  }
  successDialog(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.fromLTRB(
                  0, 0, 0, 0),
              content: SuccessPaymentDialog(),
            ),
          );
        }
    );
  }

}