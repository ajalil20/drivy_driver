import 'dart:developer';
import 'dart:io';
import 'dart:ui';
// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:drivy_driver/Arguments/content_argument.dart';
import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_phone_textfield.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/View/Widget/Dialog/profile_update_dialog.dart';
import 'package:drivy_driver/Component/custom_radio_tile.dart';
import 'package:drivy_driver/Component/title.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:place_picker/place_picker.dart';
import 'package:drivy_driver/Component/custom_rectangle_textfield.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Controller/image_controller.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:drivy_driver/Utils/utils.dart';
import 'package:drivy_driver/View/Widget/bordered_container.dart';
import 'package:drivy_driver/View/Widget/upload_media.dart';
import 'package:drivy_driver/View/base_view.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import '../../../../Utils/image_path.dart';
import '../../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as getImagePath;
import '../../Component/custom_background_image.dart';
import '../../Component/custom_padding.dart';
import '../../Component/custom_textfield.dart';
import '../../Component/custom_title_text.dart';
import '../../Service/api_endpoints.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';

class ProfileSetup extends StatefulWidget {
  bool editProfile;
  ProfileSetup({required this.editProfile});
  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  ImageController imageController = Get.put(ImageController());
  Rx<File> imageProfile = File("").obs;
  RxBool isMerchantSetupDone = false.obs;
  RxBool isMerchantSetupActive = false.obs;
  TextEditingController firstName = TextEditingController();
  RxString email = ''.obs;
  String title = 'Create Profile';
  TextEditingController lastName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController noInstagramFollowers = TextEditingController();
  TextEditingController noTwitterFollowers = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  String country='US';
  String dialCode = "1";
  TextEditingController fb = TextEditingController();
  TextEditingController twitter = TextEditingController();
  double lat=0,lng=0;
  bool emailReadOnly = false, phoneReadOnly = false;
  String? _role;
  String? merchantUrl;
  bool social =GlobalController.values.loginType.value==LoginType.social;
  bool phoneLogin =GlobalController.values.loginType.value==LoginType.phone;
  bool emailLogin =GlobalController.values.loginType.value==LoginType.email;

  /// #Timer
  final Duration _duration = const Duration(seconds: 15);
  final CountDownController _countDownController = CountDownController();
  bool isTimeComplete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setFields();
     _role = GlobalController.values.userRole.value.name;
    print("Current Role:$_role");
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CustomBackgroundImage(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(color: MyColors().whiteColor,),
                    GestureDetector(
                        onTap: (){},
                        child: ScreenTitle(title: title)),
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.transparent,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: CustomPadding(
                  topPadding: 2.h,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Obx(()=> Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              child: CircleAvatar(
                                radius: 55.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 53.0,
                                    backgroundImage:
                                    (imageProfile.value.path == ""?
                                    AuthController.i.user.value.userImage!=null?
                                    NetworkImage(APIEndpoints.baseImageURL+AuthController.i.user.value.userImage??"") :
                                    const AssetImage(ImagePath.noUserImage) :
                                    FileImage(imageProfile.value)) as ImageProvider,
                                    // imageProfile.value.path == "" ?const AssetImage(ImagePath.noUserImage,) : FileImage(imageProfile.value) as ImageProvider,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 14.0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 8.0,
                                          child: GestureDetector(
                                            onTap: () async {
                                              FocusManager.instance.primaryFocus?.unfocus();
                                              Get.bottomSheet(
                                                UploadMedia(
                                                  file: (val) {
                                                    imageProfile.value = val!;
                                                  },
                                                  singlePick: true,
                                                ),
                                                isScrollControlled: true,
                                                backgroundColor: Theme
                                                    .of(context)
                                                    .selectedRowColor,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(20),
                                                        topRight: Radius.circular(20)
                                                    )
                                                ),
                                              );
                                            },
                                            child: Image.asset(
                                              ImagePath.cameraIcon,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              ),
                            )),),
                      SizedBox(height: 3.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Flexible(
                              child: MyTextField(
                                controller: firstName,
                                hintText: 'First Name',
                                maxLength: 30,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Flexible(
                              child: MyTextField(
                                controller: lastName,
                                hintText: 'Last Name',
                                maxLength: 30,
                              ),
                            ),
                          ],),
                          SizedBox(height: 1.5.h,),
                          MyTextField(
                            controller: dob,
                            hintText: 'Date of birth',
                            readOnly: true,
                            onTap: ()async{
                              FocusManager.instance.primaryFocus?.unfocus();
                              dob.text=await Utils().selectDate(context,initialDate: dob.text!=''?Utils().convertToDateTime(d: dob.text):null);
                            },
                          ),
                          SizedBox(height: 1.5.h,),
                          MyTextField(
                            controller: location,
                            hintText: 'Location',
                            readOnly: true,
                            onTap: ()async{await getAddress(context);},
                          ),
                          SizedBox(height: 1.5.h,),
                          PhoneNumberTextField(
                            controller: phone, onCountryChanged:(c){dialCode=c.dialCode;country=c.code; print(country);}, gradient: true,
                            isReadOnly: phoneReadOnly,
                            country: country,
                          ),
                          // MyTextField(
                          //   controller: phone,
                          //   hintText: 'Phone Number',
                          //   inputType: TextInputType.phone,
                          //   contact: true,
                          // ),
                          SizedBox(height: 1.5.h,),
                          MyText(title: 'Add Social Link',clr: MyColors().whiteColor,),
                          SizedBox(height: 1.5.h,),
                          MyTextField(
                            hintText: 'Facebook',
                            controller: fb,
                            prefixWidget:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(ImagePath.facebookIcon,width: 2.w,height: 2.w,fit: BoxFit.contain,),
                            ),
                          ),
                          SizedBox(height: 1.5.h,),
                          MyTextField(
                            hintText: 'Twitter',
                            controller: twitter,
                            prefixWidget:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(ImagePath.twitterIcon,width: 2.w,height: 2.w,fit: BoxFit.contain,),
                            ),
                          ),

                          Visibility(
                            visible: _role == UserRole.influencer.name ? true : false,
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.5.h),
                              child: MyTextField(
                                hintText: 'No. of Instagram Followers',
                                controller: noInstagramFollowers,
                                inputType: TextInputType.number,
                                onlyNumber: true,
                                maxLength: 10,
                              ),
                            ),
                          ),

                          Visibility(
                            visible: _role == UserRole.influencer.name ? true : false,
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.5.h),
                              child: MyTextField(
                                hintText: 'No. of Twitter Followers',
                                controller: noTwitterFollowers,
                                inputType: TextInputType.number,
                                onlyNumber: true,
                                maxLength: 10,
                              ),
                            ),
                          ),

                          SizedBox(height: 1.5.h,),
                          if(emailLogin)...[
                            MyTextField(
                              hintText: 'Email',
                              controller: emailC,
                              suffixIconData: email.value.isEmail? Image.asset(ImagePath.checkIcon,scale: 4,):null,
                              onChanged: (v){
                                email.value=v;
                              },
                              readOnly: emailReadOnly,
                              inputType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                          if(GlobalController.values.userRole.value != UserRole.user && isMerchantSetupActive.isFalse && !widget.editProfile)...[
                            GestureDetector(
                                onTap: () async {
                                  // merchantDialog();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  merchantUrl=await AuthController.i.checkMerchantVerification(context: context);
                                  if(merchantUrl==null){
                                    isMerchantSetupActive.value=true;
                                    isMerchantSetupActive.refresh();
                                    setState(() {});
                                  } else{
                                    AppNavigation.navigateTo(
                                        context, AppRouteName.CONTENT_SCREEN,
                                        arguments: ContentRoutingArgument(
                                            title: AppStrings.CREATE_MERCHANT,
                                            contentType: AppStrings.CREATE_MERCHANT,
                                            isMerchantSetupDone: (v) {
                                              isMerchantSetupDone.value = v;
                                              isMerchantSetupDone.refresh();
                                              merchantDialog();
                                            }, url: merchantUrl??''
                                        ));
                                  }
                                },
                                child: MyText(title: AppStrings.CREATE_MERCHANT,
                                  clr: Colors.blue,)),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                          MyButton(
                              title: "Continue",
                              onTap: () {onSubmit(context);}),
                          SizedBox(height: 5.h),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSubmit(context){
    AuthController.i.imageProfile = imageProfile.value.path;
    AuthController.i.firstName =firstName.text;
    AuthController.i.lastName =lastName.text;
    AuthController.i.dob =dob.text;
    AuthController.i.location =location.text;
    AuthController.i.dialCode =dialCode;
    AuthController.i.countryCode=country;
    AuthController.i.phone =phone.text;
    AuthController.i.email =email.value;
    AuthController.i.noTwitterFollowers =noTwitterFollowers.text;
    AuthController.i.noInstagramFollowers =noInstagramFollowers.text;
    AuthController.i.twitter =twitter.text;
    AuthController.i.fb =fb.text;
    AuthController.i.isMerchantSetupDone =isMerchantSetupDone.value;
    AuthController.i.profileSetupValidation(context,onSuccess: (){successDialog();},editProfile: widget.editProfile);
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
  setFields(){
    var u=AuthController.i.user.value;
    firstName.text=u.firstName;
    lastName.text=u.lastName;
    if(widget.editProfile){
      title='Edit Profile';
      firstName.text=u.firstName;
      lastName.text=u.lastName;
      dob.text=u.dob;
      location.text=u.location?.address;
      // phone.text =u.phoneNumber;
      fb.text=u.socialLinks?.facebook;
      twitter.text=u.socialLinks?.twitter;
      if(u.socialLinks!=null){
        noInstagramFollowers.text =u.socialLinks!.instaFollowers.toString();
        noTwitterFollowers.text = u.socialLinks!.twitterFollowers.toString();
      }
      if(u.phoneNumber!=null){
        phone.text =u.phoneNumber;
        country=u.countryCode;
        dialCode=u.dialCode;
      }
    }
    Utils().setUserLoginType(u.userSocialType);
    log(GlobalController.values.loginType.value.name);
    if(emailLogin){
      emailReadOnly=true;
      emailC.text=u.email;
      email.value=u.email;
    }
    else if(phoneLogin){
      if(u.phoneNumber!=null){
        phone.text =u.phoneNumber;
        country=u.countryCode;
        dialCode=u.dialCode;
      }
      phoneReadOnly=true;
    }
    else if(social){
      if(u.phoneNumber!=null){
        phone.text =u.phoneNumber;
        country=u.countryCode;
        dialCode=u.dialCode;
      }
      emailReadOnly=true;
    }
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
              content: ProfileUpdateDialog(editProfile:widget.editProfile),
            ),
          );
        }
    );
  }
  merchantDialog(){
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
              content: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                // height: responsive.setHeight(75),
                width: 100.w,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: MyColors().purpleLight,borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                        ),
                        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
                        margin: EdgeInsets.symmetric(vertical: 1.w,horizontal: 1.w),
                        alignment: Alignment.center,
                        child: MyText(title: 'Merchant Verification',clr: MyColors().whiteColor,fontWeight: FontWeight.w600,center: true,),

                      ),


                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 2.h,),
                            _circularCountDownTimerWidget(),
                            SizedBox(height: 2.h,),
                            MyText(title: 'Your merchant account is being verified',clr: MyColors().black,size: 13,center: true,),
                            SizedBox(
                              height: 3.5.h,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
  Widget _circularCountDownTimerWidget() {
    return Align(
      alignment: Alignment.center,
      child: CircleAvatar(
        backgroundColor: MyColors().purpleColor,
        radius:12.w,
        child: CircularCountDownTimer(
          duration: _duration.inSeconds,
          initialDuration: 0,
          controller: _countDownController,
          width: 25.w,
          height: 25.w,
          ringColor: MyColors().purpleColor,
          backgroundColor: MyColors().purpleColor,
          fillColor:MyColors().whiteColor,
          strokeWidth: 2.0,
          strokeCap: StrokeCap.square,
          textStyle: TextStyle(
            fontSize: 20.0,color: MyColors().whiteColor,
          ),
          textFormat: CountdownTextFormat.MM_SS,
          isReverse: true,
          isReverseAnimation: false,
          isTimerTextShown: true,
          autoStart: true,
          onStart: () {
            debugPrint('Countdown Started');
          },
          onComplete: () async{
            setState(() {
              isTimeComplete = true;
            });
            debugPrint('Countdown Ended');
            AppNavigation.navigatorPop(context);
            merchantUrl=await AuthController.i.checkMerchantVerification(context: context);
            if(merchantUrl==null){
              isMerchantSetupActive.value=true;
              isMerchantSetupActive.refresh();
              setState(() {});
            } else{
              CustomToast().showToast("Error", 'Your account has not been verified', true);
            }
          },
        ),
      ),
    );
  }
}
