// import 'package:drivy_user/Model/category_product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:drivy_user/Controller/home_controller.dart';
// import 'package:drivy_user/View/Products/product_detail.dart';
// import 'package:drivy_user/View/Widget/patient_tile.dart';
// import 'package:flutter/services.dart';
// import '../../Component/custom_text.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// class ProductTile extends StatelessWidget {
//   ProductTile({Key? key,required this.p,this.width,this.paddingRight}) : super(key: key);
//   Product p; double?width,paddingRight;
//   @override
//   Widget build(BuildContext context) {
//     var h =HomeController.i;
//     return GestureDetector(
//       onTap: () async {
//         await h.getProductDetail(id:p.id);
//         Get.to(ProductDetail());
//       },
//       child: PatientTile(
//         image: p.imageName==null?null: p.imageName!.isEmpty?null :p.imageName!.first,
//         width: width,
//         paddingRight: paddingRight,
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 3.w,horizontal: 3.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MyText(title: p.title,size: 14,weight: "Semi Bold",clr:  Color(0xff282828),line: 1,toverflow: TextOverflow.ellipsis,),
//               MyText(title: "\$${p.price.toStringAsFixed(2)}",size: 12,weight: "Semi Bold",line: 1,toverflow: TextOverflow.ellipsis,clr:  Color(0xff858585)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
