import 'package:flutter/material.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/schedule_model.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:sizer/sizer.dart';

class ScheduleTile extends StatefulWidget {
  ScheduleTile({
    super.key,
    required this.orderStatus,
    required this.isEnd,
    this.showDelete=true,
    required this.s
  });

  final int orderStatus;
  final bool isEnd;
  bool showDelete;
  ScheduleModel s;

  @override
  State<ScheduleTile> createState() =>
      _ScheduleTileState();
}

class _ScheduleTileState extends State<ScheduleTile> {
  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0)),
        height: 100,
        child: Column(
          children: [
            //!--------
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.red,
                  // height: 100,
                  width: 40,
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   selectedIndex = widget.orderStatus;
                      // });
                    },
                    child: TimelineTile(
                      axis: TimelineAxis.vertical,
                      alignment: TimelineAlign.start,
                      hasIndicator: true,
                      isFirst: widget.orderStatus == 0 ? true : false,
                      isLast: widget.isEnd,
                      afterLineStyle:
                          const LineStyle(thickness: 2.5, color: Colors.grey),
                      beforeLineStyle:
                          const LineStyle(thickness: 2.5, color: Colors.grey),
                      indicatorStyle: indicatorStyleWidget()
                    ),
                  ),
                ),
                //!----Right Cards Widget
                Expanded(
                  child: CustomCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(title: widget.s.title,fontWeight: FontWeight.w600,size: 16,),
                              SizedBox(height: 1.h,),
                              MyText(title: 'Start Time ${widget.s.startTime==''?'':Utils.convertToLocalTime(time:widget.s.startTime)}',size: 11,fontWeight: FontWeight.w600),
                              SizedBox(height: .5.h,),
                              MyText(title: 'End Time ${widget.s.endTime==''?'':Utils.convertToLocalTime(time:widget.s.endTime)}',size: 11,fontWeight: FontWeight.w600),
                            ],
                          ),
                        ),
                        if(widget.showDelete)
                        IconButton(onPressed: (){
                           HomeController.i.deleteSchedule(context,s: widget.s,onSuccess: (){});
                        }, icon: Image.asset(ImagePath.delete,width: 4.w,color: MyColors().purpleColor,))
                      ],
                    ),
                  )
                ),
              ],
            ),
          ],
        ));
  }
//!-----Indicator Style
  IndicatorStyle indicatorStyleWidget() {
    return IndicatorStyle(
        indicatorXY: 0.2,
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        indicator: Container(
          padding: const EdgeInsets.all(4.0),
          margin: selectedIndex! == widget.orderStatus
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: Colors.pink),
          ),
          child: selectedIndex! == widget.orderStatus
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.pink,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
        ),
        color: widget.orderStatus > 0 ? Colors.orange : Colors.grey);
  }
}
