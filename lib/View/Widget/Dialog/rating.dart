import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_card.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Component/custom_textfield.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingAlert extends StatefulWidget {
  RatingAlert({required this.id,required this.index,required this.productId,required this.refreshData,this.edit,this.orderId,this.r,required this.isProduct});
  String id,productId;
  String? orderId;
  int index;
  bool? edit;
  Function refreshData;
  Reviews? r;
  bool isProduct;

  @override
  State<RatingAlert> createState() => _RatingAlertState();
}

class _RatingAlertState extends State<RatingAlert> {
  double rate = 0;
  String title='Rating & Review';
  TextEditingController feedback = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      // height: responsive.setHeight(75),
      width: 100.w,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: MyColors().purpleLight,borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              ),
              padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
              margin: EdgeInsets.symmetric(vertical: 1.w,horizontal: 1.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.close_outlined,color: Colors.transparent,
                  ),
                  MyText(title: title,clr: MyColors().whiteColor,fontWeight: FontWeight.w600,),
                  GestureDetector(
                    onTap: (){AppNavigation.navigatorPop(context);},
                    child: Icon(
                      Icons.close_outlined,color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 2.h,),
                  Center(
                    child: RatingBar(
                      initialRating: rate,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      glowColor: Colors.yellow,
                      updateOnDrag:true,
                      ratingWidget: RatingWidget(
                        full: Image.asset(ImagePath.star,width: 3.w,),
                        half: Image.asset(ImagePath.star,width: 3.w,),
                        empty:Image.asset(ImagePath.starOutlined,width: 3.w,),
                      ),
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      onRatingUpdate: (rating) {
                        rate=rating;
                      },
                      itemSize:7.w,
                    ),
                  ),
                  SizedBox(height: 2.h,),

                  CustomCard(
                    padding: EdgeInsets.zero,
                    child: MyTextField(
                      backgroundColor: Colors.transparent,
                      textColor: Colors.black,
                      hintTextColor: MyColors().greyColor,
                      height: 15.h,
                      // backgroundColor:Colors.redAccent,
                      minLines: 5,
                      maxLines: 5,
                      showLabel: false,
                      hintText: "Share your own experience",
                      controller: feedback,
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  MyButton(
                    onTap: (){onSubmit(context);},
                    title: "Submit",
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  onSubmit(context){
    HomeController.i.rating=rate.toString();
    HomeController.i.review=feedback.text.toString();
    HomeController.i.giveReviewValidation(context,edit: widget.edit??false,r: widget.r,isProduct: widget.isProduct);
  }
  setField(){
    if(widget.edit==true){
      rate = widget.r?.rating.toDouble();
      title='Edit Your Review';
      feedback.text=widget.r?.review??'';
    }
  }
}
