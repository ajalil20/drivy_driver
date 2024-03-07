import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_card.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Model/chat_model.dart';
import 'package:drivy_driver/Model/user_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/Utils/utils.dart';
import 'package:drivy_driver/View/Chat/chatting.dart';
import 'package:drivy_driver/View/Widget/message_disclouse.dart';
import 'package:flutter/material.dart';
import '../../../../Utils/image_path.dart';
import '../../../../Utils/responsive.dart';
import '../../Controller/home_controller.dart';
import '../base_view.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Messages extends StatefulWidget {
  @override
  State<Messages> createState() => _MessagesState();
}


class _MessagesState extends State<Messages> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      screenTitle: 'Messages',
      showAppBar: true,
      showBackButton: true,
      resizeBottomInset: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: GetBuilder<HomeController>(
            builder: (d) {
            return CustomRefresh(
              onRefresh: () async{
                await getData(loading: false);
              },
              child:messageList(c:d.inboxChats),
            );
          }
        ),

      ),
    );
  }
  Widget messageList({required RxList<Chat> c}){
    return c.isEmpty?CustomEmptyData(title: 'No Chats',):
    ListView.builder(
      itemCount: c.length,
      physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
      itemBuilder: (BuildContext context, int index) {
        return ChatTile(c: c[index],);
      },
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
      child: GestureDetector(
          onTap: () {
            AppNavigation.navigateTo(context, AppRouteName.CHAT_SCREEN_ROUTE,arguments: ScreenArguments(u:c.user));
          },
          child: CustomCard(
            elevation: 2,
            padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
            child:  Row(
              children: [
                CircleAvatar(
                  radius: 3.h,
                  backgroundColor: MyColors().pinkColor,
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
                            title: Utils.relativeTime(c.createdAt),
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            toverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      MyText(
                        title: c.user?.role??'',
                        size: 9,
                        clr: MyColors().greyColor,
                        line: 1,
                        toverflow: TextOverflow.ellipsis,
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
                          SizedBox(width: 6.w),
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
    );
  }
}
