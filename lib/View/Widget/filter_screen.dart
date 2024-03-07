import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_checkbox.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Component/custom_textfield.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/search_tile.dart';
import 'package:sizer/sizer.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key,this.onChange, this.search}) : super(key: key);
  TextEditingController? search;
  final Function(String)? onChange;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<OptionModel> fOptions=[
    OptionModel(text: 'All',value: false),
    OptionModel(text: 'Search by Products',value: false),
    OptionModel(text: 'Search by Product Categories',value: false),
    OptionModel(text: 'Search by Seller',value: false),
    OptionModel(text: 'Search by Influencer',value: false),
    OptionModel(text: 'Search by Price',value: false),
    OptionModel(text: 'Search by Category',value: false),
    OptionModel(text: 'Search by Location',value: false),
    OptionModel(text: 'Search by Seller Category',value: false),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPadding(
      topPadding: 3.h,
      child: Column(
        children: [
          GestureDetector(onTap:(){AppNavigation.navigatorPop(context);}, child: Align(alignment: Alignment.centerRight, child: Icon(Icons.close,color: MyColors().whiteColor,))),
          SizedBox(height: 1.5.h,),
          InkWell(onTap:(){
            AppNavigation.navigatorPop(context);},
            child: SizedBox(
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: MyTextField(
                        hintText: "Search",
                        controller: widget.search,
                        onChanged: widget.onChange,
                        backgroundColor: MyColors().lightGreyColor,
                        borderColor: MyColors().lightGreyColor,
                        textColor:MyColors().black,
                        hintTextColor:MyColors().greyColor,
                        suffixIconData: Icon(Icons.search,color: MyColors().greyColor,),
                        onTapSuffixIcon: () {},
                        readOnly: true,
                      onTap: (){
                          AppNavigation.navigatorPop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 2.w,),
                  FilterIcon(),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.5.h,),
          Container(
            height: 40.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(title: 'Select Option:',clr: MyColors().pinkColor,size: 18,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.5.h,),
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: fOptions.length,
                      shrinkWrap: true,
                      itemBuilder: (buildContext, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 1.h),//+EdgeInsets.only(left: selectedIndex.value==0?1.w:0, right:selectedIndex.value==buttons!.length?1.w:0 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(title: fOptions[index].text,clr: MyColors().black,size: 11,),
                              CheckBoxWidget(
                                defaultVal: fOptions[index].value,
                                onChange: (newValue) {
                                  fOptions[index].value=newValue;
                                if(fOptions[0].value==true){
                                  for(int i=0;i<fOptions.length;i++){
                                    fOptions[i].value=true;
                                    print(fOptions[i].value);
                                  }
                                }
                                setState(() {});
                                  // s(() {});
                                },),
                              // SizedBox(
                              //   height: 15,
                              //   child: Checkbox(
                              //     value: options[index].value,
                              //     onChanged: (newValue) {options[index].value=newValue!;setState(() {});},
                              //     activeColor: MyColors().purpleColor,
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],),
    );

  }
}
