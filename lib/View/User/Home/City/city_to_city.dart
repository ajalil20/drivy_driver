import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../../base_view.dart';

class CityToCity extends StatefulWidget {
  const CityToCity({super.key});

  @override
  State<CityToCity> createState() => _CityToCityState();
}

class _CityToCityState extends State<CityToCity> {
  MyColors colors = MyColors();
  RxString val= '85'.obs;
  List<MenuModel> methods =[
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: 'Active'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: 'Completed'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022', value: 'Cancelled'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: 'Active'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: 'Completed'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022', value: 'Cancelled'.obs, image: ImagePath.rc),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "City to city",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h,),
              Expanded(
                child: ListView.builder(
                  itemCount: methods.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuileContext, int index) {
                    return GestureDetector(
                      onTap: (){
                        AppNavigation.navigateTo(context, AppRouteName.CityDetail);
                        // val.value=methods[index].value!.value;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffDAE1F1),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors().whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(bottom: 2.h)+EdgeInsets.symmetric(horizontal: 4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(ImagePath.random0,scale: 1,),
                            SizedBox(height: 1.5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(title: 'AED 1000.00',size: 15,clr: MyColors().primaryColor,fontWeight: FontWeight.w600,),
                                Row(children: [
                                  Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                                  SizedBox(width: 3.w),
                                  MyText(
                                    title: '4.8',
                                    size: 12,
                                    clr: MyColors().greyColor,
                                    line: 1,
                                    toverflow: TextOverflow.ellipsis,
                                  ),
                                ],)
                                // Container(
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(4),
                                //       color: methods[index].value!.value=='Active'?  MyColors().primaryColor.withOpacity(.1):
                                //       methods[index].value!.value=='Completed'?  MyColors().greenColor.withOpacity(.1):
                                //       methods[index].value!.value=='Cancelled'?  MyColors().redColor.withOpacity(.1):null,
                                //     ),
                                //     padding: EdgeInsets.all(4)+EdgeInsets.symmetric(horizontal: 8),
                                //     child: MyText(title: '${methods[index].value!.value}',size: 12,clr:
                                //     methods[index].value!.value=='Active'?  MyColors().primaryColor:
                                //     methods[index].value!.value=='Completed'?  MyColors().greenColor:
                                //     methods[index].value!.value=='Cancelled'?  MyColors().redColor:null,
                                //     )),
                              ],
                            ),
                            SizedBox(height: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(title:'Atlantis Dubai ',size: 16,clr: MyColors().textColor),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,color: MyColors().primaryColor,),
                                    MyText(title:'Salahuddin Rd Deira, Dubai, Emirates ',size: 12,clr: MyColors().textColor),
                                  ],
                                ),
                              ],
                            ),

                          ],),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height:  3.h),

            ],
          ),
        )
    );
  }
}
