import 'dart:developer';
import 'dart:io';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Component/custom_textfield.dart';
import 'package:drivy_driver/Model/chat_model.dart';
import 'package:drivy_driver/Service/api_endpoints.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Service/socket_service.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/Utils/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/View/base_view.dart';
import 'package:sizer/sizer.dart';
import '../../Component/custom_drawer.dart';
import '../../Component/custom_image.dart';
import '../../Component/custom_toast.dart';
import '../../Controller/auth_controller.dart';
import '../../Controller/home_controller.dart';
import '../../Controller/image_controller.dart';
import '../../Model/user_model.dart';
import '../../Service/base_service.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({required this.u});
  User u;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = ScrollController();
  TextEditingController message = TextEditingController();
  Rx<File> attachment = File("").obs;
  BaseService b = BaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(context);
    });
  }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //  HomeController.i.disposeSocket();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:(){
        return onWillPop(context);
      },
      child: BaseView(
        showAppBar: true,
        // screenTitle: widget.u.firstName,
        leadingWidth: 100.w,
        showBackButton: false,
        leadingAppBar: Row(children: [
          GestureDetector(
            onTap: (){
              AppNavigation.navigatorPop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: .6.h, horizontal: .5.h),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          // SizedBox(width: 2.w,),
          CustomImage(height: 5.h,width: 5.h,isProfile: true,radius: 200,),
          SizedBox(width: 2.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(title: '${widget.u.firstName} ${widget.u.lastName}',size: 15,fontWeight: FontWeight.w600,),
                MyText(title: 'Online',size: 10,clr: MyColors().greyColor,),
              ],),
          ),
          SizedBox(width: 2.w,),
          Image.asset(ImagePath.phoneIcon,scale: 2,),
          SizedBox(width: 5.w,),
        ],),
        backgroundColor: MyColors().whiteColor,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: GetBuilder<HomeController>(
              builder: (d) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        children: [
                          Expanded(
                            child:ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                reverse: true,
                                //shrinkWrap: true,
                                controller: _controller,
                                padding: const EdgeInsets.only(top: 14.0),
                                itemCount: d.chats.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildMessage(c: d.chats[d.chats.length-index-1]);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  _buildMessageComposer(),

                ],
              );
            }
          ),
        ),
      ),
    );
  }
  _buildMessage({required Chat c}) {
    User u = Utils().getUserChat(u1: c.senderId, u2: c.receiverId, currentUser: AuthController.i.user.value);
    bool isMe = c.senderId!.id==AuthController.i.user.value.id;
    return
      // index==9? Padding(
      //   padding: EdgeInsets.symmetric(vertical: 1.h),
      //   child: MyText(title:'Yesterday',fontWeight: FontWeight.w700,center: true),
      // ):
      // index==5? Padding(
      //   padding: EdgeInsets.symmetric(vertical: 1.h),
      //   child: MyText(title:'Today',fontWeight: FontWeight.w700,center: true),
      // ):
    Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      textBaseline: TextBaseline.ideographic,
      mainAxisSize: MainAxisSize.max,
      children: [
        ///Avatar message date
        !isMe ? getImage(isMe: isMe,image:u.userImage) :getDate(isMe: isMe),// Expanded(child: Container(child:  getDate(isMe: isMe),color: Colors.red,)),
        getMessage(isMe: isMe,c:c,u: u),
        isMe ? getImage(isMe: isMe,image:AuthController.i.user.value.userImage) : getDate(isMe: isMe),
      ],
    );
  }
  getImage({required bool isMe,String? image}){
    return  Padding(
      padding: EdgeInsets.only(left:isMe? 2.w:0,right: isMe?0:2.w),
      child: CircleAvatar(
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
            url: image,
            radius: 100,
          ),
        ),
      ),
    );
  }
  getMessage({isMe,required Chat c,required User u}){return Flexible(
    child: Column(
      crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        MyText(title: isMe?'${AuthController.i.user.value.firstName} ${AuthController.i.user.value.lastName}':'${u.firstName} ${u.lastName}',fontWeight: FontWeight.w700,),
        Container(
          // width: MediaQuery.of(context).size.width * 0.5,
          margin: EdgeInsets.symmetric(vertical: 1.h),
          padding: EdgeInsets.all( 3.w),
          decoration: BoxDecoration(color:isMe ?MyColors().purpleColor:MyColors().pinkColor, borderRadius: BorderRadius.circular(10)),
          child:MyText(
            title: c.message,
            clr: MyColors().whiteColor,
          )
        ),
        MyText(title: Utils.relativeTime(c.createdAt),clr: MyColors().greyColor,size: 10,),
      ],
    ),
  );}
  getDate({isMe,d}){
    return Align(
      alignment: isMe? Alignment.centerLeft:Alignment.centerRight,
      child: Padding(
          padding: EdgeInsets.only(right: 2.w,left: 2.w,bottom: 0.h,top: 0.h),
          child: MyText(
            title: d!=null? DateFormat('hh:mm a').format(((DateTime.parse(d.toString())).toUtc().toLocal())):'',
            clr: isMe?Color(0xff282828):Theme.of(context).primaryColorDark,
            size: 8,
          )),
    );
  }

  _buildMessageComposer() {
    return Container(
      margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, -8), // changes position of shadow
          ),
        ],
      ),

      width: 100.w,
      child: Row(
        children: <Widget>[
          Flexible(
            child: MyTextField(
              controller: message,
              hintText: 'Write a message...',
              backgroundColor: Colors.transparent,
              hintTextColor: MyColors().greyColor,
              textColor: Colors.black,
              borderColor:Colors.transparent,
            )
          ),
          GestureDetector(
            onTap: () {
              if(message.text.trim().isNotEmpty){
                HomeController.i.sendMessage(onSuccess: (){}, message: message.text,id: widget.u.id);
                clearMessage();
              }
              // sendMessage();
            },
            child: Image.asset(ImagePath.sendMessage,width: 6.w,)
          ),
        ],
      ),
    );
  }
  clearMessage(){
    HomeController.i.update();
    message.text = "";
  }
  onWillPop(context) async {
    HomeController.i.getChats(context: context,loading: false);
    AppNavigation.navigatorPop(context);
    return false;
  }
  fetchData(context){
    HomeController.i.chats.value= List<Chat>.empty().obs;
    HomeController.i.update();
    HomeController.i.getAllMessages(id: widget.u.id);
    // HomeController.i.connectSocket(onConnect: (){HomeController.i.getAllMessages(id: widget.u.id);});
  }
}
