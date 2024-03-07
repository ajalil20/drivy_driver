import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_bottomsheet_indicator.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_quantity.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/stream_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_size.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:drivy_user/View/Widget/Dialog/cart_seller.dart';
import 'package:drivy_user/View/Widget/Dialog/delete_account.dart';
import 'package:drivy_user/View/Widget/counter.dart';
import 'package:drivy_user/View/base_view.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../main.dart';

class ProductDetail extends StatefulWidget {
  int index;
  bool fromLiveStream;
  ProductDetail({required this.index,required this.fromLiveStream});
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  RxInt current = 0.obs;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeController.i.getCartDelte();
      HomeController.i.getProductQuantity();});
    super.initState();
  }
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (d) {
        return Screenshot(
          controller: screenshotController,
          child: BaseView(
              screenTitle: 'Product Detail',
              showAppBar: true,
              showBackButton: true,
              resizeBottomInset: false,
              trailingAppBar: user?Obx(() {
                return Row(children: [
                  IconButton(
                      onPressed: () async {
                        await d.addRemoveFavorite(context,id:d.currentProduct.value.id,onSuccess: (){
                          // d.currentProduct.value.isFavourite==1?d.currentProduct.value.isFavourite=0:d.currentProduct.value.isFavourite=1;d.update();
                        });
                      },
                      icon: d.currentProduct.value.isFavourite==1? Image.asset(
                        ImagePath.heart, width: 7.w,) : Image.asset(
                        ImagePath.heartEmpty, width: 6.w,)),
                  IconButton(
                      onPressed: () async {
                        screenshotController
                            .capture(delay: Duration(milliseconds: 10))
                            .then((capturedImage) async {
                          d.shareProduct(postId: d.currentProduct.value.id,postIndex: 0,capturedImage:capturedImage!);
                          // ShowCapturedWidget(context, capturedImage!);
                        }).catchError((onError) {
                          print(onError);
                        });
                        // await Share.shareXFiles([XFile(ImagePath.random)], text: 'Check out my this product');
                        // await Share.share("Check out my this product");
                      },
                      icon: Image.asset(
                        ImagePath.share, width: 5.5.w,)),
                  SizedBox(width: 3.w,)
                ],);
              }):seller? IconButton(icon: Icon(Icons.more_vert_rounded,color: MyColors().black,),onPressed: (){
                editDialog(context);
                },):null,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getImage(context),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: MyText(title: d.currentProduct.value.title, size: 18,fontWeight: FontWeight.w600,)),
                                SizedBox(width: 1.w,),
                                MyText(title: "\$${d.currentProduct.value.price}",
                                  size: 18,
                                  fontWeight: FontWeight.w700,)
                              ],
                            ),
                            SizedBox(height: 1.h,),
                            MyText(title: "Category: ${d.currentProduct.value.category}", size: 14,fontWeight: FontWeight.w500,),
                            SizedBox(height: 1.h,),
                            MyText(title: "Description", size: 14,fontWeight: FontWeight.w500,),
                            SizedBox(height: .5.h,),
                            MyText(
                                title: d.currentProduct.value.description,
                                size: 12,fontWeight: FontWeight.w400),
                            SizedBox(height: 2.h),
                            if(user)...[
                              MyText(title: "Quantity", size: 14,fontWeight: FontWeight.w500,),
                              SizedBox(height: .5.h,),
                              Counter(addToCart: false,onTapRemove: (v){d.currentProduct.value.quantity=v;},onTapAdd: (v){d.currentProduct.value.quantity=v;},q: d.currentProduct.value.quantity,),
                              SizedBox(height: 2.h),
                            ],
                            GestureDetector(
                              onTap: () async {
                                if(user){
                                  await HomeController.i.getUserDetail(context: context,id: d.currentProduct.value.sellerId?.id??'');
                                  AppNavigation.navigateTo(context, AppRouteName.SELLER_PROFILE_ROUTE,);
                                }
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 3.h,
                                    backgroundColor: MyColors().pinkColor,
                                    child: CircleAvatar(
                                      radius: 2.8.h,
                                      backgroundColor: MyColors().whiteColor,
                                      child: CustomImage(
                                        height: 6.h,
                                        width: 6.h,
                                        isProfile: true,
                                        photoView: false,
                                        radius: 100,
                                        url:d.currentProduct.value.sellerId?.userImage,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  MyText(title: d.currentProduct.value.sellerId==null?'': "${d.currentProduct.value.sellerId?.firstName} ${d.currentProduct.value.sellerId?.lastName}",fontWeight: FontWeight.w500,),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            if(d.currentProduct.value.streaming!=null)...[
                              Container(
                                width: 100.w,
                                height: 10.h,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: d.currentProduct.value.streaming!.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context,index){
                                      return getVideos(l: d.currentProduct.value.streaming![index]);
                                    }),
                              ),
                              SizedBox(height: 2.h),
                            ],
                            Row(children: [
                              MyText(title: "Reviews & Ratings",fontWeight: FontWeight.w500,),
                              SizedBox(width: 1.2.w),
                              Icon(Icons.star_rounded, color: MyColors().rateColor,
                                size: 15,),
                              SizedBox(width: .5.w),
                              MyText(title: '${d.currentProduct.value.avgRating.toStringAsFixed(1)}', clr: MyColors().rateColor),
                            ],),
                            d.productReviews.isEmpty?CustomEmptyData(title: 'No Reviews',hasLoader: false,):
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: d.productReviews.length,
                                itemBuilder: (context, index) {
                                  var u =d.productReviews[index].userId;
                                  return Column(
                                    children: [
                                      SizedBox(height: 2.h),
                                      GestureDetector(
                                        onTap: () async {
                                          if(u!.id!=AuthController.i.user.value.id){
                                            await HomeController.i.getUserDetail(context: context,id: u!.id);
                                            AppNavigation.navigateTo(context, AppRouteName.USER_PROFILE_ROUTE);

                                          }
                                         },
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 2.h,
                                              backgroundColor: MyColors().pinkColor,
                                              child: CircleAvatar(
                                                radius: 1.8.h,
                                                backgroundColor: MyColors().whiteColor,
                                                child: CustomImage(
                                                  height: 5.h,
                                                  width: 5.h,
                                                  isProfile: true,
                                                  photoView: false,
                                                  url: u?.userImage,
                                                  radius: 100,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                MyText(title: "${u?.firstName} ${u?.lastName}",fontWeight: FontWeight.w500,),
                                                Row(children: [
                                                  Icon(Icons.star_rounded,
                                                    color: MyColors().rateColor,
                                                    size: 15,),
                                                  SizedBox(width: .5.w),
                                                  MyText(title: '${d.productReviews[index].rating.toStringAsFixed(1)}',
                                                    clr: MyColors().rateColor,
                                                    size: 12,),
                                                ],),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: MyText(title: Utils.relativeTime(d.productReviews[index].createdAt),
                                            clr: MyColors().greyColor,
                                            size: 12,)),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            color: MyColors().whiteColor,
                                            child: Container(
                                              // width: 80.w,
                                              padding: EdgeInsets.all(2.5.w),
                                              child: MyText(
                                                  title:d.productReviews[index].review,),
                                            )),
                                      ),
                                    ],
                                  );
                                }),
                            SizedBox(height: 2.h),
                            if(user)
                              MyButton(
                                  width: 90.w,
                                  title: 'Add to Cart',
                                  onTap: () {
                                    onSubmit();
                                  }),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              )
          ),
        );
      }
    );
  }
  onSubmit(){
    var h = HomeController.i;
   if(h.sellerID=='' || h.cart.isEmpty){
      h.sellerID=h.currentProduct.value.sellerId?.id??'';
      addToCart();
      log("if");
    }
    else if(h.checkSellerInCart(p: h.currentProduct.value)){
      addToCart();
      log("else if");
    }
    else{
      log(h.checkSellerInCart(p: h.currentProduct.value).toString());
      log("else");
      differentSellerCartAlert(context,onYes: (){
        h.emptyCart();
        addToCart();
        h.sellerID=h.currentProduct.value.sellerId?.id??'';
      });
    }
  }
  addToCart(){
    var h = HomeController.i;
    if(widget.fromLiveStream){AppNavigation.navigatorPop(context);}
    AppNavigation.navigateTo(context, AppRouteName.CART_ROUTE,arguments: ScreenArguments(fromLiveStream: widget.fromLiveStream));
    h.addToCart(p:h.currentProduct.value);
  }
  getImage(context) {
    return Column(children: [
      CarouselSlider(
        items: HomeController.i.currentProduct.value.prodImages?.map((item) =>
            // Container(
            //   height: 28.h, width: 100.w,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       image: DecorationImage(
            //           image: AssetImage(item),
            //           fit: BoxFit.cover
            //       )
            //   ),
            //   margin: EdgeInsets.symmetric(horizontal: 2.w),
            // )
          ///
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10.0),
                bottom: Radius.circular(10.0),),
              child:  CustomImage(
              url: item,
              height: 28.h,
              fit: BoxFit.cover,
              width: 100.w,
            ),),
          ),
        )
            .toList(),
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: false,
            viewportFraction: .8,
            // viewportFraction: 1,
            enableInfiniteScroll: false,
            // aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              current.value = index;
            }),
      ),
      SizedBox(height: 2.h),
      Obx(() =>
    HomeController.i.currentProduct.value.prodImages==null?SizedBox():
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: HomeController.i.currentProduct.value.prodImages!
                .asMap()
                .entries
                .map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(vertical: 8.0,
                      horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: current.value == entry.key
                          ?MyColors().purpleColor
                          : Colors.transparent,
                      // .withOpacity(_current == entry.key ? 0.9 : 0.4)
                      border: Border.all(
                        color: current.value ==
                            entry.key ? MyColors().purpleColor :Colors.black,
                      )
                  ),
                ),
              );
            }).toList(),
          ),),
    ],);
  }
  getVideos({required StreamModel l}){
    return GestureDetector(
      onTap: (){
        HomeController.i.roomID=l.roomId;
        HomeController.i.liveStreaming.value.roomId=l.roomId;
        AppNavigation.navigateTo(context, AppRouteName.VIDEO_PLAYER_ROUTE,arguments: ScreenArguments(url:l.recordingUrl??''));
      },
      child: Padding(
        padding: EdgeInsets.only(right: 3.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10), child: Container(
          height: 10.h,
          width:  10.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomImage(
                // height: 6.h,
                // width: 6.h,

                photoView: false,
                url:l.thumbnailImage,
              ),
              // Image.asset(ImagePath.random, fit: BoxFit.cover),
              ClipRRect( // Clip it cleanly.
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(ImagePath.play,scale: 7,)
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
  void editDialog(context) {
    showModalBottomSheet(
        context: context,
        // backgroundColor: MyColors().whiteColor,
        builder: (BuildContext bc) {
          return  BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                  color:  MyColors().whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.BOTTOMSHEETRADIUS))
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomSheetIndicator(),
                  SizedBox(height: 1.5.h,),
                  GestureDetector(
                    onTap: (){
                      AppNavigation.navigatorPop(context);
                      AppNavigation.navigateTo(context, AppRouteName.ADD_PRODUCT_ROUTE,arguments: ScreenArguments(fromEdit: true));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(ImagePath.editReview,scale: 4,color: MyColors().pinkColor,),
                        SizedBox(width: 3.w,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(title: 'Edit Product Details',size: 14,fontWeight: FontWeight.w600,),
                            MyText(title: 'Want to edit your product details...!',clr: MyColors().greyColor,size: 11,),
                          ],)
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h,),
                  GestureDetector(
                    onTap: () {
                      AppNavigation.navigatorPop(context);
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: AlertDialog(
                                backgroundColor: Colors.transparent,
                                contentPadding: const EdgeInsets.fromLTRB(
                                    0, 0, 0, 0),
                                content: DeleteDialog(title: 'Delete Product',subTitle: 'Do you want to delete this product?',onYes: ()  {
                                  HomeController.i.deleteProduct(context, onSuccess:(){
                                    AppNavigation.navigatorPop(globalkey.currentState!.context);
                                  }, id: 'id', index: widget.index);
                                  },),
                              ),
                            );
                          }
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(ImagePath.delete,scale: 4,color: MyColors().pinkColor),
                        SizedBox(width: 3.w,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(title: 'Delete Product',size: 14,fontWeight: FontWeight.w600),
                            MyText(title: 'Want to delete your product...!',clr: MyColors().greyColor,size: 11,),
                          ],)
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                ],
              ),
            ),
          );
        }
    );
  }
  differentSellerCartAlert(context,{required Function onYes}){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.fromLTRB(
                  0, 0, 0, 0),
              content: CartSeller(onYes: onYes,),
            ),
          );
        }
    );
  }


  bool user =GlobalController.values.userRole.value == UserRole.user;
  bool seller =GlobalController.values.userRole.value == UserRole.seller;
  bool influencer =GlobalController.values.userRole.value == UserRole.influencer;

}