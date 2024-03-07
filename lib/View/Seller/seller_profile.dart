import 'dart:ffi';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_driver/Arguments/content_argument.dart';
import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_icon_container.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Model/stream_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/app_size.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/Utils/utils.dart';
import 'package:drivy_driver/View/Products/product_tile.dart';
import 'package:drivy_driver/View/Widget/bordered_container.dart';
import 'package:drivy_driver/View/Widget/follower_following_tile.dart';
import 'package:drivy_driver/View/Widget/profile_card.dart';
import 'package:drivy_driver/View/Widget/search_tile.dart';
import 'package:drivy_driver/View/Widget/streaming_card.dart';

import 'package:drivy_driver/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_bottomsheet_indicator.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Model/user_model.dart';
import '../Products/products.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({super.key});

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile>
    with SingleTickerProviderStateMixin {
  TextEditingController s = TextEditingController();
  Rx<User> u = User().obs;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {HomeController.i.onProfileVisitBack();});
  }

  late TabController _tabController;
  final _tabs = [
    const Tab(text: 'Products'),
    const Tab(text: 'Live Streamings'),
  ];

  // bool followUser=false;
  RxString followStatus = AppStrings.FOLLOW.obs;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        clearFollowFollowers();
        return true;
      },
      child: BaseView(
        showAppBar: false,
        // leadingAppBar: const MenuIcon(),
        showBackButton: !seller,
        showBottomBar: true,
        resizeBottomInset: false,
        showDrawer: true,
        leadingAppBar: const MenuIcon(),
        trailingAppBar: const EditProfileIcon(),
        screenTitle: seller ? 'My Profile' : "Seller Profile",
        // trailingAppBar: const NotificationIcon(),
        child: CustomRefresh(
          onRefresh: () {},
          child: GetBuilder<HomeController>(
              builder: (d) {
                return CustomPadding(
                  topPadding: 2.h,
                  horizontalPadding: 3.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(
                        screenTitle: seller ? 'My Profile' : "Seller Profile",
                        leading: seller ? const MenuIcon() : CustomBackButton(),
                        trailing: seller ? const EditProfileIcon() : null,
                        bottom: 2.h,),
                      profileCard(),
                      if(!influencer)...[
                        Container(
                          // height: kToolbarHeight - 8.0,
                          decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1.0, color: MyColors()
                                    .greyColor,),)

                          ),
                          child: TabBar(
                            controller: _tabController,
                            // isScrollable: true,
                            indicator: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                  width: 1.0, color: MyColors().black,),)
                            ),
                            unselectedLabelStyle: GoogleFonts.poppins(
                              color: MyColors().lightGreyColor.withOpacity(.1),
                            ),
                            labelColor: MyColors().black,
                            tabs: _tabs,
                            labelStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              sellerProducts(p: d.sellerProducts),
                              ListView(
                                physics: const ClampingScrollPhysics(),
                                children: [
                                  if(d.liveStreaming.value.id != '' && user && followStatus.value== AppStrings.UN_FOLLOW)...[
                                    StreamCard(
                                      width: 100.w,
                                      height: 28.h,
                                      leading: Expanded(
                                        child: Row(
                                          children: [
                                            BorderedContainer(child:
                                            MyText(title: ' LIVE ',
                                              clr: MyColors().purpleColor,
                                              size: 10,),),
                                            const Spacer()
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                         await HomeController.i.joinStreaming(context, onSuccess: () {AppNavigation.navigateTo(context, AppRouteName.LIVE_STREAM_ROUTE);}, roomId: d.liveStreaming.value.roomId);
                                      },
                                      s: d.liveStreaming.value,
                                      trailing: BorderedContainer(
                                        child: Image.asset(
                                          ImagePath.group, width: 5.w,),),
                                    ),
                                    SizedBox(height: 1.5.h,),
                                  ],
                                  const MyText(title: 'Recent Live stream',
                                    size: 16,
                                    fontWeight: FontWeight.w500,),
                                  SizedBox(height: 1.5.h,),
                                  streamedVideos(s: d.streamedVideos),
                                  SizedBox(height: 1.5.h,),
                                ],
                              ),
                            ],
                            //controller: _tabController,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }
          ),
        ),
      ),
    );
  }

  sellerProducts({required RxList<ProductsModel> p}) {
    return p.isEmpty ? CustomEmptyData(title: 'No Products',) : GridView
        .builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .89,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: p.length,
        itemBuilder: (context, index) {
          return ProductTile(index: index, showFavorite: user, p: p[index],);
        });
  }

  streamedVideos({required RxList<StreamModel> s}) {
    return s.isEmpty ? CustomEmptyData(title: 'No Videos',) :
    GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .71,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: s.length,
        itemBuilder: (context, index) {
          return StreamCard(s: s[index], isVideo: true, onTap: () {
            HomeController.i.getRecordedStream(s: s[index]);
          },showViewersCount: false,);
        });
  }

  profileCard() {
    return Obx(() =>
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 3,
          color: MyColors().whiteColor,
          margin: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // color: Colors.pink
            ),
            padding: EdgeInsets.all(2.5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 3.5.h,
                      backgroundColor: MyColors().pinkColor,
                      child: CircleAvatar(
                        radius: 3.3.h,
                        backgroundColor: MyColors().whiteColor,
                        child: CustomImage(
                          height: 6.5.h,
                          width: 6.5.h,
                          isProfile: true,
                          photoView: false,
                          url: u.value.userImage,
                          radius: 100,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            HomeController.i.getFollowers(context: context, id: u.value.id);
                            // showUsers(
                            //     context, isFollower: true, users: HomeController
                            //     .i.followers);
                            showUsers2(context,isFollowing: false,users: HomeController.i.followers);

                          },
                          child: Column(
                            children: [
                              MyText(title: '${u.value.followers}',
                                size: 18,
                                fontWeight: FontWeight.w700,
                                line: 1,),
                              const MyText(title: 'Followers',
                                size: 14,
                                fontWeight: FontWeight.w700,
                                line: 1,),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w,),
                        GestureDetector(
                          onTap: () async {
                            HomeController.i.getFollowing(context: context, id: u.value.id);
                            // showUsers(context, isFollower: false,
                            //     users: HomeController.i.following);
                            // // showUsers(context,isFollowing: true,users: HomeController.i.following);
                            showUsers2(context,isFollowing: true,users: HomeController.i.following);

                          },
                          child: Column(
                            children: [
                              MyText(title: '${u.value.following}',
                                size: 18,
                                fontWeight: FontWeight.w700,
                                line: 1,),
                              const MyText(title: 'Following',
                                size: 14,
                                fontWeight: FontWeight.w700,
                                line: 1,),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(1.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      MyText(
                                        title: '${u.value.firstName} ${u.value
                                            .lastName}',
                                        size: 16,
                                        fontWeight: FontWeight.w700,),
                                      const MyText(
                                        title: 'Seller',
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                        line: 1,
                                        fontStyle: FontStyle.italic,),
                                    ],),
                                ),
                                SizedBox(width: 2.w,),
                                GestureDetector(
                                  onTap: () {
                                    HomeController.i.endUser.value = u.value;
                                    AppNavigation.navigateTo(context, AppRouteName.ALL_REVIEWS_ROUTE);
                                  },
                                  child: BorderedContainer(child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Image.asset(ImagePath.star, width: 2.5.w,
                                        color: MyColors().purpleColor,),
                                      MyText(
                                        title: ' ${u.value.avgRating ?? 0} ',
                                        clr: MyColors().purpleColor,
                                        size: 10,)
                                    ],),),
                                ),
                                SizedBox(width: 2.w,),
                              ],
                            ),
                          ),
                          if(user)
                            Row(children: [
                              // if(followStatus.value==AppStrings.FOLLOW)
                              //   MyButton(title: AppStrings.FOLLOW,width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: (){
                              //     followStatus.value=AppStrings.UN_FOLLOW;
                              //   },),
                              // if(followStatus.value==AppStrings.UN_FOLLOW)
                              //   MyButton(title: AppStrings.UN_FOLLOW,width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: (){
                              //     followStatus.value=AppStrings.FOLLOW;
                              //   }),
                              MyButton(title: followStatus.value,
                                  width: 30.w,
                                  height: 4.5.h,
                                  fontSize: 12,
                                  radius: 4,
                                  onTap: () {
                                    HomeController.i.addFollowUnFollow(
                                        context, onSuccess: () {
                                      followStatus.value =
                                      followStatus.value == AppStrings.FOLLOW
                                          ? AppStrings.UN_FOLLOW
                                          : AppStrings.FOLLOW;
                                      if (followStatus.value ==
                                          AppStrings.UN_FOLLOW) {
                                        HomeController.i.endUser.value.followers++;
                                        AuthController.i.user.value.following++;
                                        AuthController.i.user.refresh();
                                      } else {
                                        // u.value.followers--;
                                        HomeController.i.endUser.value.followers--;
                                        AuthController.i.user.value.following--;
                                        AuthController.i.user.refresh();
                                      }
                                    }, id: u.value.id);
                                  }),

                              SizedBox(width: 2.w,),
                              GestureDetector(
                                onTap: () {
                                  AppNavigation.navigateTo(
                                      context, AppRouteName.CHAT_SCREEN_ROUTE,
                                      arguments: ScreenArguments(u: u.value));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(1.h),
                                    decoration: BoxDecoration(
                                      color: MyColors().pinkColor,
                                      borderRadius: BorderRadius.circular(
                                          4),
                                    ),
                                    child: Image.asset(ImagePath.chatIcon,
                                        color: MyColors().whiteColor,
                                        width: 2.5.h,
                                        height: 2.5.h)
                                ),
                              )

                            ],),
                          // MyButton(title: followUser?'Following':'Follow',width: 30.w,height: 4.5.h,fontSize: 14,onTap: (){followUser=!followUser; setState(() {}); },bgColor: followUser?MyColors().whiteColor:null,textColor: followUser?MyColors().pinkColor:null,borderColor: followUser?MyColors().pinkColor:null,),
                          if(influencer)
                            Row(
                              children: [
                                MyButton(
                                  title: 'Contract Signed',
                                  width: 30.w,
                                  height: 4.5.h,
                                  fontSize: 12,
                                  radius: 4,),
                                SizedBox(width: 2.w,),
                                GestureDetector(
                                  onTap: () {
                                    AppNavigation.navigateTo(
                                        context, AppRouteName.CHAT_SCREEN_ROUTE,
                                        arguments: ScreenArguments(u: u.value));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(1.h),
                                      decoration: BoxDecoration(
                                        color: MyColors().pinkColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Image.asset(ImagePath.chatIcon,
                                          color: MyColors().whiteColor,
                                          width: 2.5.h,
                                          height: 2.5.h)
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: .5.h,),
                      if(u.value.dob != '')...[
                        MyText(
                          title: 'Age : ${Utils().calculateAgeFromDateOfBirth(
                              d: u.value.dob)}',
                          size: 12,
                          fontWeight: FontWeight.w500,
                          line: 1,
                          fontStyle: FontStyle.italic,),
                        SizedBox(height: .4.h,),
                      ],
                      if(u.value.email != '')...[
                        MyText(title: 'Email: ${u.value.email}',
                          size: 12,
                          fontWeight: FontWeight.w500,
                          line: 1,),
                        SizedBox(height: .4.h,),
                      ],
                      if(u.value.phoneNumber != null)...[
                        MyText(title: 'Phone: ${Utils().addPlusSign(u.value.dialCode)} ${u.value.phoneNumber}',
                            size: 12,
                            fontWeight: FontWeight.w500),
                        // MyText(title: 'Phone: +$phone',size: 12,fontWeight: FontWeight.w500),
                        SizedBox(height: .4.h,),
                      ], SizedBox(height: .4.h,),
                      if(u.value.location != null)...[
                        if(u.value.location!.address != null)...[
                          MyText(title: 'Location: ${u.value.location!
                              .address}', size: 12, fontWeight: FontWeight
                              .w500,),
                          SizedBox(height: .4.h,),
                        ],
                      ],
                      if((u.value.socialLinks?.facebook != null &&
                          u.value.socialLinks?.facebook != '') ||
                          (u.value.socialLinks?.twitter != null &&
                              u.value.socialLinks?.twitter != ''))...[
                        const MyText(title: 'Social Links:',
                          size: 12,
                          fontWeight: FontWeight.w700,
                          line: 1,),
                        SizedBox(height: .4.h,),
                      ],

                      Row(
                        children: [
                          if(u.value.socialLinks != null)...[
                            Expanded(
                              child: Column(
                                children: [
                                  if(u.value.socialLinks?.facebook != null &&
                                      u.value.socialLinks?.facebook != '')...[
                                    InkWell(
                                      onTap: () {
                                        AppNavigation.navigateTo(context,
                                            AppRouteName.CONTENT_SCREEN,
                                            arguments: ContentRoutingArgument(
                                                title: 'Facebook',
                                                url: '${u.value.socialLinks
                                                    ?.facebook}',
                                                contentType: ''));
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImagePath.facebookIcon, width: 5.w,
                                            color: MyColors().fbColor,),
                                          SizedBox(width: 1.w,),
                                          Expanded(child: MyText(
                                            title: '${u.value.socialLinks
                                                ?.facebook}',
                                            size: 12,
                                            fontWeight: FontWeight.w500,
                                            under: true,)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: .4.h,),
                                  ],
                                  if(u.value.socialLinks?.twitter != null &&
                                      u.value.socialLinks?.twitter != '')...[
                                    InkWell(
                                      onTap: () {
                                        AppNavigation.navigateTo(context,
                                            AppRouteName.CONTENT_SCREEN,
                                            arguments: ContentRoutingArgument(
                                                title: 'Twitter',
                                                url: '${u.value.socialLinks
                                                    ?.twitter}',
                                                contentType: ''));
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImagePath.twitterIcon, width: 5.w,
                                            color: MyColors().twitterColor,),
                                          SizedBox(width: 1.w,),
                                          Expanded(child: MyText(
                                              title: '${u.value.socialLinks
                                                  ?.twitter}',
                                              size: 12,
                                              fontWeight: FontWeight.w500,
                                              under: true)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                          if(influencer)
                            MyButton(title: followStatus.value,
                                width: 30.w,
                                height: 4.5.h,
                                fontSize: 12,
                                radius: 4,
                                onTap: () {
                                  HomeController.i.addFollowUnFollow(
                                      context, onSuccess: () {
                                    followStatus.value =
                                    followStatus.value == AppStrings.FOLLOW
                                        ? AppStrings.UN_FOLLOW
                                        : AppStrings.FOLLOW;
                                    if (followStatus.value ==
                                        AppStrings.UN_FOLLOW) {
                                      // u.value.followers++;
                                      HomeController.i.endUser.value.followers++;
                                      AuthController.i.user.value.following++;
                                      AuthController.i.user.refresh();
                                    } else {
                                      // u.value.followers--;
                                      HomeController.i.endUser.value.followers--;
                                      AuthController.i.user.value.following--;
                                      AuthController.i.user.refresh();
                                    }
                                  }, id: u.value.id);
                                }),
                        ],
                      ),

                    ],
                  ),
                ),
                // SizedBox(height: 0.5.h),

              ],),
          ),
        ),
    );
  }

  void showUsers(context, {isFollower, required RxList<User> users}) {
    showModalBottomSheet(
        context: context,
        // backgroundColor: MyColors().whiteColor,
        builder: (BuildContext bc) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BottomSheetIndicator(),
                  Expanded(
                    child: users.isEmpty ? CustomEmptyData(
                      title: 'No ${isFollower
                          ? 'Followers'
                          : 'Following'}',) : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return StatefulBuilder(
                              builder: (BuildContext context, StateSetter s) {
                              return FollowFollowers(
                                  isFollowing: false,
                                  u: isFollower
                                      ? HomeController.i.followers[index]
                                      : HomeController.i.following[index]);
                            }
                          );
                          //   GestureDetector(
                          //   onTap: () async {
                          //     if (seller) {
                          //       await HomeController.i.getUserDetail(loading: true,context: context,id: users[index].id);
                          //       AppNavigation.navigatorPop(context);
                          //       if(users[index].role==AppStrings.INFLUENCER){
                          //         AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE);
                          //       } else if(users[index].role==AppStrings.USER){
                          //         AppNavigation.navigateTo(context, AppRouteName.USER_PROFILE_ROUTE);
                          //       }
                          //     }
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.all(1.w) +
                          //         EdgeInsets.symmetric(vertical: 1.h),
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment
                          //           .center,
                          //       children: [
                          //         CircleAvatar(
                          //           radius: 2.5.h,
                          //           backgroundColor: MyColors().pinkColor,
                          //           child: CircleAvatar(
                          //             radius: 2.3.h,
                          //             backgroundColor: MyColors()
                          //                 .whiteColor,
                          //             child: CustomImage(
                          //               height: 5.5.h,
                          //               width: 5.5.h,
                          //               isProfile: true,
                          //               photoView: false,
                          //               url: users[index].userImage,
                          //               radius: 100,
                          //             ),
                          //           ),
                          //         ),
                          //         SizedBox(width: 2.w,),
                          //         Expanded(child: MyText(
                          //           title: '${users[index].firstName} ${users[index].lastName}',
                          //           size: 14,
                          //           fontWeight: FontWeight.w700,)),
                          //         MyButton(
                          //           onTap: () {
                          //             if (users[index].isFollowing==1) {
                          //               HomeController.i.addFollowUnFollow(context, onSuccess: (){
                          //                 HomeController.i.addFollowFollowers(u: users[index]);
                          //               }, id: users[index].id);
                          //
                          //             } else {
                          //               HomeController.i.addFollowUnFollow(context, onSuccess: (){
                          //                 HomeController.i.removeFollowFollowers(isFollowing:isFollow,u: users[index]);
                          //               }, id: users[index].id);
                          //             }
                          //           },
                          //           title: users[index].isFollowing==0
                          //               ? 'Follow'
                          //               : 'UnFollow',
                          //           width: 22.w,
                          //           fontSize: 11,
                          //           height: 4.3.h,)
                          //       ],),
                          //
                          //   ),
                          // );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        }),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
  void showUsers2(context,{required bool isFollowing,required RxList<User> users}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
              ),
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomSheetIndicator(),
                  Obx(()=> Expanded(
                    child: users.isEmpty?CustomEmptyData(title: 'No Users',):
                    ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context,index){
                          return StatefulBuilder(  // You need this, notice the parameters below:
                              builder: (BuildContext context, StateSetter s) {
                                return FollowFollower(u: users[index],isFollowing: isFollowing,onTap: () async{
                                  if(seller){
                                    await HomeController.i.getUserDetail(loading: true, context: context, id: users[index].id);
                                    AppNavigation.navigatorPop(context);
                                    if (users[index].role == AppStrings.INFLUENCER) {
                                      AppNavigation.navigateTo(
                                          context, AppRouteName.INFLUENCER_PROFILE_ROUTE);
                                    } else if (users[index].role == AppStrings.USER) {
                                      AppNavigation.navigateTo(context, AppRouteName.USER_PROFILE_ROUTE);
                                    }
                                  }
                                },);
                              }
                          );
                        },
                        separatorBuilder: (context,index){
                          return Divider();
                        }),
                  ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  bool user = GlobalController.values.userRole.value == UserRole.user;
  bool seller = GlobalController.values.userRole.value == UserRole.seller;
  bool influencer = GlobalController.values.userRole.value ==
      UserRole.influencer;

  getData() async {
    if (seller) {
      u = AuthController.i.user;
      await AuthController.i.getDashboard(context: context);
      u = AuthController.i.user;
      HomeController.i.endUser.value = u.value;
      HomeController.i.sellerProducts = HomeController.i.products;
    } else {
      u = HomeController.i.endUser;
      followStatus.value = Utils().getFollowStatus(v: u.value.isFollowing);
      HomeController.i.getSellerProducts(context: context, id: HomeController.i.endUser.value.id);
      HomeController.i.followers= List<User>.empty().obs;
      HomeController.i.following= List<User>.empty().obs;
    }
    HomeController.i.getUserStreamedVideos(
        context: context, id: u.value.id, role: u.value.role);
  }
  clearFollowFollowers(){
    HomeController.i.followers= List<User>.empty().obs;
    HomeController.i.following= List<User>.empty().obs;
  }
}

class FollowFollowers extends StatelessWidget {
  FollowFollowers({super.key,required this.isFollowing,required this.u});
  bool isFollowing;
  User u;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (seller) {
          await HomeController.i.getUserDetail(
              loading: true, context: context, id: u.id);
          AppNavigation.navigatorPop(context);
          if (u.role == AppStrings.INFLUENCER) {
            AppNavigation.navigateTo(
                context, AppRouteName.INFLUENCER_PROFILE_ROUTE);
          } else if (u.role == AppStrings.USER) {
            AppNavigation.navigateTo(context, AppRouteName.USER_PROFILE_ROUTE);
          }
        }
      },
      child: GetBuilder<HomeController>(
          builder: (d) {
            return Container(
              padding: EdgeInsets.all(1.w) +
                  EdgeInsets.symmetric(vertical: 1.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: [
                  CircleAvatar(
                    radius: 2.5.h,
                    backgroundColor: MyColors().pinkColor,
                    child: CircleAvatar(
                      radius: 2.3.h,
                      backgroundColor: MyColors()
                          .whiteColor,
                      child: CustomImage(
                        height: 5.5.h,
                        width: 5.5.h,
                        isProfile: true,
                        photoView: false,
                        url: u.userImage,
                        radius: 100,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w,),
                  Expanded(child: MyText(
                    title: '${u.firstName} ${u.lastName}',
                    size: 14,
                    fontWeight: FontWeight.w700,)),
                  MyButton(
                    onTap: () async{
                      if (u.isFollowing == 1) {
                       await d.addFollowUnFollow(context, onSuccess: () {d.addFollowFollowers(u: u);}, id: u.id);
                      } else {
                        await d.addFollowUnFollow(context, onSuccess: () {d.removeFollowFollowers(isFollowing: isFollowing, u: u);}, id: u.id);
                      }
                      d.update();
                    },
                    title: u.isFollowing == 0
                        ? 'Follow'
                        : 'UnFollow',
                    width: 22.w,
                    fontSize: 11,
                    height: 4.3.h,)
                ],),

            );
          }
      ),
    );
  }
  bool seller = GlobalController.values.userRole.value == UserRole.seller;

}

