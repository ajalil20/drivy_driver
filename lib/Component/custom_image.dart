import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/loader.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/Utils/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../Service/api_endpoints.dart';

class CustomImage extends StatelessWidget {
  CustomImage({this.url,this.shape,this.fit,this.height,this.borderRadius,this.isProfile,this.width,this.radius,this.photoView=true});
  String? url;
  BoxFit? fit;
  BoxShape? shape;
  bool? isProfile;
  double? width, height, radius;
  BorderRadius? borderRadius;
  bool photoView = true;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? assetImage()
        : url == ""
            ? assetImage()
            : photoView==true? GestureDetector(
              onTap: (){
                Get.to(PhotoViewScreen(path:APIEndpoints.baseImageURL+url!,));
              },
              child: networkImage()
            ):networkImage();
  }

  assetImage() {
    return ClipRRect(
      borderRadius: //BorderRadius.circular(200),
      BorderRadius.only(topLeft: Radius.circular(10),topRight:  Radius.circular(10)),
      child: Image.asset(isProfile==true? ImagePath.noUserImage:ImagePath.noImage,
      // child: Image.asset(isProfile==true? ImagePath.random4:ImagePath.noImage,
        fit: fit ?? BoxFit.cover,
        width: width??30.w,
        height: height?? 30.w,),
    );
  }
  errorImage() {
    return Image.asset(
      ImagePath.error,
      scale: 3,
    );
  }
  networkImage(){
    return ExtendedImage.network(APIEndpoints.baseImageURL+url!,
      width: width??30.w,
      height: height?? 30.w,
      fit:fit ?? BoxFit.fill,
      cache: true,
      // border: Border.all(color: Colors.red, width: 1.0),
      shape: shape?? BoxShape.rectangle,
      borderRadius: borderRadius??BorderRadius.all(Radius.circular(radius??0)),
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Loader();
          case LoadState.failed:
            return errorImage();
          case LoadState.completed:
          // TODO: Handle this case.
            break;
        }
        return null;
      },
      //cancelToken: cancellationToken,
    );
  }
}
