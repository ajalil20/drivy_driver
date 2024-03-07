// import 'package:drivy_user/Controller/home_controller.dart';
// import 'package:drivy_user/Controller/user_controller.dart';
// import 'package:drivy_user/Service/api_endpoints.dart';
// import 'package:drivy_user/Utils/image_path.dart';
// import 'package:drivy_user/Utils/utils.dart';
// import 'package:drivy_user/View/Widget/bordered_container.dart';
// import 'package:drivy_user/View/Widget/notification_tile.dart';
// import 'package:drivy_user/View/base_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../../Utils/my_colors.dart';
// import '../../../../Utils/responsive.dart';
// import '../../../Component/custom_text.dart';
// import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';
// import '../Component/custom_drawer.dart';
// import '../Component/custom_image.dart';
// import '../Controller/auth_controller.dart';
// import '../Controller/global_controller.dart';
// import '../Service/url_launcher.dart';
// import '../Utils/enum.dart';
// import 'Widget/file_view.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({super.key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   DateTime? currentBackPressTime;
//
//   @override
//   Widget build(BuildContext context) {
//     bool dentist=GlobalController.values.userRole.value == UserRole.Dentist;
//     bool doctor=GlobalController.values.userRole.value == UserRole.Doctor;
//     bool dentistAssistant=GlobalController.values.userRole.value == UserRole.DentistAssistant;
//     bool doctorAssistant=GlobalController.values.userRole.value == UserRole.DoctorAssistant;
//     return WillPopScope(
//       onWillPop:(){
//         return onWillPop(context);
//         // return (doctorAssistant ||dentistAssistant )? Utils().onWillPop(context):null;
//       },
//       child: BaseView(
//           screenTitle:"PROFILE",
//           showAppBar: true,
//           resizeBottomInset: false,
//           screenTitleColor: Theme.of(context).primaryColor,
//           showBackButton:(doctorAssistant ||dentistAssistant )?false:true,
//           showBottomBar:(doctorAssistant ||dentistAssistant )?true:false,
//           showDrawer:(doctorAssistant ||dentistAssistant )?true:false,
//           trailing:(doctorAssistant ||dentistAssistant )?true:false,
//           trailingAppBar:  NotificationTile(),
//           leadingAppBar:  Container(
//             height: 5.5.h,
//             alignment: Alignment.center,
//             margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: .8.h),
//             // padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(3),vertical: responsive.setHeight(1.2)),
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage(ImagePath.menuLogo)
//                 )
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w),
//             child: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Obx(()=> Column(
//                   children: [
//                     const Divider(),
//                     SizedBox(height: 2.h),
//                     MyCustomContainer(
//                       height: 22.h,
//                       width: 90.w,
//                       alignment: Alignment.center,
//                       child: CustomRoundedBorder(radius: 32.w,padding: 0.6.w,border2: Colors.transparent,border3: Colors.transparent,child: CustomImage(shape: BoxShape.circle,isProfile: true,url:AuthController.i.user.value.imageName, )),
//                     ),
//                     SizedBox(height: 2.h),
//                     Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Container(
//                         // height: 17.h,
//                         width:90.h,
//                         decoration: BoxDecoration(
//                           color:  const Color(0xffF3F1F2),
//                             borderRadius: BorderRadius.circular(10),
//                             // border: Border.all(
//                             //     color: Color(0xff282828)
//                             // )
//                         ),
//                         child:   Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.w),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const MyText(
//                                   title: "Details:",
//                                   size: 17,
//                                   line: 1,
//                                   weight: "Semi Bold",
//                                   clr: Color(0xff282828)),
//                               SizedBox(height: 1.h,),
//                               if(doctorAssistant ||dentistAssistant )
//                                  MyText(title: AuthController.i.user.value.name??"",//"Dr. Anthony Joshua",
//                                     size: 15,
//                                     weight: "Semi Bold",
//                                     line: 1,
//                                     toverflow: TextOverflow.ellipsis,
//                                     clr: MyColors().greyColor),
//
//                               if(doctor ||dentist )
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.person,
//                                     color: Theme
//                                         .of(context)
//                                         .primaryColor,
//                                     size: 15,
//                                   ),
//                                   const SizedBox(width: 3,),
//                                    MyText(title: AuthController.i.user.value.name??"",//"Dr. Anthony Joshua",
//                                       size: 12,
//                                       weight: "Semi Bold",
//                                       line: 1,
//                                       toverflow: TextOverflow.ellipsis,
//                                       clr: MyColors().greyColor),
//                                 ],
//                               ),
//                               SizedBox(height: .5.h,),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.assignment_ind,
//                                     color: Theme
//                                         .of(context)
//                                         .primaryColor,
//                                     size: 15, ),
//                                   // MyText(
//                                   //     title: "Type:",
//                                   //     size: 14,
//                                   //
//                                   //     line: 1,
//                                   //     weight: "Semi Bold",
//                                   //     clr:Theme
//                                   //         .of(context)
//                                   //         .primaryColor,),
//
//                                   const SizedBox(width: 3,),
//                                   MyText(title: AuthController.i.user.value.positionTitle,
//                                       size: 12,
//                                       weight: "Semi Bold",
//                                       line: 1,
//                                       toverflow: TextOverflow.ellipsis,
//                                       clr: MyColors().greyColor),
//                                 ],
//                               ),
//                               if(AuthController.i.user.value.email!=null)...[
//                               SizedBox(height: .5.h,),
//                               Row(
//                                 children: [
//
//                                   Icon(
//                                     Icons.email,
//                                     color: Theme
//                                         .of(context)
//                                         .primaryColor,
//                                     size: 15,
//                                   ),
//                                   const SizedBox(width: 3,),
//                                   MyText(title:
//                                   AuthController.i.user.value.email??"",  // dentist? "martin@email.com" :"anthony@email.com",
//                                       size: 12,
//                                       weight: "Semi Bold",
//                                       line: 1,
//                                       toverflow: TextOverflow.ellipsis,
//                                       clr: MyColors().greyColor),
//                                 ],
//                               )],
//                               SizedBox(height: .5.h,),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.phone,
//                                     color: Theme
//                                         .of(context)
//                                         .primaryColor,
//                                     size: 15,
//                                   ),
//                                   const SizedBox(width: 3,),
//                                    MyText(title: AuthController.i.user.value.phone??"", //"111 - 2222 333",
//                                       size: 12,
//                                       weight: "Semi Bold",
//                                       line: 1,
//                                       toverflow: TextOverflow.ellipsis,
//                                       clr: MyColors().greyColor),
//                                 ],
//                               ),
//                               SizedBox(height: .5.h,),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Icon(
//                                     Icons.location_on,
//                                     color: Theme
//                                         .of(context)
//                                         .primaryColor,
//                                     size: 15,
//                                   ),
//                                   const SizedBox(width: 3,),
//                                    Expanded(
//                                     child: MyText(title:
//                                     Utils().getCommaSeparatedText(
//                                       floor: AuthController.i.user.value.floor,
//                                       address: AuthController.i.user.value.location==null?"":AuthController.i.user.value.location!.location,
//                                       state:AuthController.i.user.value.state,
//                                       country:AuthController.i.user.value.country,
//                                     ),
//                                     // AuthController.i.user.value.location!.location??"",//"ABC Road , Street 11, Phoenix, AZ",
//                                         size: 12,
//                                         weight: "Semi Bold",
//                                         line: 5,
//                                         // toverflow: TextOverflow.ellipsis,
//                                         clr: MyColors().greyColor),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 1.h,),
//                               if(doctor ||dentist )
//                               Row(
//                                 children: [
//                                   MyText(
//                                     title: "License no: ",
//                                     size: 14,
//                                     line: 1,
//                                     weight: "Semi Bold",
//                                     clr:Theme
//                                         .of(context)
//                                         .primaryColor,),
//                                    MyText(title: AuthController.i.user.value.licenseNo??"",//"12 - 4444 - 33",
//                                       size: 12,
//                                       weight: "Semi Bold",
//                                       line: 1,
//                                       clr: MyColors().greyColor),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 3.h),
//                    if(AuthController.i.user.value.resume!=null)
//                      ...[
//                     Align(
//                        alignment: Alignment.centerLeft,
//                        child:  Padding(
//                          padding: EdgeInsets.symmetric(horizontal: 2.w),
//                          child: const MyText(
//                           title: "My Resume:",
//                           size: 17,
//                           line: 1,
//                           weight: "Semi Bold",
//                           clr: Color(0xff282828)),
//                        )),
//                     SizedBox(height: 2.h,),
//                     Align(alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 2.w),
//                         child: myResume()
//                       ))
//                    ]
//                   ],
//                 ),
//               ),
//             ),
//           )
//       ),
//     );
//   }
//   onWillPop(context) async {
//     bool dentistAssistant =GlobalController.values.userRole.value == UserRole.DentistAssistant;
//     bool doctorAssistant=GlobalController.values.userRole.value == UserRole.DoctorAssistant;
//     if(dentistAssistant || doctorAssistant){
//       return  Utils().onWillPop(context,currentBackPressTime: currentBackPressTime);
//     }
//     else{
//       Get.back();
//       return true;
//     }
//   }
//   myResume(){
//     var r =AuthController.i.user.value.resume;
//     if(r!=null){
//       if(r.split('.').contains("pdf")) {
//         return FileView(url: AuthController.i.user.value.resume);
//       }
//       else{
//         return CustomImage(
//           url: AuthController.i.user.value.resume,
//           width:  10.h,
//           height: 10.h,
//           fit: BoxFit.cover,
//           radius: 10,
//         );
//       }
//     }
//     else{return
//       MyText(title: "NO PDF");
//       Image.asset(ImagePath.pdf,width: 15.w,);
//     }
//   }
// }