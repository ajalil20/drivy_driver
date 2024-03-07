import 'dart:io';
import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_card.dart';
import 'package:drivy_user/Component/custom_dropdown.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_textfield.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Service/api_endpoints.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/Widget/counter.dart';
import 'package:drivy_user/View/Widget/upload_media.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:collection';

class AddProduct extends StatefulWidget {
  AddProduct({this.fromEdit=false});
  bool fromEdit;
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Category? category;
  String title = 'Add Product';
  String buttonText = 'Create Product';
  RxList<FileNetwork> images = List<FileNetwork>.empty().obs;
  // RxList<File> images = List<File>.empty().obs;
  TextEditingController productTile = TextEditingController(),price = TextEditingController(),description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: title,
        showAppBar: true,
        showBackButton: true,
        resizeBottomInset: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:Obx(()=>Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      if(images.length!=4){
                        Get.bottomSheet(
                          UploadMedia(
                            file: (val) {
                              images.add(FileNetwork(isNetwork: false, path: val!.path));
                            },
                            singlePick: true,
                          ),
                          isScrollControlled: true,
                          backgroundColor: Theme
                              .of(context)
                              .selectedRowColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)
                              )
                          ),
                        );
                      } else{
                        CustomToast().showToast('Error', 'You can add up to 4 images to your product listing', true);
                      }
                    },
                    child: Container(
                        height: 20.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              ImagePath.dottedBorder
                            )
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImagePath.upload,width: 5.w,),
                            SizedBox(height: 1.h,),
                            MyText(title: 'Upload Image',clr: MyColors().purpleLight.withOpacity(.7),fontWeight: FontWeight.w600,)
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  images.isEmpty?SizedBox(): Container(
                      height: 10.h,
                      child: ListView.builder(
                          itemCount: images.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index) {
                        return Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 9.h,
                                width: 10.h,
                                margin: EdgeInsets.only(right: 3.w,top: 1.5.w,),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: images[index].isNetwork? NetworkImage(APIEndpoints.baseImageURL+images[index].path,): FileImage(File(images[index].path)) as ImageProvider,
                                    fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: MyColors().pinkColor
                                    )
                                ),
                              ),
                            ),
                            Positioned(
                              child: GestureDetector(
                                child: Image.asset(ImagePath.crossPurple,width: 5.w,),
                                onTap: (){
                                  images.removeAt(index);
                                },
                              ),
                              top: 0,
                              right:3,
                            ),
                          ],
                        );
                      } ),
                    ),
                  SizedBox(height: 2.h,),
                  MyTitle(title: 'Title',),
                  SizedBox(height: 1.h,),
                  CustomCard(
                    padding: EdgeInsets.zero,
                    // margin: EdgeInsets.zero,
                    child: MyTextField(
                      backgroundColor: Colors.transparent,
                      hintText: 'Title',
                      maxLength: 35,
                      textColor: Colors.black,
                      hintTextColor: MyColors().greyColor,
                      controller: productTile,
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  MyTitle(title: 'Category',),
                  SizedBox(height: 1.h,),
                  CustomCard(
                    padding: EdgeInsets.zero,
                      // margin: EdgeInsets.zero,
                      child:CustomDropDown2(dropDownData: HomeController.i.categories.value,hintText: 'Select Category',dropdownValue:category,validator: (v){print(v);
                  return null;},onChanged: (v){category=v;print(v);print(v.id);print(v.categoryName); },)),
                  SizedBox(height: 2.h,),
                  MyTitle(title: 'Price',),
                  SizedBox(height: 1.h,),
                  CustomCard(
                    padding: EdgeInsets.zero,
                    // margin: EdgeInsets.zero,
                    child: MyTextField(
                      backgroundColor: Colors.transparent,
                      hintText: 'Price',
                      maxLength: 6,
                      prefixWidget: Icon(Icons.attach_money_rounded,color: Colors.grey,size: 20,),
                      textColor: Colors.black,
                      hintTextColor: MyColors().greyColor,
                      inputType:  TextInputType.numberWithOptions(decimal: true),
                      controller: price,
                      numberWithDecimal: true,
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  MyTitle(title: 'Description',),
                  SizedBox(height: 1.h,),
                  CustomCard(
                      // margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,child: MyTextField(height: 13.h,hintText: 'Write a text....', maxLines: 7,minLines: 7,borderColor: Colors.transparent,backgroundColor: Colors.transparent,textColor: Colors.black,
                    hintTextColor: MyColors().greyColor,borderRadius: 10,maxLength: 1000,controller: description,)),
                  SizedBox(height: 2.h,),
                  MyButton(title: buttonText,onTap: (){
                    onSubmit(context);
                  },),
                  SizedBox(height: 2.h,),
                ],
              ),
            ),
          ),
        )
    );
  }

  getData() async{
    if(widget.fromEdit){
      var h=HomeController.i.currentProduct.value;
      title = 'Edit Product Details';
      buttonText = 'Update';
      productTile.text=h.title;
      price.text=h.price.toString();
      category = HomeController.i.categories.firstWhereOrNull((v) => v.id == (h.categoryId?.id??''));
      description.text=h.description;
      if(h.prodImages!.isNotEmpty){
        for(var v in h.prodImages!){
          images.add(FileNetwork(isNetwork: true, path: v));
        }
      }
    }
  }
  onSubmit(context){
    var h=HomeController.i;
    h.name=productTile.text;
    h.category=category?.id??'';
    h.price=price.text;
    h.description=description.text;
    h.temp=images;
    // for(var v in images){
    //   h.temp.add(v.path);
    // }
    h.addProductValidation(context, fromEdit: widget.fromEdit);
  }
}

class MyTitle extends StatelessWidget {
  MyTitle({super.key,required this.title});
  String title='';
  @override
  Widget build(BuildContext context) {
    return  MyText(title:title,fontWeight: FontWeight.w600,size: 15,);
  }
}

class FileNetwork {
  bool isNetwork=false;
  String path='';
  FileNetwork({required this.isNetwork,required this.path});
}