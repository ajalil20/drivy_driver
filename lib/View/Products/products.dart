import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_empty_data.dart';
import 'package:drivy_user/Component/custom_icon_container.dart';
import 'package:drivy_user/Component/custom_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_refresh.dart';
import 'package:drivy_user/Component/custom_shimmer.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/View/Products/product_tile.dart';
import 'package:drivy_user/View/Widget/bordered_container.dart';
import 'package:drivy_user/View/Widget/search_tile.dart';

import 'package:drivy_user/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_user/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Products extends StatefulWidget {
  const Products({super.key});
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  TextEditingController s = TextEditingController();
  RxBool searchOn = false.obs, load = true.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      showAppBar: false,
      showBottomBar: true,
      resizeBottomInset: false,
      showDrawer: true,
      screenTitle: "Products",
      child: CustomRefresh(
        onRefresh: () async{
          await getData(loading: false);
        },
        child: CustomPadding(
          topPadding: 2.h,
          horizontalPadding: 3.w,
          child: GetBuilder<HomeController>(
              builder: (d) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(screenTitle: "Products",leading: MenuIcon(),trailing: Row(
                      children: [
                        CartIcon(),
                        SizedBox(width: 2.w,),
                        NotificationIcon(),
                      ],
                    ),bottom: 2.h,),
                    SearchTile(
                        onChange: (val) {
                          if (val.isNotEmpty) {
                            searchOn.value = true;
                            d.getSearchProducts(s: val);
                          }
                          else {
                            searchOn.value = false;
                            d.update();
                          }
                        },
                        search:s,
                        showFilter: false,
                    ),
                    SizedBox(height: 2.h),
                    // load.isTrue?
                    // productsListShimmer():
                    productsList(p: searchOn.isTrue?d.searchProducts:d.products),
                    SizedBox(height: 2.h),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
  Widget productsList({required RxList<ProductsModel> p}){
    return Expanded(
      child: p.isEmpty?CustomEmptyData(title: 'No Products',):
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .91,crossAxisSpacing: 3.w,mainAxisSpacing: 3.w,),
          physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
          shrinkWrap: true,
          itemCount: p.length,
          itemBuilder: (context,index){
            return ProductTile(p:p[index],index: index);
          }),
    );
  }
  // Widget productsListShimmer() {
  //   return Expanded(
  //     child: CustomShimmer(
  //       child: GridView.builder(
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .91,crossAxisSpacing: 3.w,mainAxisSpacing: 3.w,),
  //             physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
  //             shrinkWrap: true,
  //             itemCount: 10,
  //             itemBuilder: (BuildContext ctx, index) {
  //               return ProductTile(p: ProductsModel(),index: index,onFavoriteSuccess:(){});
  //             }),
  //     ),
  //   );
  // }
  Future<void> getData({loading}) async{
   await HomeController.i.getAllProducts(loading:loading??true,context: context,myProducts: false);
    load.value=false;
  }
}
