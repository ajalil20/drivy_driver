import 'package:drivy_user/Arguments/product_arguments.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/Widget/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/home_controller.dart';

class ProductTile extends StatelessWidget {
  ProductTile({super.key,this.onPressed,this.showFavorite=true,this.showCheck=false,required this.p,required this.index});
  bool showFavorite;
  bool showCheck;
  int index;
  Function? onPressed;
  ProductsModel p;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (d) {
        return GestureDetector(
          onTap: (){
            if(showCheck){
              if(onPressed!=null){
                onPressed!();
              }
            }else{
              d.getProductDetail(context,p: p);
              // await d.getProductReviews(context: context,p: p);
              AppNavigation.navigateTo(context, AppRouteName.PRODUCT_DETAIL_ROUTE,arguments: ProductArguments(index: index));
            }},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.zero,
            color: MyColors().whiteColor,
            child: Container(
              // height: 22.8.h,
              width: 42.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: Colors.pink
              ),
              padding: EdgeInsets.all(1.w),
              child: Column(children: [
                Stack(
                  children: [
                    CustomImage(height: 15.h,width: 100.w,url: p.image,radius: 8,photoView: false,fit: BoxFit.cover,),
                    Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: showCheck?MainAxisAlignment.end: MainAxisAlignment.spaceBetween,
                        children: [
                          if(!showCheck)...[BorderedContainer(child:MyText(title: ' ${p.category} ',clr: MyColors().purpleColor,size: 10,)),],
                          if(showFavorite)...[GestureDetector(
                              onTap:() async {
                                await d.addRemoveFavorite(context,id:p.id,onSuccess: (){//p.isFavourite==1?p.isFavourite=0:p.isFavourite=1;d.update();
                                });
                                },
                              child: p.isFavourite==1? Image.asset(ImagePath.heart,scale: 4,):Image.asset(ImagePath.heartEmpty,scale: 4,)
                          ),
                          ],
                          if(showCheck)...[p.isChecked? Image.asset(ImagePath.checked,scale: 3,):Image.asset(ImagePath.unChecked,scale: 3,),],
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w)+EdgeInsets.only(top: 1.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: MyText(title: p.title,size: 13,fontWeight: FontWeight.w700,line: 1,toverflow: TextOverflow.ellipsis,)),
                            SizedBox(width: .5.h,),
                            MyText(title: '\$${p.price??'0'}',size: 13,fontWeight: FontWeight.w700,),
                          ],
                        ),
                        MyText(title: p.description,size: 12,line: 1,),
                        SizedBox(height: .5.h,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(ImagePath.star,width: 3.w,),
                            MyText(title: ' ${p.avgRating.toStringAsFixed(1)}',size: 12,clr:  MyColors().rateColor),
                          ],)
                      ],
                    ),
                  ),
                ),
              ],),
            ),
          ),
        );
      }
    );
  }
}
