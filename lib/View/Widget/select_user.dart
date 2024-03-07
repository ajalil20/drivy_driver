import 'package:flutter/material.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import '../../Component/custom_buttom.dart';
import 'package:get/get.dart';

class  SelectUser extends StatefulWidget {
  SelectUser({super.key, this.selectedUser,this.currentUser});
  Function(String)? selectedUser;
  RxInt? currentUser;

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  // RxInt selectedIndex = 100.obs;
  RxList users = ["Employee","Driver","Supervisor"].obs;
  RxString user="".obs;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.vertical(
            top: Radius.circular(20),
            bottom: Radius.circular(20),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColorDark,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),

              ),

            ),
            alignment: Alignment.center,
            child: const MyText(title: "Select user",clr: Colors.white,weight: "Semi Bold",size: 18,),),
          SizedBox(
            height: 1.5.h,
          ),
          SizedBox(
            height: 25.h,
            width: 50.w,
            child: Center(
              child: ListView.builder(
                itemCount: users.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuileContext, int index) {
                  return Obx(() =>
                      GestureDetector(
                        onTap: () {
                          widget.currentUser!.value = index;
                          user.value=users[index];
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.w),
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: ListTile(
                              leading:Icon(
                                widget.currentUser!.value ==
                                    index
                                    ? Icons.check_box_rounded:
                                 Icons.check_box_outline_blank,
                                color:   widget.currentUser!.value ==
                                    index
                                    ? Theme.of(context).primaryColorLight
                                    : Colors.black,),

                              title: MyText(
                                title:
                                users[index],
                                size: 15,
                                clr:  Colors.black,
                                weight: "Semi Bold",
                              ),
                            )
                        ),
                      ));
                },
              ),
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          MyButton(
              onTap: (){
                Get.back();
                if( widget.selectedUser!=null)
                {
                  // widget.selectedUser!(user.value);
                  widget.currentUser!.value== 0?
                  widget.selectedUser!("Employee"):
                  widget.currentUser!.value== 1?
                  widget.selectedUser!("Driver"):
                  widget.currentUser!.value== 2?
                  widget.selectedUser!("Supervisor"):
                  widget.selectedUser!("");
                }
              },
              title: "SAVE",radius: 25,fontSize: 15,textColor: Colors.white,gradient: true,width: 85.w),
          SizedBox(
            height: 1.5.h,
          ),        ],
      ),
    );
  }
}