import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../Component/custom_image.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../../Widget/search_tile.dart';
import '../../../base_view.dart';

class CarRentals extends StatefulWidget {
  const CarRentals({super.key});

  @override
  State<CarRentals> createState() => _CarRentalsState();
}

class _CarRentalsState extends State<CarRentals> {
  MyColors colors = MyColors();
  RxString val= '85'.obs;
  List<MenuModel> methods =[
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: '85'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: '100'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022', value: '120'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: '200'.obs, image: ImagePath.rc),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Car Rentals",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h,),
              SearchTile(
                onChange: (val) {
                  if (val.isNotEmpty) {
                  //   searchOn.value = true;
                  //   d.getSearchProducts(s: val);
                  // }
                  // else {
                  //   searchOn.value = false;
                  //   d.update();
                  }
                },
                // search:s,
                showFilter: false,
              ),
              SizedBox(height: 2.h,),
              Expanded(
                child: ListView.builder(
                  itemCount: methods.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuileContext, int index) {
                    return GestureDetector(
                      onTap: (){
                        val.value=methods[index].value!.value;
                        AppNavigation.navigateTo(context, AppRouteName.CarDetail);
                      },
                      child:Container(
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
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 2.8.h,
                                  backgroundColor: MyColors().whiteColor,
                                  child: CustomImage(
                                    height: 6.h,
                                    width: 6.h,
                                    isProfile: true,
                                    photoView: false,
                                    // url: c.user?.userImage,
                                    radius: 100,
                                  ),
                                ),
                                SizedBox(width : 2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(child: MyText(title: 'Marilyn Lipshutz',fontWeight: FontWeight.w700,line: 1,)),
                                          SizedBox(width: 3.w),
                                          Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                                          SizedBox(width: 3.w),
                                          MyText(
                                            title: '4.8',
                                            size: 12,
                                            clr: MyColors().greyColor,
                                            line: 1,
                                            toverflow: TextOverflow.ellipsis,
                                          ),
                                          // MyText(
                                          //   title: Utils.relativeTime(c.createdAt),
                                          //   size: 12,
                                          //   clr: MyColors().greyColor,
                                          //   line: 1,
                                          //   toverflow: TextOverflow.ellipsis,
                                          // ),
                                        ],
                                      ),
                                      // SizedBox(height: .5.h),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 100.w,height: 20.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: AssetImage(ImagePath.rc,),
                                      fit: BoxFit.cover
                                  )
                              ),
                              alignment: Alignment.topRight,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: MyColors().whiteColor
                                  ),
                                  margin: EdgeInsets.only(top: 1.h,right: 1.h),
                                  padding: EdgeInsets.all(6),
                                  child: Image.asset(ImagePath.heartF,scale: 2,)
                              ),
                            ),
                            // Image.asset(ImagePath.rc,scale: 1,fit: BoxFit.cover,width: 100.w,height: 20.h,),
                            SizedBox(height: 1.5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(title: 'Sat, 26th Apr 9:00 PM',size: 13,clr: MyColors().primaryColor,fontWeight: FontWeight.w600,),
                                    MyText(title: 'Ford R200 2022',size: 15,clr: MyColors().textColor2,fontWeight: FontWeight.w600,),
                                  ],
                                ),
                                Flexible(child: MyButton(title: 'AED 120/day',height: 5.h,width: 40.w,radius: 25,))
                              ],
                            ),

                            SizedBox(height: 1.h,),
                            MyText(title:'Egestas nisi rutrum interdum pretium integer amet integer. Sollicitudin molestie mattis dui pharetra sed sed rhoncus dui tempor. Ullamcorper bibendum blandit tempor porttitor lorem lectus sit at egestas. Commodo justo dolor aenean ut libero nisi vitae quis. At dui non et ipsum. ',clr: MyColors().textColor),

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
