import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Component/custom_textfield.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/Widget/filter_screen.dart';
import 'package:sizer/sizer.dart';

class SearchTile extends StatelessWidget {
  SearchTile({Key? key,this.onChange, this.search,this.showFilter=true}) : super(key: key);
  TextEditingController? search;
  final Function(String)? onChange;
  bool showFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 5.5.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: MyTextField(
              hintText: "Search...",
              controller: search,
              onChanged: onChange,
              backgroundColor: MyColors().whiteColor,
              borderColor: MyColors().lightGreyColor,
              textColor:MyColors().black,
              hintTextColor:MyColors().greyColor,
              suffixIconData: Icon(Icons.search,color: MyColors().greyColor,),
              onTapSuffixIcon: () {}
            ),
          ),
          if(showFilter)...[
            SizedBox(width: 2.w,),
            FilterIcon(onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: AlertDialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                          content: FilterScreen()
                      ),
                    );
                  }
              );
            },),
          ],
        ],
      ),
    );
  }
}

class OptionModel{
  bool value;
  String text;
  OptionModel({required this.text,required this.value});
}