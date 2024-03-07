import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_bottomsheet_indicator.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/chat_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_size.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/Dialog/delete_account.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/image_path.dart';

class LiveCommentTile extends StatelessWidget {
  LiveCommentTile({super.key,required this.c});
  Chat c;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
            height: 4.5.h,
            width: 4.5.h,
            isProfile: true,
            photoView: false,
            url: c.commentUser?.userImage,
            radius: 100,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(title:
                c.commentUser==null?'':
                '${c.commentUser!.firstName} ${c.commentUser!.lastName}',clr: MyColors().whiteColor,fontWeight: FontWeight.w600,),
                MyText(title: c.message??'',clr:  MyColors().whiteColor,size: 12,fontWeight: FontWeight.w300),
              ],
            ),
          ),
          if(c.commentUser?.id==AuthController.i.user.value.id)
            IconButton(
                onPressed: () {deleteComment(context,id:c.id??'');},
                icon: Icon(Icons.more_vert_rounded,color: MyColors().whiteColor,))
          else
            SizedBox(width: 2.w),

        ],
      ),
    );
  }
  void deleteComment(context,{required String id}) {
    showModalBottomSheet(
        context: context,
        // backgroundColor: MyColors().whiteColor,
        builder: (BuildContext bc) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                  color:  MyColors().whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomSheetIndicator(),
                  SizedBox(height: 1.5.h,),
                  InkWell(
                    onTap: (){
                      AppNavigation.navigatorPop(context);
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: AlertDialog(
                                backgroundColor: Colors.transparent,
                                contentPadding: const EdgeInsets.fromLTRB(
                                    0, 0, 0, 0),
                                content: DeleteDialog(title: 'Delete Comment',subTitle: 'Do you want to this comment?',onYes: (){
                                  onDeleteComment(context, id: id);
                                },),
                              ),
                            );
                          }
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(ImagePath.delete,scale: 4,),
                        SizedBox(width: 3.w,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(title: 'Delete Comment',size: 13,fontWeight: FontWeight.w600,),
                            MyText(title: 'Want to delete your comment...!',clr: MyColors().greyColor,size: 11,),
                          ],)
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                ],
              ),
            ),
          );
        }
    );
  }

  onDeleteComment(context,{required String id}){
    var h = HomeController.i;
    h.deleteCommentStreamingSocket(context,commentID: id);
  }
}
