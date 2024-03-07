
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import '../../../../Component/custom_buttom.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Component/custom_textfield.dart';
import '../../../../Component/custom_toast.dart';
import '../../../../Utils/image_path.dart';
import '../../../../Utils/my_colors.dart';
import '../../../base_view.dart';

class AddCar extends StatefulWidget {
  AddCar({this.editCar = false, this.id});
  bool? editCar;
  int? id;

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  // final i.value i.value = Get.find<i.value>();
  // RxList<PostCar> searchBrands = List<PostCar>.empty().obs;
  RxBool searchBrandsOn = false.obs;
  TextEditingController searchBrandController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  int abuDhabiLength=7;
  int dubaiLength=7;
  int ajmanLength=6;
  int fujairahLength=6;
  int rasLength=6;
  int sharjahLength=6;
  RxInt i = 0.obs;
  RxString plateCode = "1".obs;
  RxInt insuranceToggle = 0.obs;
  RxInt transactionToggle = 0.obs;
  RxBool toggle = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // i.value.getCarBrands();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      bgImage: ImagePath.bgImage,
      showBackgroundImage: true,
      resizeBottomInset: true,
      screenTitleColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Obx(() {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 4.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(i.value!=0){
                                i--;
                              } else{
                                AppNavigation.navigatorPop(context);
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // MyText(title: "Rate Drive",
                          //   size: 16,
                          //   weight: "Semi Bold",
                          //   clr: Colors.white,),
                        ],
                      ),
                      // Spacer(),
                      SizedBox(height: 4.h),
                      MyText(
                        title: i.value<5 ? "Step 0${i.value+1}" :"One Last Step!",
                        size: 24,
                        weight: "Semi Bold",
                        clr: Colors.white,
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.3.w, vertical: 1.3.w),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xffE6EBEF))),
                        child: LinearPercentIndicator(
                          width: 88.7.w,
                          animation: true,
                          lineHeight: 2.5.h,
                          padding: EdgeInsets.all(0),
                          animationDuration: 2000,
                          percent: i.value==0
                              ? 0.0
                              : i.value==1
                              ? 0.2
                              :i.value==2
                              ? 0.4
                              :i.value==3
                              ? 0.6
                              :i.value==4
                              ? 0.8 : 1,
                          backgroundColor: Colors.transparent,
                          animateFromLastPercent: true,
                          barRadius: Radius.circular(12),
                          progressColor: MyColors().primaryColor,
                          // maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                        ),
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
                Stack(children: [
                  Container(
                    margin: EdgeInsets.only(top: 6.h),
                    padding: EdgeInsets.only(
                        top: (i.value==0 ||
                            i.value==2)
                            ? 2.h
                            : 7.h,
                        bottom: 4.h) +
                        EdgeInsets.symmetric(horizontal: 8.w),
                    height:i.value==2?58.h: 58.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(24),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (i.value==0)...[
                          MyText(
                            title: "Search Your Car Brand",
                            size: 16,
                            weight: "Semi Bold",
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          MyTextField(
                            controller: searchBrandController,
                            // controller: controller.searchText.value,
                            height: 5.5.h,
                            width: 90.w,
                            backgroundColor: Color(0xffFFFAF2),
                            fontSize: 12,
                            suffixIconData:
                            Icon(Icons.search, color: Color(0xffBDC2DC)),
                            // sufixIconColor: Color(0xffBDC2DC),
                            fullBorder: false,
                            borderColor: Colors.white,
                            hintText: "Search Car Make and Model",
                            onChanged: (val) {
                              print(val);
                              if (val.isNotEmpty) {
                                searchBrandsOn.value = true;
                                searchBrand(s: val);
                              } else {
                                searchBrandsOn.value = false;
                              }
                            },
                            // focusNode: controller.f2.value,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 10.h,
                            width: 100.w,
                            alignment: Alignment.centerLeft,
                            child: ListView.builder(
                              itemCount: carBrands.length,
                              padding: EdgeInsets.zero,
                              // shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuileContext, int i) {
                                return GestureDetector(
                                    onTap: () {
                                      selectedCarBrand.value =carBrands[i];
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 30,
                                          bottom: 30,
                                          right: 10),
                                      height: 13.w,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        // border: Border.all(
                                        //   color:selectedCarBrand.value ==carBrands[i]
                                        //       ? Theme.of(context)
                                        //       .primaryColor
                                        //       : Colors.transparent,
                                        // ),
                                          borderRadius:
                                          BorderRadius.circular(
                                              3)),
                                      child: Container(
                                        // height: 12.h,
                                        // width: 15.w,
                                        // margin: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.w),
                                          child: Image.asset(
                                            carBrands[i].image!,
                                            // height: 13.w,
                                            // width: 13.w,
                                            // fit: BoxFit.fill,
                                          )),
                                    ));
                              },
                            ),
                          ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          Spacer(),
                          //
                          // MyButton(
                          //   title: "Other Brand",
                          //   onTap: () {
                          //     // i.value.selectedCarBrand= PostCar().obs;
                          //     // Get.to(OtherCar());
                          //   },
                          // ),
                          SizedBox(
                            height: 2.h,
                          ),
                          MyButton(
                            title: "Next",
                            onTap: () {
                              // if (i.value.selectedCarBrand.value.id ==
                              //     null) {
                              //   CustomToast().showToast(
                              //       "Error", "Select Card Brand", true);
                              // } else
                              {
                                i.value++;
                              }
                            },
                          ),
                        ],
                        if (i.value==1) ...[
                          MyText(
                            title: "Search Your Car Model",
                            size: 16,
                            weight: "Semi Bold",
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          MyTextField(
                            // controller: controller.searchText.value,
                            height: 5.5.h,
                            width: 90.w,
                            backgroundColor: Color(0xffFFFAF2),
                            fontSize: 12,
                            suffixIconData:
                            Icon(Icons.search, color: Color(0xffBDC2DC)),
                            // sufixIconColor: Color(0xffBDC2DC),
                            fullBorder: false,
                            borderColor: Colors.white,
                            hintText: "Search Car Make and Model",
                            // focusNode: controller.f2.value,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Flexible(
                            child:
                            ListView.builder(
                              itemCount: 4,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuileContext, int i) {
                                return GestureDetector(
                                    onTap: () {
                                      selectedSeries.value = 'Series ${i+1}';
                                    },
                                    child: Container(
                                        width: 15.w,
                                        margin: EdgeInsets.only(
                                            right: 3.w),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Obx(
                                                  () => Container(
                                                  height: 15.w,
                                                  width: 15.w,
                                                  decoration:
                                                  BoxDecoration(
                                                    color: selectedSeries
                                                        .value ==selectedCarBrand
                                                            .value   .name
                                                        ? Theme.of(
                                                        context)
                                                        .primaryColor
                                                        : null,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        3),
                                                  ),
                                                  padding:
                                                  EdgeInsets.all(
                                                      1.5.w),
                                                  child:Image.asset(
                                                  selectedCarBrand.value.image!,
                                                    // height:
                                                    // 10.w,
                                                    // width: 10.w,
                                                    // fit: BoxFit.fill,
                                                  )
                                                  ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            MyText(
                                              title: selectedCarBrand.value.name!,
                                              size: 11,
                                              clr: Color(0xffB8BAC6),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            MyText(
                                              title:'Series ${i+1}',
                                              size: 12,
                                              clr: Colors.black,
                                            )
                                          ],
                                        )));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Spacer(),
                          MyButton(
                            title: "Next",
                            onTap: () {
                              // if (i.value.selectedSeries.value == "")
                              {
                                CustomToast().showToast(
                                    "Error", "Select Car series", true);
                              }
                              i.value++;
                            },
                          ),
                        ],
                        if (i.value==2) ...[
                          SizedBox(
                            height: 5.h,
                          ),
                          MyText(
                            title: "Select Car Color",
                            size: 12,
                            weight: "Semi Bold",
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: colors.length,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuileContext, int i) {
                                return GestureDetector(
                                    onTap: () {
                                      selectedColor.value = colors[i];
                                    },
                                    child: Container(
                                      // padding: EdgeInsets.all(2.w),
                                        margin: EdgeInsets.only(right: 3.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 11.w,
                                              height: 11.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color:colors[i].color,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            MyText(
                                              title: colors[i].name!,
                                              size: 8,
                                            ),
                                          ],
                                        )));
                              },
                            ),
                          ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          // Spacer(),
                          MyButton(
                            title: "Next",
                            onTap: () {
                              i.value++;
                            },
                          ),
                        ],
                        if (i.value==3) ...[
                          MyText(
                            title: "Select Car City",
                            size: 16,
                            weight: "Semi Bold",
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              toggle(!toggle.value);

                              // "Abu Dhabi",
                              // "Ajman",
                              // "Dubai",
                              // "Fujairah",
                              // "Ras Al Khaimah",
                              // "Sharjah"
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 2.2.h),
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              width: double.infinity,
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                  Border.all(color: Color(0xffFFFAF2))),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  MyText(title: city.value),
                                  const Spacer(),
                                  Icon(
                                    Icons.expand_more_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(
                                () => AnimatedContainer(
                              height:toggle.value ? 22.h : 0,
                              decoration: BoxDecoration(
                                color: toggle.value
                                    ? Colors.transparent
                                    : Colors.white12,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: ListView.builder(
                                      itemCount: cities.length,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (BuileContext, int i) {
                                        return GestureDetector(
                                            onTap: () {
                                              city.value = cities[i];
                                              toggle.value = false;
                                              // var cc = i.value;
                                              // var c = i.value.city.value;
                                              // var p = i.value.plateCodes;
                                              // if(c=="Abu Dhabi"){
                                              //   p.value=cc.abuDhabiList;
                                              // }else if(c=="Ajman"){
                                              //   p.value=cc.ajmanList;
                                              // }else if(c=="Dubai"){
                                              //   p.value=cc.dubaiList;
                                              // }else if(c=="Fujairah"){
                                              //   p.value=cc.fujairahList;
                                              // }else if(c=="Ras Al Khaimah"){
                                              //   p.value=cc.rasList;
                                              // }else if(c=="Sharjah"){
                                              //   p.value=cc.sharjahList;
                                              // }else if(c=="Umm al-Quwain"){
                                              //   p.value=cc.quwainList;
                                              // }
                                              // i.value.plateCode.value=p.first;
                                              // print(p);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(2.w),
                                                margin: EdgeInsets.only(
                                                    bottom: 2.w),
                                                decoration: BoxDecoration(
                                                    color: city.value == cities[i]
                                                        ? Color(0xffFFFAF2)
                                                        : null,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        4),
                                                    border: Border.all(
                                                        color: city
                                                            .value ==
                                                            cities[i]
                                                            ? Color(0xffFFFAF2)
                                                            : Color(0xffE6EBEF))),
                                                alignment: Alignment.center,
                                                child: MyText(title: cities[i])));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Spacer(),
                          MyButton(
                            title: "Next",
                            onTap: () {
                              i.value++;
                            },
                          ),
                        ],
                        if (i.value==4) ...[
                          MyText(
                            title: "City",
                            size: 12,
                            weight: "Semi Bold",
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          // MyText(title: city.value,size: 30,weight: "Semi Bold",),
                          Image.asset(
                            ImagePath.dubai,
                            scale: 2.2,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          MyText(
                            title: "Choose Your Licence Plate Code",
                            size: 12,
                            weight: "Semi Bold",
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  plateToggle(!plateToggle.value);
                                },
                                child: Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 5.w),
                                  width: 30.w,
                                  alignment: Alignment.center,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: Color(0xffE6EBEF))),
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      MyText(title: plateCode.value),
                                      const Spacer(),
                                      Icon(
                                        Icons.expand_more_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                  child: MyTextField(
                                      height: 7.h,
                                      hintText: "Enter Plate Number",
                                      controller: plateNumberController,
                                      // hinTextSize: 12,
                                      maxLength: 5,//(i.value.city.value=="Abu Dhabi" ||  i.value.city.value=="Dubai")? 7:6,
                                      inputType:  TextInputType.number,//(i.value.city=="Abu Dhabi"||i.value.city== "Sharjah")?TextInputType.number:null,
                                      // counter: true,
                                      hintTextColor: Color(0xff858793)
                                  )),
                            ],
                          ),
                          Obx(
                                () => Align(
                              alignment: Alignment.centerLeft,
                              child: AnimatedContainer(
                                height:plateToggle.value ? 10.h : 0,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: plateToggle.value
                                      ? Colors.transparent
                                      : Colors.white12,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: ListView.builder(
                                        itemCount:2,
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (BuileContext, int i) {
                                          return GestureDetector(
                                              onTap: () {
                                                plateCode.value = plateCodes[i];
                                                plateToggle.value = false;
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.all(2.w),
                                                  margin: EdgeInsets.only(
                                                      bottom: 2.w),
                                                  decoration: BoxDecoration(
                                                      color: plateCode
                                                          .value ==plateCodes[i]
                                                          ? Color(0xffFFFAF2)
                                                          : null,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          4),
                                                      border: Border.all(
                                                          color:
                                                            // i.value
                                                              // .plateCode
                                                              // .value ==
                                                              // i.value
                                                              //     .plateCodes[i]
                                                              // ? Color(0xffFFFAF2):
                                                            Color(0xffE6EBEF))),
                                                  alignment: Alignment.center,
                                                  child: MyText(title: plateCodes[i])));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Spacer(),
                          MyButton(
                            title: "Next",
                            onTap: () {
                              validateNoPlate();

                            },
                          ),
                        ],
                        if (i.value==5) ...[
                          // Image.asset(ImagePath.numberPlate),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffBBBDBF),
                                ),
                                // color: Color(0xffE6E7E8),
                                borderRadius: BorderRadius.circular(4)),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff404041),
                                  ),
                                  // color: Color(0xffE6E7E8),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffBBBDBF),
                                    ),
                                    color: Color(0xffE6E7E8),
                                    borderRadius: BorderRadius.circular(4)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: .25.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // MyText(title: i.value.city.value,size: 10,weight: "Semi Bold",),

                                        // Image.asset(
                                        //   ImagePath.dubai,
                                        //   width: 8.w,
                                        // ),
                                        SizedBox(
                                          width: 14.w,
                                        ),
                                        // MyText(
                                        //   title: i.value.plateCode.value,
                                        //   weight: "Bold",
                                        // ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: .5.h,
                                    ),
                                    MyText(
                                      title: plateNumberController.text,
                                      clr: Color(0xffB5B5B6),
                                      size: 30,
                                      weight: "Bold",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 2.h,
                          ),
                          MyText(
                            title: "Transmission Type",
                            size: 12,
                            weight: "Semi Bold",
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Obx(() {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffFFFAF2)
                                    // color: Colors.red
                                  ),
                                  borderRadius: BorderRadius.circular(64)),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: MyButton(
                                      height:5.h,
                                      title: "Automatic",
                                      bgColor:transactionToggle.value ==
                                          1
                                          ? Colors.white
                                          :Colors.black,
                                      textColor:transactionToggle.value ==
                                          1
                                          ? Colors.black
                                          : null,
                                      onTap: () {transactionToggle.value =
                                        0;
                                      },
                                      radius: 64,
                                    ),
                                  ),
                                  SizedBox(width: 3.w,),
                                  Flexible(
                                    child: MyButton(
                                      title: "Manual",
                                      bgColor: transactionToggle.value ==
                                          0
                                          ? Colors.white
                                          : Colors.black,
                                      textColor:transactionToggle.value ==
                                          0
                                          ? Colors.black
                                          : null,
                                      radius: 64,
                                      height:5.h,
                                      onTap: () {
                                        transactionToggle.value =
                                        1;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              MyText(
                                title: "Do you have comprehensive insurance?",
                                size: 12,
                                weight: "Semi Bold",
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Icon(
                                Icons.info,
                                color: Color(0xffC4C7CF),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Obx(() {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffFFFAF2)
                                    // color: Colors.red
                                  ),
                                  borderRadius: BorderRadius.circular(64)),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: MyButton(
                                      height:5.h,
                                      title: "Yes",
                                      bgColor:insuranceToggle.value ==
                                          1
                                          ? Colors.white
                                          :Colors.black,
                                      textColor: insuranceToggle.value ==
                                          1
                                          ? Colors.black
                                          : null,
                                      onTap: () {
                                        insuranceToggle.value =
                                        0;
                                      },
                                      radius: 64,
                                    ),
                                  ),
                                  SizedBox(width: 3.w,),
                                  Flexible(
                                    child: MyButton(
                                      height:5.h,
                                      title: "No",
                                      bgColor: insuranceToggle.value ==
                                          0
                                          ? Colors.white
                                          : Colors.black,
                                      textColor:insuranceToggle.value ==
                                          0
                                          ? Colors.black
                                          : null,
                                      radius: 64,
                                      onTap: () {
                                        insuranceToggle.value = 1;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: 2.h,
                          ),
                          Spacer(),
                          MyButton(
                            title: "Submit",
                            onTap: () async {
                              AppNavigation.navigatorPop(context);
                              CustomToast().showToast('Success', 'Car Added Successfully', false);
                              if (widget.editCar == true) {

                                // await i.value.updateCar(widget.id);
                              } else {
                                // await i.value.addCar();
                              }

                              // Get.back();
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (i.value!=0 ||i.value!=1)
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Card(
                            elevation: 1,
                            child: Container(
                              height: 10.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 30.w,
                                      child: Row(
                                        children: [
                                         Image.asset(
                                           selectedCarBrand.value.image!,
                                            height: 10.w,
                                            width: 10.w,
                                            // fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                title:selectedCarBrand
                                                    .value
                                                    .name!,
                                                size: 10,
                                              ),
                                              MyText(
                                                title:selectedSeries.value,
                                                clr: Color(0xffB9BDD3),
                                                size: 12,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 26.w,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 7.w,
                                            height: 7.w,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 1.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              color: selectedColor.value.color,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                title: "Color",
                                                size: 12,
                                              ),
                                              MyText(
                                                title:selectedColor.value.name!,
                                                clr: Color(0xffB9BDD3),
                                                size: 12,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Spacer(),
                                    // Icon(
                                    //   Icons.edit_note_outlined,
                                    //   color: Theme.of(context).primaryColor,
                                    //   size: 35,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                ])
              ],
            ),
          );
        }),
      ),
    );
  }
  searchBrand({required String s}) async {
    // searchBrands.clear();
    // var cars = i.value.brands.value.data;
    // if(cars!.isNotEmpty)
    // {
    //   for (int i = 0; i < cars.length; i++) {
    //     String name = cars[i].name != null ? "${cars[i].name}" : '';
    //     if (name.toLowerCase().contains(s.toLowerCase()))
    //     {
    //       searchBrands.add(cars[i]);
    //     }
    //   }
    // }
    // searchBrands.refresh();
  }

  validateNoPlate(){
    var t = plateNumberController.value.text;
    if (t.isEmpty) {
      CustomToast().showToast("Error", "Plate number is required", true);
    } else{
      i++;
      onNext();
    }

    // if(city=="Abu Dhabi"){
    //   int number = int.parse(t);
    //   if (t.length < (abuDhabiLength-1)) {
    //     CustomToast().showToast("Error", "Plate number should be at least 6 digits", true);
    //   }
    //   // else if(t[0]==1 || (number >= 4 && number <= 18)){
    //   //   CustomToast().showToast("Success", "Valid plate number", false);
    //   //   onNext();
    //   // }
    //   else {
    //     CustomToast().showToast("Success", "Valid plate number", false);
    //     onNext();
    //   }
    // }
    // else if(city=="Ajman"){
    //     RegExp regex = RegExp(r'^[A-Z]{1}[0-9]{5}$');
    //   if (t.length < (ajmanLength)) {
    //     CustomToast().showToast("Error", "Plate number should be at least 6 digits", true);
    //   }
    //   else if(!ajmanList.contains(t[0])){
    //     CustomToast().showToast("Error", "Only A, B, C, D, E, and H can be the first letter.", true);
    //   }
    //   else if(!regex.hasMatch(t)){
    //     CustomToast().showToast("Error", "Plate number should contain numbers except first letter", true);
    //   } else if(regex.hasMatch(t)){
    //     CustomToast().showToast("Success", "Valid plate number", false);
    //     onNext();
    //   }
    // }
    // else if(city=="Dubai"){
    //   RegExp regex = RegExp(r'^[A]{1,2}[0-9]{5}$');
    //   if (t.length < ((dubaiLength-1))) {
    //     CustomToast().showToast("Error", "Plate number should be at least 6 digits", true);
    //   }
    //   else if(!(dubaiList.contains(t[0]) || dubaiList.contains(t[0]+t[1]))){
    //     CustomToast().showToast("Error", "Only A and AA can be first letters.", true);
    //   }
    //   else if(!regex.hasMatch(t)){
    //     CustomToast().showToast("Error", "Plate number should contain numbers except first two letters", true);
    //   } else if(regex.hasMatch(t)){
    //     CustomToast().showToast("Success", "Valid plate number", false);
    //     onNext();
    //   }
    // }
    // else if(city=="Fujairah"){
    //   RegExp regex = RegExp(r'^[A-Z]{1}[0-9]{5}$');
    //   if (t.length < ((fujairahLength))) {
    //     CustomToast().showToast("Error", "Plate number should be at least 6 digits", true);
    //   }
    //   else if(!(fujairahList.contains(t[0]))){
    //     CustomToast().showToast("Error", "Number plates can have one of the letters: A to G, K, M, P, R, S, or T", true);
    //   }
    //   else if(!regex.hasMatch(t)){
    //     CustomToast().showToast("Error", "Plate number should contain numbers except first letter", true);
    //   } else if(regex.hasMatch(t)){
    //     CustomToast().showToast("Success", "Valid plate number", false);
    //     onNext();
    //   }
    // }
    // else if(city=="Ras Al Khaimah"){
    //   RegExp regex = RegExp(r'^[A-Z]{1}[0-9]{5}$');
    //   if (t.length < ((rasLength))) {
    //     CustomToast().showToast("Error", "Plate number should be at least 6 digits", true);
    //   }
    //   else if(!(rasList.contains(t[0]))){
    //     CustomToast().showToast("Error", "Number plates can have one of the letters: A, C, D, I, K, M, N, S, V or Y", true);
    //   }
    //   else if(!regex.hasMatch(t)){
    //     CustomToast().showToast("Error", "Plate number should contain numbers except first letter", true);
    //   } else if(regex.hasMatch(t)){
    //     CustomToast().showToast("Success", "Valid plate number", false);
    //     onNext();
    //   }
    // }
    // else if(city=="Sharjah"){
    //   int number = int.parse(t[0]);
    //   if (t.length < (sharjahLength)) {
    //     CustomToast().showToast("Error", "Plate number should be at least 6 digits", true);
    //   }
    //   else if(!(number >= 1 && number <= 4)){
    //     CustomToast().showToast("Success", "Number plate first letter can contain any number from 1 to 4 ", true);
    //   }
    //   else {
    //     onNext();
    //   }
    // }

  }
  onNext(){
    // i.value.chooseCity.value = false;
    // i.value.chooseTransmission.value = true;
    // i.value.chooseNoPlate.value = false;
    // i.value.chooseColor.value = false;
    // i.value.chooseBrand.value = false;
    // i.value.chooseModel.value = false;
  }

  RxString city = "Abu Dhabi".obs;
  List cities = ["Abu Dhabi", "Ajman", "Dubai", "Fujairah", "Ras Al Khaimah", "Sharjah", "Umm al-Quwain",];
  Rx<MenuModel> selectedColor = MenuModel(name: "Black", color: Color(0xff000000)).obs;
  List<MenuModel> colors = [
    MenuModel(name: "Beige", color: Color(0xffE7D7B3)),
    MenuModel(name: "White", color: Color(0xffFFFFFF)),
    MenuModel(name: "Black", color: Color(0xff000000)),
    MenuModel(name: "Red", color: Color(0xffFF0000)),
    MenuModel(name: "Grey", color: Color(0xff808080)),
    MenuModel(name: "Gold", color: Color(0xffFFD700)),
    MenuModel(name: "Silver", color: Color(0xffC0C0C0)),
    MenuModel(name: "Blue", color: Color(0xff4F84CC)),
    MenuModel(name: "Bronze", color: Color(0xffCCAA7C)),
    MenuModel(name: "Brown", color: Color(0xff975C33)),
    MenuModel(name: "Burgundy", color: Color(0xff751423)),
  ];
List<MenuModel> carBrands = [
  MenuModel(name: "Mercedes", image: ImagePath.mercedes,),
  MenuModel(name: "BMW", image: ImagePath.bmw,),
  MenuModel(name: "Nissan", image:  ImagePath.nissan,),
  MenuModel(name: "Honda", image: ImagePath.honda,)
];
  List<String> plateCodes =['1','4','5','6','7','8','9','10','11','12','13','14','15','16','17','50'];
  RxBool plateToggle = false.obs;

  RxString selectedSeries = "1 Series".obs;
Rx<MenuModel> selectedCarBrand = MenuModel(name: "BMW", image: ImagePath.bmw,).obs;
}
