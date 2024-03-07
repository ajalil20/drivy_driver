import 'dart:ui';

import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Model/user_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_size.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Chat/chatting.dart';
import 'package:drivy_user/View/Influencer/influencer_list.dart';
import 'package:drivy_user/View/Widget/message_disclouse.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/View/Widget/search_tile.dart';
import '../../../../Utils/image_path.dart';
import '../../../../Utils/responsive.dart';
import '../../Component/custom_buttom.dart';
import '../../Component/custom_refresh.dart';
import '../../Controller/home_controller.dart';
import '../base_view.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StreamInfluencersList extends StatefulWidget {
  @override
  State<StreamInfluencersList> createState() => _StreamInfluencersListState();
}

class _StreamInfluencersListState extends State<StreamInfluencersList> {
  TextEditingController s = TextEditingController();

  RxBool searchOn = false.obs, load = true.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      HomeController.i.getLocalCart();
      getData(loading: false,context: context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
        ),
        child: GetBuilder<HomeController>(
            builder: (d) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w)+EdgeInsets.only(bottom: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.close_outlined,color: Colors.transparent,
                      ),
                      MyText(title: 'Invite Influencer',fontWeight: FontWeight.w700,size: 18 ,),
                      GestureDetector(
                        onTap: (){AppNavigation.navigatorPop(context);},
                        child: Icon(
                          Icons.close_outlined,color: MyColors().black,size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                SearchTile(
                  onChange: (val) {
                    if (val.isNotEmpty) {
                      searchOn.value = true;
                      d.getSearchInfluencers(s: val);
                    }
                    else {
                      searchOn.value = false;
                      d.update();
                    }
                  },
                  search:s,
                  showFilter: false,
                ),
                SizedBox(height: 2.h,),
                Expanded(child: CustomRefresh(
                  onRefresh: () async{
                    await getData(loading: false,context: context);
                  }, child:influencersList(u: searchOn.isTrue?d.searchInfluencers:d.influencers)
                ))
              ],
            );
          }
        ),
      ),
    );
  }

  Widget influencersList({required RxList<User> u}){
    return u.isEmpty?CustomEmptyData(title: 'No Users',):
    ListView.builder(
      itemCount: u.length,
      physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
      // shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return StreamInfluencerTiles(u: u[index]);
      },
    );
  }

  Future<void> getData({loading,context}) async{
    await HomeController.i.getStreamInfluencers(loading: loading??true,context: context);
  }
}


class StreamInfluencerTiles extends StatelessWidget {
  StreamInfluencerTiles({super.key,required this.u});
  User u;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: GestureDetector(
          onTap: () async{
            // HomeController.i.endUser.value=u;
            await HomeController.i.getUserDetail(context: context,id: u.id);
            AppNavigation.navigateTo(context, AppRouteName.INFLUENCER_PROFILE_ROUTE);
          },
          child:Row(
            children: [
              CircleAvatar(
                radius: 2.5.h,
                backgroundColor: MyColors().pinkColor,
                child: CircleAvatar(
                  radius: 2.3.h,
                  backgroundColor: MyColors().whiteColor,
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
              SizedBox(width: 2.w),
              Expanded(child: MyText(title: '${u.firstName} ${u.lastName}',fontWeight: FontWeight.w700,)),
              SizedBox(width: 2.w),
              if(u.isInvited==0)...[
                MyButton(title: 'Add',width: 22.w,height: 4.h,fontSize: 12,onTap: (){
                  HomeController.i.checkAlreadySendInvite(context, onSuccess: (){onAdd(id: u.id);}, id: u.id);
                },),
              ],
              if(u.isInvited==1 && u.isJoined==0)...[
                MyButton(title: 'Cancel Request',width: 32.w,bgColor: MyColors().whiteColor,borderColor: MyColors().pinkColor,textColor:  MyColors().pinkColor,height: 4.h,fontSize: 12,onTap: (){
                  HomeController.i.rejectInvite(context: context, id: u.requestId);
                },),
              ],
              if(u.isInvited==1 && u.isJoined==1)...[
                MyButton(title: 'Remove',width: 32.w,bgColor: MyColors().purpleColor,height: 4.h,fontSize: 12,onTap: (){
                  AppNavigation.navigatorPop(context);
                  onRemoveInfluencer(context,id: HomeController.i.influencerUser.value.id);
                },),
              ],
            ],
          ),
      ),
    );
  }
  onAdd({required String id}){
    var h = HomeController.i;
    int index = h.influencers.indexWhere((i) => i.id == id);
    h.influencers[index].isInvited=1;
    h.update();
  }
  // void removeInfluencer(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       // backgroundColor: MyColors().whiteColor,
  //       builder: (BuildContext bc) {
  //         return  BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //           child: Container(
  //             padding: EdgeInsets.all(4.w),
  //             decoration: BoxDecoration(
  //                 color: Color(0xffF5F5F5),
  //                 borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 2.w)+EdgeInsets.only(bottom: 2.h),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Icon(
  //                         Icons.close_outlined,color: Colors.transparent,
  //                       ),
  //                       MyText(title: '${AuthController.i.user.value.firstName} ${AuthController.i.user.value.lastName} live video',fontWeight: FontWeight.w700,size: 16  ,),
  //                       GestureDetector(
  //                         onTap: (){AppNavigation.navigatorPop(context);},
  //                         child: Icon(
  //                           Icons.close_outlined,color: MyColors().black,size: 25,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           CircleAvatar(
  //                             radius:2.2.h,
  //                             backgroundColor: MyColors().pinkColor,
  //                             child: CircleAvatar(
  //                               radius:2.h,
  //                               backgroundColor: MyColors().whiteColor,
  //                               child: CustomImage(
  //                                 height: 5.2.h,
  //                                 width: 5.2.h,
  //                                 isProfile: true,
  //                                 photoView: false,
  //                                 radius: 100,
  //                                 url: HomeController.i.endUser.value.userImage,
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(width: 2.w,),
  //                           Expanded(child: MyText(title: '${HomeController.i.endUser.value.firstName} ${HomeController.i.endUser.value.lastName}',size: 16,fontWeight: FontWeight.w600,)),
  //                         ],
  //                       ),
  //                     ),
  //                     MyButton(title: 'Remove',width: 22.w,height: 4.h,fontSize: 12,onTap: (){
  //                       AppNavigation.navigatorPop(context);
  //                       onRemoveInfluencer(context,id: HomeController.i.endUser.value.id);
  //                     },),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }
  //   );
  // }
  onRemoveInfluencer(context,{required String id}){
    HomeController.i.removeUserSocket(context, id: id);
  }
}
