import 'dart:ui';

import 'package:flutter/services.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_radio_tile.dart';
import 'package:drivy_user/Component/custom_textfield.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Widget/Dialog/order_place.dart';
import 'package:drivy_user/View/Widget/counter.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'card_tile.dart';

class SelectPayment extends StatefulWidget {
  bool fromLiveStream;
  SelectPayment({required this.fromLiveStream});
  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  RxString payment= ''.obs;
  TextEditingController address = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController state = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // checkProductInCart();
    // setFields();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BaseView(
          screenTitle: 'Select Payment Card',
          showAppBar: true,
          showBackButton: true,
          resizeBottomInset: true,
          trailingAppBar: IconButton(icon: Icon(Icons.add_box_rounded,color: MyColors().purpleLight,),onPressed: (){
            AppNavigation.navigateTo(context, AppRouteName.ADD_CARD_ROUTE);
          },),
          floating:!keyboardIsOpen? MyButton(
              width: 90.w,
              title: 'Place order',
              onTap: () {
               onSubmit();
              }):null,
          child: GetBuilder<HomeController>(
              builder: (d) {
              return CustomPadding(
                horizontalPadding: 3.w,
                topPadding: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          d.cards.isEmpty?Container(
                              child: MyText(title: 'No Cards',),
                          alignment: Alignment.center,margin: EdgeInsets.symmetric(vertical: 10.h),): ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: d.cards.length,
                              itemBuilder: (context,index){
                                return CardTile(c: d.cards[index],index: index,);
                              }),
                          SizedBox(height: 1.h,),
                          const MyText(title: "Your Location",size: 14,fontWeight:FontWeight.w600 ,),
                          SizedBox(height: 1.h,),
                          CustomCard(
                            padding: EdgeInsets.zero,
                            child: MyTextField(
                              backgroundColor: Colors.transparent,
                              hintText: 'Delivery Address',
                              controller: address,
                              textColor: Colors.black,
                              hintTextColor: MyColors().greyColor,
                              readOnly: true,
                              onTap: (){getAddress(context);},
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          CustomCard(
                            padding: EdgeInsets.zero,
                            child: MyTextField(
                              backgroundColor: Colors.transparent,
                              hintText: 'Zip Code',
                              controller: zipcode,
                              textColor: Colors.black,
                              maxLength: 9,
                              inputType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                              inputFormate: FilteringTextInputFormatter.digitsOnly,
                              hintTextColor: MyColors().greyColor,
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          CustomCard(
                            padding: EdgeInsets.zero,
                            child: MyTextField(
                              backgroundColor: Colors.transparent,
                              hintText: 'State',
                              controller: state,
                              textColor: Colors.black,
                              hintTextColor: MyColors().greyColor,
                              maxLength: 35,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          getTotalCard(),
                          SizedBox(height: 7.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          )
      ),
    );
  }
  getTotalCard(){
    return GetBuilder<HomeController>(
      builder: (d) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(title: "Price",fontWeight: FontWeight.w700,),
                MyText(title: "\$${d.cartTotal.toStringAsFixed(2)}"),
              ],
            ),
            SizedBox(height: 1.h,),
            const Divider(),
            SizedBox(height: 1.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(title: "Tax",fontWeight: FontWeight.w700,),
                MyText(title: "\$${d.productTax.toStringAsFixed(2)}"),
              ],
            ),
            SizedBox(height: 1.h,),
            const Divider(),
            SizedBox(height: 1.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(title: "Sub Total",fontWeight: FontWeight.w700,),
                MyText(title: "\$${d.totalAmount.toStringAsFixed(2)}",fontWeight: FontWeight.w600,)
              ],
            ),
            SizedBox(height: 1.h,),
            const Divider(),
          ],),
        );
      }
    );
  }
  getAddress(context) async {
    // Prediction? p = await PlacesAutocomplete.show(offset: 0, logo: const Text(""), types: [], strictbounds: false, context: context, apiKey: Utils.googleApiKey, mode: Mode.overlay, language: "us",);
    // if(p!=null){
    //   address.text = p.description??'';
    // }
    LocationResult t= await Utils().showPlacePicker(context);
    Map<String,dynamic> temp=   await Utils.findStreetAreaMethod(context:context,prediction: t.formattedAddress.toString());
    address.text = temp["address"] ?? "";
    state.text = temp["state"] ?? "";
    zipcode.text = t.postalCode??'';
  }
  onSubmit(){
    var h = HomeController.i;
    h.address=address.text;
    h.zipCode=zipcode.text;
    h.state=state.text;
    h.orderValidation(onSuccess: (){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: const EdgeInsets.fromLTRB(
                    0, 0, 0, 0),
                content: OrderPlaceDialog(fromLiveStream: widget.fromLiveStream,),
              ),
            );
          }
      );
    },context);
  }
  setFields(){
    address.text='71 ST. NICHOLAS DRIVE';
    zipcode.text='99705';
    state.text='Utah';
  }
}
