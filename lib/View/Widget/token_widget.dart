// import 'package:drivy_driver/Component/custom_text.dart';
// import 'package:drivy_driver/Utils/image_path.dart';
// import 'package:drivy_driver/View/Token/tokens.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';
//
// import '../../Controller/auth_controller.dart';
//
// class TokenWidget extends StatelessWidget {
//   TokenWidget({Key? key,this.onTap,this.color,this.textColor}) : super(key: key);
//   Function? onTap;
//   Color? color, textColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         if(onTap!=null){onTap!();}
//         Get.to(Tokens());
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             color: color??Theme.of(context).primaryColor,
//             borderRadius: BorderRadius.circular(100)
//         ),
//         padding: EdgeInsets.all(.5.w),
//         child: Row(
//           children: [
//             Image.asset(ImagePath.token,width: 7.w,),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 1.5.w),
//               child: Obx(()=> MyText(title: "${AuthController.i.user.value.subscriptionToken??0}",clr: textColor,)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
