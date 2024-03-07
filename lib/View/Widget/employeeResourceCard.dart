import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_user/Utils/responsive.dart';

import '../../Component/custom_text.dart';
import '../../Model/imageText_model.dart';

class EmployeeResourceCard extends StatelessWidget {
   EmployeeResourceCard({Key? key,this.card}) : super(key: key);
   Responsive responsive = Responsive();
   ImageTextModel? card =ImageTextModel();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return  Padding(
      padding: EdgeInsets.only(right: responsive.setWidth(2),top: responsive.setHeight(0)),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
        elevation: 2,
        child: Container(
          // width: responsive.setWidth(30),
          // height: responsive.setHeight(15),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: responsive.setWidth(2),
              vertical: responsive.setHeight(0)),
          // margin: EdgeInsets.only(right:responsive.setWidth(5),top: responsive.setHeight(2)),

          decoration: const BoxDecoration(
            // color: Colors.white,
              // borderRadius: BorderRadius.circular(10),
              // border: Border.all(
              //     color: Theme
              //         .of(context)
              //         .hintColor
              //         .withOpacity(.1)
              // )
          ),

          child:  Column(
            crossAxisAlignment: CrossAxisAlignment
                .center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(card!.image!,height: responsive.setHeight(4),width: responsive.setHeight(4),),
              SizedBox(height: responsive.setHeight(1),),
              MyText(
                title:card!.text!,
                center: true,
                clr: Theme
                    .of(context)
                    .hintColor,
                line: 3,),
            ],
          ),
        ),
      ),
    );
  }
}
