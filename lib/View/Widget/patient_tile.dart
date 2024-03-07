import 'package:drivy_driver/Component/custom_image.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

import '../../Component/custom_text.dart';
import '../../Utils/image_path.dart';

class PatientTile extends StatelessWidget {
  String? image;
  Widget? child;
  BoxFit? fit;
  double? width, imageHeight, paddingRight,paddingBottom;
  PatientTile({Key? key,this.image,this.child,this.fit,this.width,this.paddingRight,this.imageHeight,this.paddingBottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight??5.w,bottom: paddingBottom??0),
      child: Container(
        width: width?? 42.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              url: image,height: 35.w,
              fit: BoxFit.cover,
              width: 100.w,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              photoView: false,
            ),
            // Container(
            //   height: imageHeight?? 35.w,
            //   decoration: BoxDecoration(
            //       borderRadius: const BorderRadius.vertical(
            //           top: Radius.circular(10)
            //       ),
            //     image: DecorationImage(
            //       image: AssetImage(image??ImagePath.randomImage,),
            //       fit: fit??BoxFit.cover
            //     )
            //   ),
            // ),
            child?? Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.w,horizontal: 3.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const MyText(title: "Patient ID: ",size: 14,weight: "Semi Bold",clr:  Color(0xff282828)),
                        MyText(title: "4429",size: 14,weight: "Semi Bold",clr: Theme.of(context).primaryColor ),
                      ],
                    ),
                    const Expanded(child: MyText(title: "Dental Implant",size: 12,weight: "Semi Bold",line: 1,toverflow: TextOverflow.ellipsis,clr:  Color(0xff858585))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
