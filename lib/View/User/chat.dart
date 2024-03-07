import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Model/chat_model.dart';
import 'package:drivy_user/Model/user_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_icon_container.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_refresh.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_card.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Service/navigation_service.dart';
import '../../Utils/app_router_name.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{

  @override
  void initState() {
    // fetchData(fetchAll: true);
    super.initState();
  }
  List<Chat> c =[
    Chat(user: User(firstName: 'Alex',id: 'a',lastName: 'Lee'),message: 'Lorem ipsum dolor sit amet, consectetur.',createdAt: '15:34' ),
    Chat(user: User(firstName: 'Micheal',id: 'a',lastName: 'Ulasi'),message: 'Lorem ipsum dolor sit amet, consectetur.',createdAt: '15:34' ),
    Chat(user: User(firstName: 'Cristofer',id: 'a',lastName: ''),message: 'Lorem ipsum dolor sit amet, consectetur.',createdAt: '15:34' ),
    Chat(user: User(firstName: 'David',id: 'a',lastName: 'Silbia'),message: 'Lorem ipsum dolor sit amet, consectetur.',createdAt: '15:34' ),
    Chat(user: User(firstName: 'Ashfak',id: 'a',lastName: 'Sayem'),message: 'Lorem ipsum dolor sit amet, consectetur.',createdAt: '15:34' ),
    Chat(user: User(firstName: 'Rocks',id: 'a',lastName: 'Velkeinjen'),message: 'Lorem ipsum dolor sit amet, consectetur.',createdAt: '15:34' ),
    Chat(user: User(firstName: 'Roman',id: 'a',lastName: 'Kutepov'),message: 'Lorem ipsum dolor sit amet, consectetur.',createdAt: '15:34' ),
    Chat(user: User(firstName: 'Roman',id: 'a',lastName: 'Kutepov'),message: 'Lorem ipsum dolor sit amet, consectetur.',createdAt: '15:34' ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => true);
        // return Utils().onWillPop(context, currentBackPressTime: currentBackPressTime);
      },
      child: BaseView(
        showAppBar: false,
        leadingAppBar: MenuIcon(),
        showBottomBar: true,
        resizeBottomInset: false,
        showDrawer: true,
        screenTitle: "My Order History",
        trailingAppBar: NotificationIcon(),
        child: GetBuilder<HomeController>(
            builder: (d) {
              return CustomRefresh(
                onRefresh: () async{
                  // await fetchData(fetchAll: false);
                },
                child: CustomPadding(
                  topPadding: 2.h,
                  horizontalPadding: 3.w,
                  child:  Column(
                    children: [
                      CustomAppBar(screenTitle: "Chat",leading: MenuIcon(),trailing: NotificationIcon(),bottom: 2.h,),
                      SizedBox(height: 2.h,),
                      messageList(c:c.obs),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

  Widget messageList({required RxList<Chat> c}){
    return Expanded(
      child: c.isEmpty?CustomEmptyData(title: 'No Chats',):
      ListView.builder(
        itemCount: c.length,
        physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
        itemBuilder: (BuildContext context, int index) {
          return ChatTile(c: c[index],);
        },
      ),
    );
  }

  Future<void> getData({loading}) async{
    await HomeController.i.getChats(loading: loading??true,context: context);
  }
}

class ChatTile extends StatelessWidget {
  ChatTile({super.key,required this.c});
  Chat c;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          dragDismissible:false,
          extentRatio: 0.2,
          // openThreshold: 0.12,
          motion: ScrollMotion(),
          children: [
            Flexible(
              child: GestureDetector(
                onTap:(){
                  // HomeController.i.deleteCard(context,index: index, id:HomeController.i.cards[index].id??"",onSuccess: (){});
                },
                child: Container(
                  height: 10.h,
                    width: 25.w,
                    padding: const EdgeInsets.all(3.0),
                    margin: const EdgeInsets.all(1.0)+EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      color:MyColors().deleteColor,
                      borderRadius: BorderRadius.circular(10)
                      // shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child:Image.asset(ImagePath.delete,width: 5.w,)
                ),
              ),
            )
          ],
        ),
        child: GestureDetector(
            onTap: () {
              AppNavigation.navigateTo(context, AppRouteName.CHAT_SCREEN_ROUTE,arguments: ScreenArguments(u:c.user));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffDAE1F1),
                ),
                borderRadius: BorderRadius.circular(10),
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
              // padding: EdgeInsets.all(12),
              padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
              child:  Row(
                children: [
                  CircleAvatar(
                    radius: 3.h,
                    backgroundColor: MyColors().primaryColor,
                    child: CircleAvatar(
                      radius: 2.8.h,
                      backgroundColor: MyColors().whiteColor,
                      child: CustomImage(
                        height: 6.h,
                        width: 6.h,
                        isProfile: true,
                        photoView: false,
                        url: c.user?.userImage,
                        radius: 100,
                      ),
                    ),
                  ),
                  SizedBox(width : 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: MyText(title: c.user==null?'': '${c.user!.firstName} ${c.user!.lastName}',fontWeight: FontWeight.w700,line: 1,)),
                            SizedBox(width: 6.w),
                            MyText(
                              title: c.createdAt,
                              size: 12,
                              clr: MyColors().greyColor,
                              line: 1,
                              toverflow: TextOverflow.ellipsis,
                            ),
                            // MyText(
                            //   title: Utils.relativeTime(c.createdAt),
                            //   size: 12,
                            //   clr: MyColors().greyColor,
                            //   line: 1,
                            //   toverflow: TextOverflow.ellipsis,
                            // ),
                          ],
                        ),
                        SizedBox(height: .5.h),
                        Row(
                          children: [
                            Expanded(
                              child: MyText(
                                title: c.message,
                                size: 12,
                                clr: MyColors().greyColor,
                                line: 1,
                                toverflow: TextOverflow.ellipsis,
                              ),
                            ),

                            // CircleAvatar(
                            //     backgroundColor: MyColors().pinkColor,
                            //     radius: 9,
                            //     child: MyText(title: "1",clr: MyColors().whiteColor,size: 8,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
