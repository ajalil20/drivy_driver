import 'dart:developer';
import 'dart:ui';
import 'package:drivy_user/Arguments/content_argument.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_horizontal_calender.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_refresh.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/schedule_model.dart';
import 'package:drivy_user/Model/stream_model.dart';
import 'package:drivy_user/Model/user_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_size.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/Widget/bordered_container.dart';
import 'package:drivy_user/View/Widget/follower_following_tile.dart';
import 'package:drivy_user/View/Widget/streaming_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_bottomsheet_indicator.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/auth_controller.dart';
import '../../Utils/utils.dart';
import 'influencer_portfolio.dart';

class InfluencerProfile extends StatefulWidget {
  InfluencerProfile({super.key,this.contractPending,this.contractSigned});
  bool? contractPending,contractSigned;
  @override
  State<InfluencerProfile> createState() => _InfluencerProfileState();
}

class _InfluencerProfileState extends State<InfluencerProfile> {
  RxString followStatus = AppStrings.FOLLOW.obs;
  // RxString status = AppStrings.CREATE_CONTRACT.obs;
  String parsedDate = "";
  String date = "${DateTime.now()}";
  Rx<User> u = User().obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    // if(widget.contractPending==true){
    //   status.value=AppStrings.REQUEST_PENDING;
    // } else if(widget.contractSigned==true){
    //   status.value=AppStrings.CONTRACT_SIGNED;
    // }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {HomeController.i.onProfileVisitBack();});
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        clearFollowFollowers();
        return true;
      },
      child: BaseView(
        showAppBar: false,
        showBackButton: true,
        resizeBottomInset: false,
        screenTitle: influencer?'My Profile':'Influencer Profile',
        child: GetBuilder<HomeController>(
            builder: (d) {
            return CustomRefresh(
              onRefresh: () async{
                // if(!influencer){await d.getUserDetail(loading: false,context: context,id: d.endUser.value.id);}
              },
              child: CustomPadding(
                topPadding: 2.h,
                horizontalPadding: 3.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if(influencer)
                    CustomAppBar(screenTitle:influencer?'My Profile':'Influencer Profile',leading: influencer?const MenuIcon():CustomBackButton(),trailing: influencer?const EditProfileIcon():null,bottom: 2.h,),
                    profileCard(),
                    SizedBox(height: 1.5.h,),
                    if(!influencer)...[
                      MyText(title:'Available Schedule',size: 16,clr: MyColors().blueColor,fontWeight: FontWeight.w500,),
                      // HorizontalCalendar(selectedDate: (p,v) async{
                      //   HomeController.i.startDate=v;parsedDate=p;date=v;setState(() {});fetchData(context);},currentDate:  date==''?DateTime.now().obs:DateTime.parse(date).obs,),
                      SizedBox(height: 1.5.h,),
                      scheduleList(s: d.schedule),
                    ],
                    if(influencer)...[
                      const MyText(title: 'Recent Live stream',size: 16,fontWeight: FontWeight.w500,),
                      SizedBox(height: 1.h,),
                      streamedVideos(s:d.streamedVideos),
                    ],
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  profileCard(){
    return Obx(()=> Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
        color: MyColors().whiteColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // color: Colors.pink
          ),
          padding: EdgeInsets.all(2.5 .w),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius:3.5.h,
                    backgroundColor: MyColors().pinkColor,
                    child: CircleAvatar(
                      radius:3.3.h,
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
                          HomeController.i.getFollowers(context: context,id: u.value.id);
                          // showUsers(context, isFollow: true, users: HomeController.i.followers);
                          showUsers2(context,isFollowing: false,users: HomeController.i.followers);
                        },
                        child: Column(
                          children: [
                            MyText(title: '${u.value.followers}',size: 18,fontWeight: FontWeight.w700,line: 1,),
                            const MyText(title: 'Followers',size: 14,fontWeight: FontWeight.w700,line: 1,),
                          ],
                        ),
                      ),
                      SizedBox(width: 3.w,),
                      GestureDetector(
                        onTap: () async {
                          // showUsers(context, isFollow: false, users: HomeController.i.following);
                          HomeController.i.getFollowing(context: context,id: u.value.id);
                          showUsers2(context,isFollowing: true,users: HomeController.i.following);
                        },
                        child: Column(
                          children: [
                            MyText(title: '${u.value.following}',size: 18,fontWeight: FontWeight.w700,line: 1,),
                            const MyText(title: 'Following',size: 14,fontWeight: FontWeight.w700,line: 1,),
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
                            children: [
                              Expanded(child: MyText(title: '${u.value.firstName} ${u.value.lastName}',size: 14,fontWeight: FontWeight.w600,)),
                              SizedBox(width: 2.w,),
                              GestureDetector(
                                onTap: (){
                                  HomeController.i.endUser.value=u.value;
                                  AppNavigation.navigateTo(context, AppRouteName.ALL_REVIEWS_ROUTE);
                                },
                                child: BorderedContainer(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  Image.asset(ImagePath.star,width: 2.5.w,color: MyColors().purpleColor,),
                                  MyText(title: ' ${u.value.avgRating??0} ',clr: MyColors().purpleColor,size: 10,)
                                ],),),
                              ),
                              SizedBox(width: 2.w,),
                            ],
                          ),
                        ),
                        if(seller)...[
                         Obx(()=> Row(children: [
                           if(Utils().getRequestStatus(v:u.value.requestStatus)==AppStrings.CREATE_CONTRACT)
                             MyButton(title: AppStrings.CREATE_CONTRACT,width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: (){
                               AppNavigation.navigateTo(context, AppRouteName.CREATE_CONTRACT_SCREEN);
                               // status.value=AppStrings.REQUEST_PENDING;
                             }), 
                           if(Utils().getRequestStatus(v:u.value.requestStatus)==AppStrings.REQUEST_PENDING)
                            MyButton(title: AppStrings.REQUEST_PENDING,width: 40.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: (){
                              // status.value=AppStrings.CONTRACT_SIGNED;
                            },bgColor: MyColors().purpleColor,),
                          if(Utils().getRequestStatus(v:u.value.requestStatus)==AppStrings.CONTRACT_SIGNED)
                            MyButton(title: 'Contract Signed',width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,),

                           SizedBox(width: 2.w,),
                           GestureDetector(
                             onTap: (){
                               AppNavigation.navigateTo(context, AppRouteName.CHAT_SCREEN_ROUTE,arguments: ScreenArguments(u:u.value));
                             },
                             child: Container(
                                 padding: EdgeInsets.all(1.h),
                                 decoration: BoxDecoration(
                                   color: MyColors().pinkColor,
                                   borderRadius: BorderRadius.circular(4),
                                 ),
                                 child:Image.asset(ImagePath.chatIcon,color: MyColors().whiteColor,width: 2.5.h,height: 2.5.h)
                             ),
                           )
                         ],
                         ),
                         )
                        ],
                        if(user)...[
                          Obx(()=> Row(children: [
                            // if(followStatus.value==AppStrings.FOLLOW)
                            //   MyButton(title: AppStrings.FOLLOW,width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: (){
                            //     followStatus.value=AppStrings.UN_FOLLOW;
                            //   },),
                            // if(followStatus.value==AppStrings.UN_FOLLOW)
                            //   MyButton(title: AppStrings.UN_FOLLOW,width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: (){
                            //     followStatus.value=AppStrings.FOLLOW;
                            //   }),
                            MyButton(title: followStatus.value,width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: ()
                            {
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

                              // HomeController.i.addFollowUnFollow(context, onSuccess: (){
                              // followStatus.value=followStatus.value==AppStrings.FOLLOW?AppStrings.UN_FOLLOW:AppStrings.FOLLOW;
                              // if(followStatus.value==AppStrings.FOLLOW){
                              //   u.value.followers++;
                              //   HomeController.i.endUser.value.followers++;
                              //   AuthController.i.user.value.following++;
                              //   AuthController.i.user.refresh();
                              // }else{
                              //   u.value.followers--;
                              //   HomeController.i.endUser.value.followers--;
                              //   AuthController.i.user.value.following--;
                              //   AuthController.i.user.refresh();
                              // }
                              //
                              // }, id: u.value.id);
                            }),
                            SizedBox(width: 2.w,),
                            GestureDetector(
                              onTap: (){
                                AppNavigation.navigateTo(context, AppRouteName.CHAT_SCREEN_ROUTE,arguments: ScreenArguments(u:u.value));
                              },
                              child: Container(
                                  padding: EdgeInsets.all(1.h),
                                  decoration: BoxDecoration(
                                    color: MyColors().pinkColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child:Image.asset(ImagePath.chatIcon,color: MyColors().whiteColor,width: 2.5.h,height: 2.5.h)
                              ),
                            )
                          ],),
                          )
                        ]
                      ],
                    ),
                    if(u.value.socialLinks!=null)...[
                      MyText(title: 'Twitter Followers: ${u.value.socialLinks!.twitterFollowers}',size: 12,fontWeight: FontWeight.w500,line: 1,),
                      MyText(title: 'Instagram Followers: ${u.value.socialLinks!.twitterFollowers}',size: 12,fontWeight: FontWeight.w500,line: 1,),
                      SizedBox(height: .4.h,),
                    ],
                    if(u.value.dob!='')...[
                      MyText(title: 'Age : ${Utils().calculateAgeFromDateOfBirth(d: u.value.dob)}',size: 12,fontWeight: FontWeight.w500,line: 1,fontStyle: FontStyle.italic,),
                      SizedBox(height: .4.h,),
                    ],
                    if(u.value.email!='')...[
                      MyText(title: 'Email: ${u.value.email}',size: 12,fontWeight: FontWeight.w500,line: 1,),
                      SizedBox(height: .4.h,),
                    ],
                    if(u.value.phoneNumber!=null)...[
                      MyText(title: 'Phone: ${Utils().addPlusSign(u.value.dialCode)} ${u.value.phoneNumber}',size: 12,fontWeight: FontWeight.w500),
                      // MyText(title: 'Phone: +$phone',size: 12,fontWeight: FontWeight.w500),
                      SizedBox(height: .4.h,),
                    ],
                    if(u.value.location!=null)...[
                      if(u.value.location!.address!=null)...[
                        MyText(title: 'Location: ${u.value.location!.address}',size: 12,fontWeight: FontWeight.w500,),
                        SizedBox(height: .4.h,),
                      ],
                    ],
                    if((u.value.socialLinks?.facebook!=null && u.value.socialLinks?.facebook!='') || (u.value.socialLinks?.twitter!=null && u.value.socialLinks?.twitter!=''))...[
                      const MyText(title: 'Social Links:',size: 12,fontWeight: FontWeight.w700,line: 1,),
                      SizedBox(height: .4.h,),
                    ],
                    Row(
                      children: [
                        if(u.value.socialLinks!=null)...[
                          Expanded(
                            child: Column(
                              children: [
                                if(u.value.socialLinks?.facebook!=null && u.value.socialLinks?.facebook!='')...[
                                  InkWell(
                                    onTap: (){
                                      AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN, arguments: ContentRoutingArgument(title:'Facebook', url:  '${u.value.socialLinks?.facebook}', contentType: ''));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(ImagePath.facebookIcon,width: 5.w,color: MyColors().fbColor,),
                                        SizedBox(width: 1.w,),
                                        Expanded(child: MyText(title: '${u.value.socialLinks?.facebook}',size: 12,fontWeight: FontWeight.w500,under: true,)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: .4.h,),
                                ],
                                if(u.value.socialLinks?.twitter!=null && u.value.socialLinks?.twitter!='')...[
                                  InkWell(
                                    onTap: (){
                                      AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN, arguments: ContentRoutingArgument(title:'Twitter', url: '${u.value.socialLinks?.twitter}', contentType: ''));
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(ImagePath.twitterIcon,width: 5.w,color: MyColors().twitterColor,),
                                        SizedBox(width: 1.w,),
                                        Expanded(child: MyText(title: '${u.value.socialLinks?.twitter}',size: 12,fontWeight: FontWeight.w500,under: true)),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                        if(seller)...[
                          Obx(()=> Row(children: [
                            // if(followStatus.value==AppStrings.FOLLOW)
                            //   MyButton(title: AppStrings.FOLLOW,width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: (){
                            //     followStatus.value=AppStrings.UN_FOLLOW;
                            //   },),
                            // if(followStatus.value==AppStrings.UN_FOLLOW)
                            //   MyButton(title: AppStrings.UN_FOLLOW,width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: (){
                            //     followStatus.value=AppStrings.FOLLOW;
                            //   }),
                            MyButton(title: followStatus.value,width: 30.w,height: 4.5.h,fontSize: 12,radius: 4,onTap: ()
                            {
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

                              //
                            //   HomeController.i.addFollowUnFollow(context, onSuccess: (){
                            //
                            //   followStatus.value=followStatus.value==AppStrings.FOLLOW?AppStrings.UN_FOLLOW:AppStrings.FOLLOW;
                            // if(followStatus.value==AppStrings.UN_FOLLOW){
                            //   // u.value.followers++;
                            //   HomeController.i.endUser.value.followers++;
                            //   AuthController.i.user.value.following++;
                            //   AuthController.i.user.refresh();
                            // }else{
                            //   // u.value.followers--;
                            //   HomeController.i.endUser.value.followers--;
                            //   AuthController.i.user.value.following--;
                            //   AuthController.i.user.refresh();
                            // } }, id: u.value.id);
                            }),
                            if(user)...[
                              SizedBox(width: 2.w,),
                              GestureDetector(
                                onTap: (){
                                  AppNavigation.navigateTo(context, AppRouteName.CHAT_SCREEN_ROUTE,arguments: ScreenArguments(u:u.value));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(1.h),
                                    decoration: BoxDecoration(
                                      color: MyColors().pinkColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child:Image.asset(ImagePath.chatIcon,color: MyColors().whiteColor,width: 2.5.h,height: 2.5.h)
                                ),
                              )
                            ],
                          ],),
                          )
                        ]
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
  streamedVideos({required RxList<StreamModel> s}) {
    return Expanded(
      child: s.isEmpty ? CustomEmptyData(title: 'No Videos',) :
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .71,crossAxisSpacing: 2.w,mainAxisSpacing: 2.w,),
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: s.length,
          itemBuilder: (context, index) {
            return StreamCard(s: s[index],isVideo: true,onTap: (){HomeController.i.getRecordedStream(s: s[index]);},showViewersCount: false,showSellerProfileOnly: true,);
          }),
    );
  }

  void showUsers(context, {isFollow, required RxList<User> users}) {
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
                  Obx(()=> Expanded(
                      child: users.isEmpty?CustomEmptyData(title: 'No ${isFollow?'Followers':'Following'}',): ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return GetBuilder<HomeController>(
                                builder: (d) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if (influencer) {
                                        await d.getUserDetail(loading: true,context: context,id: users[index].id);
                                        AppNavigation.navigatorPop(context);
                                        if(users[index].role==AppStrings.SELLER){
                                          AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE);
                                        } else if(users[index].role==AppStrings.USER){
                                          AppNavigation.navigateTo(context, AppRouteName.USER_PROFILE_ROUTE);
                                        }
                                      }
                                    },
                                    child: Container(
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
                                                url: users[index].userImage,
                                                radius: 100,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 2.w,),
                                          Expanded(child: MyText(
                                            title: '${users[index].firstName} ${users[index].lastName}',
                                            size: 14,
                                            fontWeight: FontWeight.w700,)),
                                          MyButton(
                                            onTap: () {
                                              if (!isFollow) {
                                                AppNavigation.navigatorPop(
                                                    context);
                                              } else {
                                                d.update();
                                              }
                                            },
                                            title: isFollow
                                                ? 'Follow'
                                                : 'Following',
                                            width: 22.w,
                                            fontSize: 11,
                                            height: 4.3.h,)
                                        ],),

                                    ),
                                  );
                                }
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
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

  bool influencer =GlobalController.values.userRole.value == UserRole.influencer;
  bool seller =GlobalController.values.userRole.value == UserRole.seller;
  bool user =GlobalController.values.userRole.value == UserRole.user;
  getData()async{
    if(influencer){
      u=AuthController.i.user;
      await AuthController.i.getDashboard(context: context);
      u=AuthController.i.user;
    }else{
      u=HomeController.i.endUser;
      followStatus.value=Utils().getFollowStatus(v: u.value.isFollowing);
      WidgetsBinding.instance.addPostFrameCallback((_) {fetchData(context);});
      clearFollowFollowers();
    }
    HomeController.i.getUserStreamedVideos(context: context,id: u.value.id,role: u.value.role);
  }
  fetchData(context){
    HomeController.i.getSchedule(context, d: date,id: u.value.id);
  }
  Widget scheduleList({required RxList<ScheduleModel> s}){
    return Expanded(
      child: s.isEmpty?CustomEmptyData(title: 'No Schedule',):
      ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
        shrinkWrap: true,
        itemCount: s.length,
        itemBuilder: (context, index) {
          return ScheduleTile(
            orderStatus: index,
            isEnd: s.length-1 == index ? true : false,
            s: s[index],
            showDelete: false,
          );
        },
      ),
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
                                return FollowFollower(u: users[index],isFollowing: isFollowing,onTap: () async {
                                  if(influencer)
                                  {await HomeController.i.getUserDetail(loading: true, context: context, id: users[index].id);
                                    AppNavigation.navigatorPop(context);
                                    if(users[index].role==AppStrings.SELLER){
                                      AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE);
                                    } else if(users[index].role==AppStrings.USER){
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
  clearFollowFollowers(){
    HomeController.i.followers= List<User>.empty().obs;
    HomeController.i.following= List<User>.empty().obs;
  }
}
