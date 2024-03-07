import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/Utils/responsive.dart';


class CustomSwitch extends StatelessWidget {
  String? switchName,toggleValue1,toggleValue2;
  RxBool? switchValue=true.obs;
  double? toggleWidth;
  Color? toggleColor;
  final Function(bool) onChange;
  CustomSwitch({Key? key,this.switchName,this.switchValue,this.toggleValue1,this.toggleValue2,this.toggleWidth,this.toggleColor,required this.onChange}) : super(key: key);
  Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Obx(()=>  FlutterSwitch(
      inactiveColor :MyColors().lightGreyColor,
      width: responsive.setWidth(12),
      height: responsive.setHeight(3),
      valueFontSize: responsive.setTextScale(13),
      toggleSize:responsive.setTextScale(20),
      value:  switchValue!.value,
      borderRadius: 30.0,
      toggleColor:  toggleColor??Theme.of(context).primaryColorDark,
      padding: 3.0,
      activeColor: toggleColor??MyColors().pinkColor,
      showOnOff: true,
      onToggle: (val) {
        switchValue!.value= !switchValue!.value;
        // HomeController.i.onOffNotifications(context, onSuccess: (){
        // },on: !switchValue!.value);
        onChange(val);
        // controller.updateSettings();
      },
      activeText: toggleValue1??'',
      inactiveText: toggleValue2??'',
      activeTextColor: Theme.of(context).primaryColorDark,
      inactiveTextColor: Theme.of(context).hintColor,
      inactiveToggleColor:Colors.white,
      activeToggleColor: Colors.white,
      inactiveTextFontWeight: FontWeight.w400,
      activeTextFontWeight: FontWeight.w400,
    ),
    );
  }
}
