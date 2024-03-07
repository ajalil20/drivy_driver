import 'package:flutter/material.dart';
import '../Component/custom_text.dart';
import '../Utils/my_colors.dart';

class MyButton extends StatelessWidget {
  double? height, width, fontSize, radius, horPadding;
  String? title, weight, prefixImage;
  Color? bgColor, borderColor, textColor;
  Function? onTap;
  bool? gradient, showPrefix;
  IconData? prefixIconData;
  Color? prefixIconColor;
  double? prefixIconSize,prefixScale;
  MainAxisAlignment mainAxisAlignment;

  MyButton(
      {Key? key,
      this.height,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.prefixIconSize,
      this.prefixIconData,
      this.prefixIconColor,
      this.borderColor,
      this.textColor,
      this.radius,
      this.horPadding,
      this.showPrefix = false,
      this.fontSize,
      this.gradient,
      this.weight,
      this.prefixScale,
      this.width,
      this.onTap,
      this.prefixImage,
      this.title,
      this.bgColor})
      : super(key: key);

  MyColors colors = MyColors();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(onTap!=null){
          onTap!();
        }
      },
      child: Container(
        height: height ?? 55,
        width: width ?? double.infinity,
        padding: EdgeInsets.symmetric(horizontal: horPadding ?? 15),
        // margin: EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
            color: bgColor ?? MyColors().primaryColor,
            gradient: gradient == true
                ? LinearGradient(colors: [
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColorDark,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter
            )
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(radius ?? 10),
            border: borderColor != null ? Border.all(color: borderColor!) : null),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            showPrefix == true
                ? prefixIconData != null
                    ? Icon(
                        prefixIconData,
                        size: prefixIconSize,
                        color: prefixIconColor,
                      )
                    : prefixImage!=null? Image.asset(prefixImage ?? '', scale: prefixScale??2, color: prefixIconColor)
                :Container(): Container(),
            SizedBox(
              width: showPrefix == true ? 10 : 0,
            ),
            Flexible(
              child: Padding(
                padding: prefixIconData != null
                    ? const EdgeInsets.only(left: 5.0)
                    : const EdgeInsets.only(left: 0),
                child: MyText(
                  toverflow: TextOverflow.ellipsis,
                  title: title!,
                  clr: textColor ?? Colors.white,
                  weight: weight,
                  fontWeight: FontWeight.w600,
                  size: fontSize ?? 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
