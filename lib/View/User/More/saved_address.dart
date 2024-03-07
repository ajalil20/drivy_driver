import 'package:place_picker/place_picker.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../Component/custom_text.dart';
import '../../../Model/menu_model.dart';
import '../../../Utils/image_path.dart';
import '../../base_view.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({super.key});

  @override
  State<SavedAddress> createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  RxString val= '1'.obs;
  List<MenuModel> methods =[
    MenuModel(name: 'Home',description: 'Box No.27785, Salahuddin Rd Deira, Dubai, Emirates',value: '1'.obs),
    MenuModel(name: 'Craig’s House',description: 'Box No. 504350, Dibba Al-Fujairah, Emirates',value: '2'.obs),
  ];
  double lat=0,lng=0;
  TextEditingController location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Saved Address",
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
              MyText(title: 'Select Payment Card',size: 14,fontWeight: FontWeight.w600,),
              SizedBox(height: 3.h,),
              ListView.builder(
                itemCount: methods.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuileContext, int index) {
                  return GestureDetector(
                    onTap: (){
                      val.value=methods[index].value!.value;
                    },
                    child: Obx(()=> Container(
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Color(0xffDAE1F1).withOpacity(.3),
                        // ),
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
                          Container(padding: EdgeInsets.all(3.3.w),decoration: BoxDecoration(
                            color: MyColors().primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(7)
                          ),child: Image.asset(ImagePath.location,scale: 2,), ),
                          SizedBox(width: 3.w,),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(title:methods[index].name!,size: 16,clr: MyColors().titleColor,fontWeight: FontWeight.w600,),
                                if(methods[index].description!=null)...[
                                  SizedBox(height: .5.h,),
                                  MyText(title:methods[index].description??'',size: 16,clr: MyColors().greyColor,fontWeight: FontWeight.w500,),
                                ],

                              ],
                            ),
                          ),
                          SizedBox(width: 3.w,),
                          Image.asset(
                            val.value==methods[index].value!.value?ImagePath.radioF:ImagePath.radioE,scale: 2,),
                        ],),
                    ),
                    ),
                  );
                },
              ),
              SizedBox(height: 3.h,),
              GestureDetector(
                onTap: ()async{
                  await getAddress(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_box_rounded,color: MyColors().primaryColor,),
                    MyText(title: '  Add new address',clr: MyColors().greyColor,),
                  ],),
              ),
              SizedBox(height:  3.h),

            ],
          ),
        )
    );
  }
  Future<void> getAddress(context) async {
    // Prediction? p = await PlacesAutocomplete.show(offset: 0, logo: const Text(""), types: [], strictbounds: false, context: context, apiKey: Utils.googleApiKey, mode: Mode.overlay, language: "us",);
    // if(p!=null){
    //   location.text = p.description??'';
    // }
    LocationResult t= await Utils().showPlacePicker(context);
    // Map<String,dynamic> temp=  await Utils.findStreetAreaMethod(context:context,prediction: t.formattedAddress.toString());
    print(t.formattedAddress.toString());
    lat=t.latLng?.latitude??0;
    lng=t.latLng?.longitude??0;
    location.text = t.formattedAddress??'';
  }
}
