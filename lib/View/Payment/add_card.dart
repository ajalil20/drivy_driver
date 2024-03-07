// import /'package:month_year_picker/month_year_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_month_picker.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_radio_tile.dart';
import 'package:drivy_user/Component/custom_textfield.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Component/custom_year_picker.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Widget/Dialog/order_place.dart';
import 'package:drivy_user/View/Widget/counter.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../Service/stripe_service.dart';

class AddCard extends StatefulWidget {
  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController name = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController cvc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: 'Add Card',
        showAppBar: true,
        showBackButton: true,
        centerTitle: false,
        resizeBottomInset: false,
        child: CustomPadding(
          horizontalPadding: 3.w,
          topPadding: 2.h,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(title: 'Card Name'),
              SizedBox(height: 1.h,),
              MyTextField(
                maxLength: 40,
                backgroundColor: Colors.transparent,
                hintText: "Card Holder Name",
                controller: name,
                textColor: Colors.black,
                hintTextColor: MyColors().greyColor,
              ),
              SizedBox(height: 2.h,),
              MyText(title: 'Card Number'),
              SizedBox(height: 1.h,),
              MyTextField(
                backgroundColor: Colors.transparent,
                hintText: 'Card Number',
                cardFormat:true,
                inputType: TextInputType.number,
                controller: cardNumber,
                maxLength: 19,
                textColor: Colors.black,
                hintTextColor: MyColors().greyColor,
              ),
              SizedBox(height: 2.h,),
              Row(children: [
                Flexible(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(title: 'Expiry (MM/YY)'),
                    SizedBox(height: 1.h,),
                    MyTextField(
                      backgroundColor: Colors.transparent,
                      textColor: Colors.black,
                      hintTextColor: MyColors().greyColor,
                      hintText: 'Expiry (MM/YY)',
                      cardExpiration:true,
                      maxLength: 5,
                      inputType: TextInputType.number,
                      controller: monthController,
                      // readOnly: true,
                      // onTap: (){
                      //   _onTapMonthPicker();
                      //   // monthPick(context);
                      // },
                    ),
                  ],
                ),),
                SizedBox(width: 3.w,),
                Flexible(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(title: 'CVV/CVC'),
                    SizedBox(height: 1.h,),
                    MyTextField(
                        backgroundColor: Colors.transparent,
                        textColor: Colors.black,
                        hintTextColor: MyColors().greyColor,
                        hintText: 'CVV/CVC',
                        inputType: TextInputType.number,
                        maxLength: 4,
                        controller: cvc,
                        cardFormat:true
                    ),
                  ],
                ),),
              ],),
              // CustomCard(
              //   padding: EdgeInsets.zero,
              //   child: MyTextField(
              //     backgroundColor: Colors.transparent,
              //     textColor: Colors.black,
              //     hintTextColor: MyColors().greyColor,
              //     hintText: 'Expiry Date',
              //     cardExpiration:true,
              //     maxLength: 5,
              //     inputType: TextInputType.number,
              //     controller: expiry,
              //     readOnly: true,
              //     onTap: (){
              //       _onTapMonthPicker();
              //       // monthPick(context);
              //     },
              //   ),),
              SizedBox(height: 3.h,),
              // MyTextField(
              //   backgroundColor: Colors.transparent,
              //   textColor: Colors.black,
              //   hintTextColor: MyColors().greyColor,
              //   hintText: 'CVV',
              //   inputType: TextInputType.number,
              //   maxLength: 3,
              //   controller: cvc,
              //     cardFormat:true
              // ),
              // Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 8.0),
              //
              //     child: Row(
              //       children: [
              //         Flexible(
              //           child: CustomCard(
              //     padding: EdgeInsets.zero,
              //       child: MyTextField(
              //         backgroundColor: Colors.transparent,
              //         textColor: Colors.black,
              //         hintTextColor: MyColors().greyColor,
              //         hintText: 'Expiry',
              //         cardExpiration:true,
              //         maxLength: 5,
              //         inputType: TextInputType.number,
              //         controller: expiry,
              //         readOnly: true,
              //         onTap: (){
              //           monthPick(context);
              //         },
              //       ),),),
              //         SizedBox(width: 3.w,),
              //         Flexible(
              //           child: CustomCard(
              //             padding: EdgeInsets.zero,
              //             child: MyTextField(
              //               backgroundColor: Colors.transparent,
              //               textColor: Colors.black,
              //               hintTextColor: MyColors().greyColor,
              //               hintText: 'CVC',
              //               inputType: TextInputType.number,
              //               maxLength: 3,
              //               controller: cvc,
              //             ),),),
              //
              //       ],)),
              // SizedBox(height: 1.h,),
              // Container(decoration: BoxDecoration(
              //   color: const Color(0xffEAEAEA),
              //   borderRadius: BorderRadius.circular(10),
              // ),
              //
              // child: Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const MyText(title: "SET AS DEFAULT",clr:  Color(0xff282828),weight: "Semi Bold",size: 14,),
              //       CustomSwitch(
              //         switchValue: switchValue,
              //         toggleColor: Colors.green,
              //       )
              //
              //     ],
              //   ),
              // ),
              // ),
              SizedBox(height: 1.h,),

              MyButton(
                  onTap: (){onSubmit(context);},
                  title: "Save Card"
              ),
              SizedBox(
                height:3.5.h,
              ),
            ],
          ),
        )
    );
  }
  onSubmit(context){
    HomeController.i.name=name.text;
    HomeController.i.cardNumber=cardNumber.text;
    HomeController.i.month=monthController.text;
    HomeController.i.year=yearController.text;
    HomeController.i.cvc=cvc.text;
    HomeController.i.addCardValidation(context);
  }
  monthPick(context) async {
    // final selected = await showMonthYearPicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime(3000),
    // );
    // print(selected);
    //
    // if (selected != null) {
    //   expiry.text=Utils.getFormattedMonthYear(date:selected.toString());//.replaceFirst("T", " ").replaceFirst("Z", ""),);
    // }
  }
  void _onTapMonthPicker() {
    showDialog(context: context, builder: (context) {
      return CustomMonthPickerDialog( i: (val) {
        monthController.text='${val<9?'0${val+1}':val+1}';
      },
          onChanged: (v){},
          selectedMonth: monthController.text != "" ? int.parse(monthController.text) : DateTime.now().month);
    });
  }
  void _onTapYearPicker() {
    showDialog(context: context, builder: (context) {
      return CustomYearPickerDialog(
          onChanged: (v){ yearController.text=v.year.toString();},
          selectedDate: yearController.text == ""
              ? DateTime.now()
              : DateTime.utc(int.parse(yearController.text)));
    });
  }
}