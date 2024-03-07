import 'package:flutter/material.dart';
import 'package:drivy_user/Utils/responsive.dart';

import '../../Component/custom_text.dart';
import '../../Utils/image_path.dart';

class AttendanceCard extends StatelessWidget {
  AttendanceCard({Key? key}) : super(key: key);
  Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return GestureDetector(
      onTap: (){
        // Navigator.of(context).push(CustomPageRoute(child: ChatScreen("a1","s")));
      },
      child: Container(
          width: responsive.setWidth(100),
          padding: EdgeInsets.symmetric(
              horizontal: responsive.setHeight(1),
              vertical: responsive.setHeight(1.25)),
          margin: EdgeInsets.only(
              bottom: responsive.setHeight(2))+EdgeInsets.symmetric(
            horizontal: responsive.setWidth(5),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  color: Theme
                      .of(context)
                      .hintColor
                      .withOpacity(.1)
              )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment
                .center,
            children: [
              const CircleAvatar(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MyText(title: "John Smith",
                        clr: Colors.black,),
                      MyText(
                        title: "Yesterday",
                        weight: "Bold",
                        clr: Theme
                            .of(context)
                            .primaryColorLight,
                        line: 1,),
                    ],
                  ),
                ),
              ),
            ],)
      ),
    );
  }
}
