import 'package:flutter/material.dart';
import 'package:drivy_driver/Utils/responsive.dart';
import '../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';

class JobCard extends StatelessWidget {
   JobCard({Key? key,required this.userType,this.titleName,this.showTitle,this.showAddButton}) : super(key: key);
   String? userType, titleName;
   bool? showTitle, showAddButton =false;
  Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
        width: responsive.setWidth(100),
        padding: EdgeInsets.symmetric(
            horizontal: responsive.setHeight(1),
            vertical: responsive.setHeight(1)),
        margin: EdgeInsets.only(
            bottom: responsive.setHeight(2)),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Theme
                    .of(context)
                    .hintColor
                    .withOpacity(.1)
            )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: EdgeInsets.symmetric(horizontal: responsive.setWidth(3),vertical: responsive.setHeight(0)),
                padding: EdgeInsets.symmetric(
                    horizontal: responsive.setWidth(
                        3.8),
                    vertical: responsive.setHeight(
                        2)),
                decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .hintColor
                        .withOpacity(0.1),
                    borderRadius: BorderRadius
                        .circular(10)
                ),
               ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: responsive.setWidth(
                        3),
                    vertical: responsive.setHeight(
                        0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: [
                    Row(
                      children: [
                        showTitle==false? const SizedBox():
                          const MyText(title: "Job Name",
                          clr: Colors.black,
                          weight: "Semi Bold",
                          size: 13,
                        ),
                        showTitle==false? const SizedBox():
                         SizedBox(width: 3.w,),
                         Expanded(
                          child: MyText(
                            title: titleName??"132-123-134",
                            clr: Theme
                                .of(context)
                                .primaryColorDark,
                            under: true,
                            size: 13,
                            line: 1,),
                        ),
                      ],
                    ),
                     SizedBox(height: 1.h,),
                    MyText(
                      title: "Lorem ipsum dolor sit amet, reque molestiae vis cu. Vix iusto dolores referrentur ut. Nullam efficiantur eu vis, mea te dicta audiam. Ius ea dolore appetere disputationi, corrumpit concludaturque usu ei, postea corrumpit eos ea. Graece aeterno nostrum vim eu, semper detraxit probatus eam ei. Ignota praesent consequat mei eu, dico quando ignota te est, dicat nostrum ad qui.",
                      clr: Theme
                          .of(context)
                          .hintColor,
                      line: 4,),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Theme
                          .of(context)
                          .primaryColorLight,
                      child: const Icon(
                        Icons.east,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 25,),
                  // if(userType =="Supervisor@gmail.com" || userType =="supervisor@gmail.com" ||userType =="SUPERVISOR@gmail.com")
                  //   showAddButton == false?SizedBox():
                  //   GestureDetector(
                  //     onTap: (){
                  //         Get.to(CreateJob());
                  //     },
                  //     child: CircleAvatar(
                  //       radius: 15,
                  //       backgroundColor:Colors.green,
                  //       child: Icon(
                  //         Icons.add,
                  //         color: Colors.white,
                  //         size: 18,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],)
    );
  }
}
