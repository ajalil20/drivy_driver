// import 'dart:io';
//
// import 'package:extended_image/extended_image.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:logger/logger.dart';
// import 'package:my_therapist_booth_measure/auth/blocs/get_stripe.dart';
// import 'package:my_therapist_booth_measure/auth/models/user_model.dart';
// import 'package:my_therapist_booth_measure/auth/provider/user_provider.dart';
// import 'package:my_therapist_booth_measure/auth/routing_arguments/image_view.dart';
// import 'package:my_therapist_booth_measure/auth/routing_arguments/merchant_routing_arguments.dart';
// import 'package:my_therapist_booth_measure/auth/routing_arguments/pdf_view_routung_arguments.dart';
// import 'package:my_therapist_booth_measure/core/1_common/check_merchant/blocs/check_merchant_bloc.dart';
// import 'package:my_therapist_booth_measure/core/1_common/check_merchant/widgets/custom_merchant_waiting_dialog.dart';
// import 'package:my_therapist_booth_measure/core/booth_module/main_menu/drawer/state_city/models/language_model.dart';
// import 'package:my_therapist_booth_measure/core/masseur_module/main_menu/drawer_tab/blocs/masseur_profile_bloc.dart';
// import 'package:my_therapist_booth_measure/utils/app_colors.dart';
// import 'package:my_therapist_booth_measure/utils/app_dialogs.dart';
// import 'package:my_therapist_booth_measure/utils/app_navigation.dart';
// import 'package:my_therapist_booth_measure/utils/app_route_name.dart';
// import 'package:my_therapist_booth_measure/utils/asset_path.dart';
// import 'package:my_therapist_booth_measure/utils/constants.dart';
// import 'package:my_therapist_booth_measure/utils/field_validators.dart';
// import 'package:my_therapist_booth_measure/utils/image_gallery_class.dart';
// import 'package:my_therapist_booth_measure/utils/strings/app_strings.dart';
// import 'package:my_therapist_booth_measure/utils/strings/network_strings.dart';
// import 'package:my_therapist_booth_measure/widgets/custom_appbar.dart';
// import 'package:my_therapist_booth_measure/widgets/custom_drop_down_02.dart';
// import 'package:my_therapist_booth_measure/widgets/custom_edit_profile_image_widget.dart';
// import 'package:my_therapist_booth_measure/widgets/custom_extended_image.dart';
// import 'package:my_therapist_booth_measure/widgets/custom_keyboard_action_widget.dart';
// import 'package:my_therapist_booth_measure/widgets/custom_searchable_dropdown.dart';
// import 'package:my_therapist_booth_measure/widgets/custom_text.dart';
// import 'package:my_therapist_booth_measure/widgets/custom_textfeild.dart';
// import 'package:my_therapist_booth_measure/widgets/custom_toast.dart';
// import 'package:my_therapist_booth_measure/widgets/phone_no_textfield.dart';
// import 'package:my_therapist_booth_measure/widgets/simple_button.dart';
// import 'package:provider/provider.dart';
//
// class MasseurProfileScreen extends StatefulWidget {
//   final bool? fromCompleteProfile;
//   final String? email, fullName;
//
//   MasseurProfileScreen(
//       {Key? key, this.fromCompleteProfile, this.email, this.fullName})
//       : super(key: key);
//
//   @override
//   State<MasseurProfileScreen> createState() => _MasseurProfileScreenState();
// }
//
// class _MasseurProfileScreenState extends State<MasseurProfileScreen> {
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _licenseNumberController =
//   TextEditingController();
//   final TextEditingController _licenseController = TextEditingController();
//   final TextEditingController _experienceController = TextEditingController();
//
//   //final TextEditingController _bioController = TextEditingController();
//   final _completeProfileFormKey = GlobalKey<FormState>();
//   var phoneTextFieldFocusNode = FocusNode();
//   String? _userProfileImagePath;
//   String? imageType = AppStrings.IMAGE_FILE_TYPE;
//   String? genderValue;
//   String? countryCode, phoneNumber;
//   String countryIsoCode = "US";
//   String? yearsOfExperience, licenseFilePath;
//   List<Language> selectedLanguage = [];
//   List<String?>? selectedlanguagesString = [];
//   List<Language>? languages;
//   bool _showCreateMerchant = true;
//   bool? isFile, isFilePicked, isNetwork;
//   User? user;
//   bool attachmentNotEmpty = false;
//
//   @override
//   void initState() {
//     _fullNameController.text = widget.fullName ?? "";
//     user = Provider.of<UserProvider>(context, listen: false).getCurrentUser;
//     _loadLanguages();
//     if (!(widget.fromCompleteProfile == true)) {
//       Logger().i("IN DATA LOAD");
//       print(user?.toJson());
//       _setProfileData();
//     }
//     super.initState();
//   }
//
//   Future<void> _loadLanguages() async {
//     languages = await Constants.loadLanguagesFromJson();
//     if (mounted) setState(() {});
//   }
//
//   void fillSelectedLanguages() {
//     (user?.languages ?? []).forEach((language) {
//       selectedLanguage.add(Language(
//         countryName: language,
//       ));
//     });
//     selectedlanguagesString =
//         selectedLanguage.map((e) => e.countryName).toList();
//   }
//
//   void _setProfileData() {
//     _fullNameController.text = user?.fullName ?? "";
//     phoneNumber = user?.phoneNumber ?? "";
//     countryCode = user?.countryCode ?? "";
//     _phoneNumberController.text = user?.phoneNumber ?? "";
//     _experienceController.text = user?.yearsOfExperience ?? "";
//     genderValue = user?.gender ?? "";
//     _licenseNumberController.text = user?.licenseNumber ?? "";
//
//     if ((user?.yearsOfExperience ?? "").isNotEmpty) {
//       yearsOfExperience = user?.yearsOfExperience ?? "";
//     }
//     if ((user?.profileImage ?? "").isNotEmpty) {
//       _userProfileImagePath = (user?.profileImage ?? "");
//     }
//     if ((user?.attachment ?? "").isNotEmpty) {
//       attachmentNotEmpty = true;
//       licenseFilePath = (user?.attachment ?? "");
//       isFilePicked = true;
//       isNetwork = true;
//       print(licenseFilePath);
//     }
//     fillSelectedLanguages();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: !widget.fromCompleteProfile!
//           ? CustomAppBar(
//         onTap: (() => AppNavigation.navigatorPop(context)),
//         title: 'Personal Details',
//       )
//           : null,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 30.w),
//           child: Form(
//             key: _completeProfileFormKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                     height: (widget.fromCompleteProfile == true) ? 70.h : 30.h),
//                 _profileImageWidget(),
//                 SizedBox(height: 28.h),
//                 !widget.fromCompleteProfile!
//                     ? Container()
//                     : _completeProfileLabel(),
//                 !widget.fromCompleteProfile!
//                     ? Container()
//                     : SizedBox(height: 30.h),
//                 ...[
//                   _fullNameTextField(),
//                   SizedBox(height: 15.h),
//                   _genderDropdown(),
//                   SizedBox(height: 15.h),
//                   _phoneNumberTextField(),
//                   SizedBox(height: 5.h),
//                   _userPreferredLanguageDropDown(),
//                   SizedBox(height: 5.h),
//                   _licenseUploadField(),
//                   SizedBox(height: 5.h),
//                   _licenseContainer(),
//                   SizedBox(height: 10.h),
//                   _licenseNumberTextField(),
//                   SizedBox(height: 10.h),
//                   _workExperienceDropdown(),
//                 ],
//                 SizedBox(height: 15.h),
//                 _CreateMerchantButton(context: context),
//                 SizedBox(height: 10.h),
//                 _doneButton(context: context),
//                 SizedBox(height: 15.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _CreateMerchantButton({required BuildContext context}) {
//     return Visibility(
//       visible:
//       _showCreateMerchant == true && (widget.fromCompleteProfile == true),
//       child: CustomButton(
//         backgroundColor: AppColors.red,
//         text: AppStrings.CREATE_MERCHANT,
//         onTap: () {
//           _getStripUrl();
//         },
//       ),
//     );
//   }
//
//   void _getStripUrl() {
//     GetStripeUrlBloc().getStripeBlocMethod(
//       context: context,
//       setProgressBar: () {
//         AppDialogs.progressAlertDialog(context: context);
//       },
//       onApiSuccess: (url) {
//         //  print("url is "+url.toString());
//         _navigateToStripeWebView(url);
//       },
//     );
//   }
//
//   void _navigateToStripeWebView(String? url) {
//     return AppNavigation.navigateTo(
//       context,
//       AppRouteName.MERCHANT_SETUP_WEBVIEW_SCREEN_ROUTE,
//       arguments: MerchantSetUpWebViewRoutingArguments(
//         url: url,
//         isMerchantSetupDone: (bool? value) {
//           if (value == true) {
//             showMerchantSetUpWaitingDialog(context);
//           }
//         },
//       ),
//     );
//   }
//
//   Future<void> showMerchantSetUpWaitingDialog(BuildContext context) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CustomMerchantSetUpWaitingDialog(
//           onDialogClose: (bool dialogClosed) {
//             if (dialogClosed == true) {
//               AppNavigation.navigatorPop(context);
//               checkMerchantApiMethod();
//             }
//           },
//         );
//       },
//     );
//   }
//
//   void checkMerchantApiMethod() {
//     CheckMerchantBloc().blocMethod(
//         context: context,
//         isActive: (String? isActive) {
//           if (isActive == "1") {
//             _showCreateMerchant = false;
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text(AppStrings.MERCHANT_ACCOUNT_CREATED_SUCCESSFULLY),
//               ),
//             );
//             if (mounted) setState(() {});
//           } else {
//             _getStripUrl();
//           }
//         },
//         setProgressBar: () {
//           AppDialogs.progressAlertDialog(context: context);
//         });
//   }
//
//   Widget _licenseContainer() {
//     return Visibility(
//       visible: isFilePicked == true,
//       child: Container(
//         width: 1.sw,
//         height: 200.h,
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.green, width: 2),
//           borderRadius: BorderRadius.circular(15.sp),
//         ),
//         child: (licenseFilePath?.contains("pdf") == true)
//             ? GestureDetector(
//           onTap: () {
//             print(
//                 NetworkStrings.IMAGE_BASE_URL + (licenseFilePath ?? ""));
//             AppNavigation.navigateTo(
//               context,
//               AppRouteName.PDF_VIEW_SCREEN_ROUTE,
//               arguments: PdfViewRoutingArguments(
//                 isFile: !(isNetwork == true),
//                 pdfPath: (licenseFilePath ?? ""),
//               ),
//             );
//           },
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(13.sp),
//             child: ExtendedImage.asset(
//               AssetPath.PDF_IMAGE,
//               fit: BoxFit.fill,
//             ),
//           ),
//         )
//             : GestureDetector(
//           onTap: navigateToViewImageScreen,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(13.sp),
//             child: CustomExtendedImageWidget(
//               isFile: !(isNetwork == true),
//               imagePath: licenseFilePath,
//               isClipped: false,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void navigateToViewImageScreen() {
//     AppNavigation.navigateTo(
//       context,
//       AppRouteName.IMAGE_VIEW_ROUTE,
//       arguments: ImageViewRoutingArguments(
//           imagePath: licenseFilePath, isFileTypeImage: !(isNetwork == true)),
//     );
//   }
//
//   Widget _userPreferredLanguageDropDown() {
//     return Container(
//       //  color: Colors.red,
//       child: CustomSearchableDropDown(
//         dropDownData: languages,
//         hintText: AppStrings.PREFERRED_LANGUAGE,
//         prefix: SizedBox(width: 10.w),
//         horizontalPadding: 0,
//         selectedItems: selectedLanguage,
//         isMultiSelection: true,
//         multiValueValidator: (List<Language>? list) {
//           return ((list ?? []).isEmpty)
//               ? AppStrings.LANGUAGES_CANT_BE_EMPTY
//               : null;
//         },
//         itemAsString: (Language? val) => val?.countryName ?? "",
//         compareFn: (Language a, Language b) {
//           return a.countryName == b.countryName;
//           //&& a.languageName == b.languageName && a.countryCode == b.countryCode;
//         },
//         showTags: true,
//         onChanged: (value) {
//           setState(() {
//             selectedlanguagesString = value?.map((e) => e.countryName).toList();
//             print("value is $value");
//           });
//         },
//       ),
//     );
//   }
//
//   Widget _genderDropdown() {
//     return CustomDropDown2(
//       dropdownValue: genderValue,
//       dropDownData: ['Male', 'Female'],
//       hintText: AppStrings.gender,
//       contentPadding:
//       EdgeInsets.only(left: 8.w) + EdgeInsets.symmetric(vertical: 12.h),
//       menuItemPadding: 4.w,
//       offset: Offset(-8, -21),
//       buttonPadding: 0.w,
//       validator: (value) => (value == null || value.isEmpty)
//           ? 'Gender field can\'t be empty.'
//           : null,
//       onChanged: (value) async {
//         setState(() {
//           genderValue = value;
//           print("NOY");
//           print(genderValue);
//         });
//       },
//     );
//   }
//
//   Widget _workExperienceDropdown() {
//     return CustomDropDown2(
//       dropdownValue: yearsOfExperience,
//       dropDownData: AppStrings.YEARS_EXPERIENCE_LIST,
//       hintText: "Years of Experience",
//       contentPadding:
//       EdgeInsets.only(left: 8.w) + EdgeInsets.symmetric(vertical: 12.h),
//       menuItemPadding: 4.w,
//       offset: Offset(-8, -21),
//       buttonPadding: 0.w,
//       validator: (value) => (value == null || value.isEmpty)
//           ? 'Gender field can\'t be empty.'
//           : null,
//       onChanged: (value) async {
//         setState(() {
//           yearsOfExperience = value;
//           print("NOY");
//         });
//       },
//     );
//   }
//
//   Widget _completeProfileLabel() => CustomText(
//     fontSize: 22,
//     text: AppStrings.completeProfile,
//     fontWeight: FontWeight.w500,
//   );
//
//   Widget _fullNameTextField() {
//     return CustomTextField(
//       hintText: AppStrings.FULL_NAME,
//       controller: _fullNameController,
//       validator: (val) {
//         if (val!.isNotEmpty) {
//           if (!val.isValidName) {
//             return AppStrings.USER_NAME_VALIDATION_TEXT;
//           }
//         } else {
//           return AppStrings.EMPTY_USER_NAME_VALIDATION_TEXT;
//         }
//       },
//     );
//   }
//
//   Widget _phoneNumberTextField() {
//     return PhoneNumberTextField(
//       controller: _phoneNumberController,
//       onChanged: (value) {
//         setState(() {
//           countryCode = value.countryCode;
//           phoneNumber = value.number;
//         });
//       },
//       onCountryChanged: (countryisoCode) {
//         countryIsoCode = countryisoCode.code;
//         setState(() {});
//       },
//       validator: (value) async {
//         Logger().i(value?.countryCode);
//         Logger().i(value?.number);
//         return await value?.number.validateEmpty("Phone Number");
//       },
//     );
//   }
//
//   Widget _licenseNumberTextField() {
//     return CustomKeyboardActionWidget(
//       focusNode: phoneTextFieldFocusNode,
//       child: CustomTextField(
//         hintText: "License Number",
//         //  keyboardType: TextInputType.number,
//         controller: _licenseNumberController,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(Constants.LICENSE_MAX_LENGTH)
//         ],
//         validator: (value) => value?.validateEmpty("License Number"),
//       ),
//     );
//   }
//
//   Widget _licenseUploadField() {
//     return Stack(
//       alignment: Alignment.centerRight,
//       children: [
//         CustomTextField(
//           hintText: AppStrings.license,
//           controller: _licenseController,
//           readOnly: true,
//           onTap: () {
//             ImageGalleryClass().imageGalleryBottomSheet(
//               isPdfFileAvailable: true,
//               context: context,
//               onMediaChanged: (String? value) {
//                 if (value != null) {
//                   attachmentNotEmpty = false;
//                   isFilePicked = true;
//                   isNetwork = false;
//                   licenseFilePath = value;
//                   print("Path");
//                   print(licenseFilePath);
//                 }
//                 setState(() {});
//               },
//             );
//           },
//           // fieldValidator: (val) {
//           //   if (val!.isNotEmpty) {
//           //   } else {
//           //     return AppStrings.EMPTY_SKIILS_VALIDATION_TEXT;
//           //   }
//           // },
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 4),
//           child: Icon(
//             Icons.attach_file,
//             color: AppColors.grey,
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget _profileImageWidget() {
//     return Center(
//       child: CustomEditProfileImageWidget(
//         imagePath: _userProfileImagePath,
//         isFile: isFile,
//         onUploadImageTap: () {
//           ImageGalleryClass().imageGalleryBottomSheet(
//             context: context,
//             onMediaChanged: (value) {
//               setState(() {
//                 _userProfileImagePath = value;
//                 isFile = true;
//               });
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _doneButton({required BuildContext context}) {
//     return CustomButton(
//       backgroundColor: AppColors.green,
//       text: widget.fromCompleteProfile! ? AppStrings.done : AppStrings.save,
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//         if (_completeProfileFormKey.currentState!.validate()) {
//           if (genderValue == null) {
//             AppDialogs.showToast(message: "Select Gender");
//             return;
//           }
//           if (_showCreateMerchant == true &&
//               (widget.fromCompleteProfile == true)) {
//             AppDialogs.showToast(message: "Create Merchant Account");
//             return;
//           }
//           _profileApiMethod();
//         }
//       },
//     );
//   }
//
//   ///   Profile  Api Call Method
//   void _profileApiMethod() {
//     MasseurProfileBloc().profileBlocMethod(
//       context: context,
//       fullName: _fullNameController.text,
//       countryCode: countryCode,
//       phoneNumber: phoneNumber,
//       languages: selectedlanguagesString ?? [],
//       yearsOfExperience: yearsOfExperience,
//       attachment: attachmentNotEmpty ? null : licenseFilePath,
//       email: widget.email,
//       gender: genderValue,
//       licenseNUmber: _licenseNumberController.text,
//       countryIsoCode: countryIsoCode,
//       profileImage: (isFile == true) ? _userProfileImagePath : null,
//       isEditProfile: (widget.fromCompleteProfile == true) ? false : true,
//       setProgressBar: () {
//         AppDialogs.progressAlertDialog(context: context);
//       },
//     );
//   }
// }
