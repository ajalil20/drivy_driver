import 'package:drivy_driver/Component/custom_dropdown.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/painting.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_textfield.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../Component/custom_text.dart';
import '../../base_view.dart';

class HelpSupport extends StatefulWidget {
  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> with SingleTickerProviderStateMixin{
  RxInt supportIndex = 0.obs;
  List support = ["FAQ’s", "Send your Query"];
  TextEditingController name = TextEditingController();
  TextEditingController email= TextEditingController();
  TextEditingController message= TextEditingController();
  List<Category> items = [Category(id: '1',categoryName: 'Toyota')];
  Category? category;

  RxInt selectedIndex = 0.obs;
  List ques = [
    "What is We Train?",
    "Lorem ipsum dolor sit amet consectetur.",
    "Lorem ipsum dolor sit consectetur.",
    "Lorem ipsum dolor sit amet.",
    "Lorem ipsum dolor amet consectetur.",
    "Lorem ipsum dolor sit amet consectetur.",
  ];
  List ans = [
    'Lorem ipsum dolor sit amet consectetur. In id varius in varius proin rutrum aliquam.',
    'Lorem ipsum dolor sit amet consectetur. In id varius in varius proin rutrum aliquam.',
    'Lorem ipsum dolor sit amet consectetur. In id varius in varius proin rutrum aliquam.',
    'Lorem ipsum dolor sit amet consectetur. In id varius in varius proin rutrum aliquam.',
    'Lorem ipsum dolor sit amet consectetur. In id varius in varius proin rutrum aliquam.',
    'Lorem ipsum dolor sit amet consectetur. In id varius in varius proin rutrum aliquam.',
  ];

  final _tabs = [const Tab(text: 'FAQ’s'), const Tab(text: 'Send your Query')];
  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    setData();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    // responsive.setContext(context);
    return BaseView(
      showAppBar: true,
      showBackButton: true,
      screenTitle: "Help & Support",
      centerTitle: false,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.zero, //.only(top: 2.h, left: 4.w, right: 4.w),
            child: Obx(() {
              return Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Stack(
                    fit: StackFit.passthrough,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: MyColors().greyColor.withOpacity(.3), width: 2.0),
                          ),
                        ),
                      ),
                      TabBar(
                        controller: _tabController,
                        isScrollable: false,
                        indicator: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2.0, color:MyColors().primaryColor,),)
                        ),
                        unselectedLabelStyle: GoogleFonts.poppins(
                          color: MyColors().lightGreyColor.withOpacity(.1),
                        ),
                        labelColor: MyColors().black,
                        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16),
                        tabs: _tabs,
                        onTap: (v){
                          supportIndex.value = v;
                          // setState(() {});
                        },
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Flexible(
                  //         child: GestureDetector(
                  //             onTap: () {
                  //               supportIndex.value = 0;
                  //             },
                  //             child: SupportTile(
                  //               text: support[0],
                  //               isSelected:
                  //               supportIndex.value == 0 ? true : false,
                  //             ))),
                  //     Flexible(
                  //         child: GestureDetector(
                  //             onTap: () {
                  //               supportIndex.value = 1;
                  //             },
                  //             child: SupportTile(
                  //                 text: support[1],
                  //                 isSelected: supportIndex.value == 1
                  //                     ? true
                  //                     : false))),
                  //   ],
                  // ),
                  if(supportIndex.value == 0)
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ques.length,
                        itemBuilder: (BuildContext, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: GestureDetector(
                                onTap: () {
                                  selectedIndex.value = index;
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100.w,
                                      // color: Color(0xffFFFAF2),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 1.5.h),
                                      child: Obx(() {
                                        return Column(
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                MyText(
                                                  title: ques[index] ?? "",
                                                  clr: MyColors().textColor,
                                                  fontWeight: FontWeight.w600,
                                                  size: 16,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (selectedIndex.value ==
                                                        index) {
                                                      selectedIndex.value =
                                                      1000;
                                                    }
                                                    else {
                                                      selectedIndex.value =
                                                          index;
                                                    }
                                                    selectedIndex.refresh();
                                                  },
                                                  child: Icon(
                                                    selectedIndex.value ==
                                                        index
                                                        ?
                                                    Icons.close
                                                        : Icons.expand_more,
                                                    color: MyColors()
                                                        .textColor,),
                                                )
                                              ],
                                            ),

                                            if( selectedIndex.value == index)
                                              Divider(),

                                          ],
                                        );
                                      }),
                                    ),
                                    Obx(() =>
                                    selectedIndex.value ==
                                        index
                                        ? Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              5.w,
                                              vertical:
                                              1.1.h),
                                          child: MyText(
                                            title: ans[index],
                                            clr: Colors.black,
                                            size: 12,
                                          ),
                                        ),
                                        SizedBox(height: 1.h,)
                                      ],
                                    )
                                        : Container())
                                  ],
                                )),
                          );
                        }),
                  if(supportIndex.value == 1)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                      child: Column(
                        children: [
                          MyText(title: "How can we help you?",
                            clr: Color(0xff1A0700),
                            size: 24,
                            fontWeight: FontWeight.w600,),
                          SizedBox(height: 2.h,),
                          MyText(
                            title: "Lorem ipsum dolor sit amet consectetur. A sit feugiat sit porttitor morbi eu laoreet.",
                            clr: Color(0xffB3B3B3),
                            center: true,
                            size: 12,
                            fontWeight: FontWeight.w400,),
                          SizedBox(height: 4.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(title: "Full Name",
                                  size: 13,
                                  fontWeight: FontWeight.w600,)),
                          ),
                          MyTextField(
                            width: 90.w,
                            hintText: 'Full Name'.tr,
                            controller: name,
                            onFieldSubmit: (val) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(title: "Email",
                                  size: 13,
                                  fontWeight: FontWeight.w600,)),
                          ),
                          MyTextField(
                            width: 90.w,
                            hintText: 'Email'.tr,
                            controller: email,
                            inputType: TextInputType.emailAddress,
                            onFieldSubmit: (val) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(title: "Booking ID",
                                  size: 13,
                                  fontWeight: FontWeight.w600,)),
                          ),
                          MyTextField(
                            width: 90.w,
                            hintText: 'Booking ID'.tr,
                            inputType: TextInputType.number,
                            maxLength: 8,
                            // controller: email,
                            // inputType: TextInputType.emailAddress,
                            onFieldSubmit: (val) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(title: "Concern type",
                                  size: 13,
                                  fontWeight: FontWeight.w600,)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffB8BAC6),
                                ),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: CustomDropDown2(dropDownData: items,hintText: 'Select Concern type',dropdownValue:category,validator: (v){print(v);
                            return null;},onChanged: (v){category=v;print(v);print(v.id);print(v.categoryName); },),
                          ),

                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(title: "Description",
                                  size: 13,
                                  fontWeight: FontWeight.w600,)),
                          ),
                          MyTextField(
                            width: 90.w,
                            maxLines: 10,
                            height: 15.h,
                            minLines: 6,
                            controller: message,
                            hintText: 'Description'.tr,
                            onFieldSubmit: (val) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          MyButton(title: "Submit",onTap: (){
                            onSubmit();
                          },)

                        ],
                      ),
                    )

                ],
              );
            })),
      ),
    );
  }
  setData(){
    // name.text=UserController.i.user.value.fName??"";
    // email.text =UserController.i.user.value.email??'${UserController.i.user.value.country_code??''}${UserController.i.user.value.phone??''}';
  }
  onSubmit()async{
    AppNavigation.navigatorPop(context);
    // UserController.i.name=name.text;
    // UserController.i.email=email.text;
    // UserController.i.message=message.text;
    // var r = await UserController.i.feedbackValidation();
    // if(r==true){
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           backgroundColor: Colors.transparent,
    //           contentPadding: EdgeInsets.fromLTRB(
    //               0, 0, 0, 0),
    //           content:  FeedbackAertDialog(),
    //         );
    //       }
    //   );
    // }
  }
}

class SupportTile extends StatelessWidget {
  SupportTile({Key? key, this.text, this.isSelected}) : super(key: key);
  String? text;
  bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 6.h,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
            color: isSelected == true ? Color(0xffEBF2FE) : Colors.white,
            border: Border.all(color: Color(0xffEBF2FE))
          // borderRadius: BorderRadius.circular(4),
          // border: Border.all(
          //   color:
          //   isSelected == true ?
          //   Theme
          //       .of(context)
          //       .primaryColor :
          //   Color(0xffB3B3B3),
          // )
        ),
        alignment: Alignment.center,
        child: MyText(
            title: text!, clr: isSelected != true ? Color(0xffB3B3B3) : null));
  }
}


// class HelpSupport extends StatefulWidget {
//   @override
//   State<HelpSupport> createState() => _HelpSupportState();
// }
//
// class _HelpSupportState extends State<HelpSupport> {
//   RxInt supportIndex = 0.obs;
//   List support = ["FAQ’s", "Send your Query"];
//   RxInt selectedIndex = 0.obs;
//   List ques = [
//     "What is Nashmii",
//     "So, where can I save?",
//     "How do I use an offer?",
//     "What is Nashmii and how does it work?",
//   ];
//   List ans = [
//     "The Buy One Get One Free and discount app with over 3 million members globally. We're here to help people experience more and pay less. Thanks to awesome offers at high-quality restaurants, bars, spas, attractions, activities, salons, sports and fitness venues everywhere!",
//     "Choose your Nashmii on our search page to see all brands and places along with the available offers",
//     "Tap the offer you want to use and ask the venue to enter their pin. Voilà - somebody just made a saving!",
//     "Nashmii is an exciting, lite version of our Memberships available on the Nashmii App that anyone who registers on the Nashmii App can use – for free! This means registered users get immediate access to hundreds of great offers with no membership costs! To unlock all offers and get the maximum benefit of what is available on the Nashmii App, simply upgrade to a Standard/Premium/Global membership.",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // responsive.setContext(context);
//     return BaseView(
//       showAppBar: true,
//       showBackButton: true,
//       screenTitle: "Help & Support",
//       appBarColor: Colors.white,
//       bgColor: Colors.white,
//       child: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Padding(
//             padding: EdgeInsets.zero, //.only(top: 2.h, left: 4.w, right: 4.w),
//             child: Obx(() {
//               return Column(
//                 children: [
//                   SizedBox(
//                     height: 2.h,
//                   ),
//                   Row(
//                     children: [
//                       Flexible(
//                           child: GestureDetector(
//                               onTap: () {
//                                 supportIndex.value = 0;
//                               },
//                               child: SupportTile(
//                                 text: support[0],
//                                 isSelected:
//                                 supportIndex.value == 0 ? true : false,
//                               ))),
//                       Flexible(
//                           child: GestureDetector(
//                               onTap: () {
//                                 supportIndex.value = 1;
//                               },
//                               child: SupportTile(
//                                   text: support[1],
//                                   isSelected: supportIndex.value == 1
//                                       ? true
//                                       : false))),
//                     ],
//                   ),
//                   if(supportIndex.value == 0)
//                     ListView.builder(
//                         physics: NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: ques.length,
//                         itemBuilder: (BuildContext, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 0.0),
//                             child: GestureDetector(
//                                 onTap: () {
//                                   selectedIndex.value = index;
//                                 },
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 100.w,
//                                       // color: Color(0xffFFFAF2),
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 5.w, vertical: 1.5.h),
//                                       child: Obx(() {
//                                         return Column(
//                                           children: [
//
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment
//                                                   .spaceBetween,
//                                               children: [
//                                                 MyText(
//                                                   title: ques[index] ?? "",
//                                                   clr: MyColors().textColor,
//                                                   fontWeight: FontWeight.w600,
//                                                   size: 16,
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     if (selectedIndex.value ==
//                                                         index) {
//                                                       selectedIndex.value =
//                                                       1000;
//                                                     }
//                                                     else {
//                                                       selectedIndex.value =
//                                                           index;
//                                                     }
//                                                     selectedIndex.refresh();
//                                                   },
//                                                   child: Icon(
//                                                     selectedIndex.value ==
//                                                         index
//                                                         ?
//                                                     Icons.close
//                                                         : Icons.expand_more,
//                                                     color: MyColors()
//                                                         .textColor,),
//                                                 )
//                                               ],
//                                             ),
//
//                                             if( selectedIndex.value == index)
//                                               Divider(),
//
//                                           ],
//                                         );
//                                       }),
//                                     ),
//                                     Obx(() =>
//                                     selectedIndex.value ==
//                                         index
//                                         ? ListView.builder(
//                                         physics:
//                                         NeverScrollableScrollPhysics(),
//                                         shrinkWrap: true,
//                                         itemCount:
//                                         ques.length,
//                                         // itemCount:
//                                         // index==0?ans1.length:index==1?ans2.length:ans3.length,
//                                         itemBuilder: (BuildContext,
//                                             int ansIndex) {
//                                           return Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .start,
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets
//                                                     .symmetric(
//                                                     horizontal:
//                                                     5.w,
//                                                     vertical:
//                                                     1.1.h),
//                                                 child: MyText(
//                                                   title: ans[index],
//                                                   clr: Colors.black,
//                                                   size: 12,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 1.h,)
//                                             ],
//                                           );
//                                         })
//                                         : Container())
//                                   ],
//                                 )),
//                           );
//                         }),
//                   if(supportIndex.value == 1)
//                     Padding(
//                       padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
//                       child: Column(
//                         children: [
//                           MyText(title: "Feedback",
//                             clr: Color(0xff1A0700),
//                             size: 24,
//                             fontWeight: FontWeight.w600,),
//                           SizedBox(height: 2.h,),
//                           MyText(
//                             title: "We’ve grabbed your name and email from your login but if you prefer, you can change it",
//                             clr: Color(0xffB3B3B3),
//                             size: 12,
//                             fontWeight: FontWeight.w400,),
//                           SizedBox(height: 4.h,),
//                           Padding(
//                             padding: EdgeInsets.only(left: 5.w, bottom: 1.h),
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: MyText(title: "Name",
//                                   size: 12,
//                                   fontWeight: FontWeight.w400,)),
//                           ),
//                           MyTextField(
//                             width: 90.w,
//                             hintText: 'Muhammad'.tr,
//                             onFieldSubmit: (val) {
//                               FocusManager.instance.primaryFocus?.unfocus();
//                             },
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 5.w, bottom: 1.h),
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: MyText(title: "Email",
//                                   size: 12,
//                                   fontWeight: FontWeight.w400,)),
//                           ),
//                           MyTextField(
//                             width: 90.w,
//                             hintText: 'muhammad@yourmail.com'.tr,
//                             onFieldSubmit: (val) {
//                               FocusManager.instance.primaryFocus?.unfocus();
//                             },
//                           ),
//                           SizedBox(
//                             height: 3.h,
//                           ),
//                           MyTextField(
//                             width: 90.w,
//                             maxLines: 10,
//                             height: 20.h,
//                             minLines: 10,
//                             hintText: 'Message'.tr,
//                             onFieldSubmit: (val) {
//                               FocusManager.instance.primaryFocus?.unfocus();
//                             },
//                           ),
//                           SizedBox(
//                             height: 3.h,
//                           ),
//                           MyButton(title: "Submit",onTap: (){
//                             showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     backgroundColor: Colors.transparent,
//                                     contentPadding: EdgeInsets.fromLTRB(
//                                         0, 0, 0, 0),
//                                     content:  FeedbackAertDialog(),
//                                   );
//                                 }
//                             );
//
//                           },)
//
//                         ],
//                       ),
//                     )
//
//                 ],
//               );
//             })),
//       ),
//     );
//   }
// }
