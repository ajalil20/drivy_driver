import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../../base_view.dart';
import 'package:get/get.dart';

class AdditionalService extends StatelessWidget {
  AdditionalService({super.key});

  List<MenuModel> methods =[
    MenuModel(name: 'Car wash',description: 'Mercedes R200 2022',value: '1'.obs, image: ImagePath.wash),
    MenuModel(name: 'Pre-paid fuel',description: 'Mercedes R200 2022',value: '2'.obs, image: ImagePath.tool),
    MenuModel(name: 'Car delivery',description: 'Mercedes R200 2022',value: '3'.obs, image: ImagePath.delivery),
    MenuModel(name: 'Chauffeur service',description: 'Mercedes R200 2022',value: '4'.obs, image: ImagePath.driver2),
    MenuModel(name: 'Additional equipment',description: 'Mercedes R200 2022', value: '5'.obs, image: ImagePath.fuel2),
  ];

  RxString val= 'Car wash'.obs;


  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Availability",
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
              Expanded(
                child: ListView.builder(
                  itemCount: methods.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuileContext, int index) {
                    return GestureDetector(
                      onTap: (){
                        val.value=methods[index].value!.value;
                      },
                      child:Obx(()=> Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: val.value==methods[index].value!.value? MyColors().primaryColor:MyColors().borderColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
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
                          margin: EdgeInsets.only(bottom: 1.5.h),
                          padding: EdgeInsets.all(12)+EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(methods[index].image!,scale: 2,width: 9.w,height: 9.w,color: val.value==methods[index].value!.value? MyColors().primaryColor:MyColors().black,),
                              SizedBox(width: 3.w,),
                              Expanded(child: MyText(title:methods[index].name!,size: 15,clr:val.value==methods[index].value!.value? MyColors().primaryColor:MyColors().black,)),
                              MyText(title:'AED 85',size: 15,clr:
                              val.value==methods[index].value!.value? MyColors().primaryColor:MyColors().greyColor,)
                            ],),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 2.h,),
              MyButton(title: 'Continue',onTap: (){
                AppNavigation.navigatorPop(context);
              },)
            ],),
        )
    );
  }
}
