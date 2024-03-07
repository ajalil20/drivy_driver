import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../Component/custom_text.dart';
import '../../Component/custom_toast.dart';
import '../../Controller/image_controller.dart';
import '../../Utils/my_colors.dart';
import '../../Utils/responsive.dart';

class UploadMedia extends StatelessWidget {
  UploadMedia({Key? key, this.mediaFiles, this.file, this.singlePick = false})
      : super(key: key);
  Responsive responsive = Responsive();
  MyColors colors = MyColors();
  Function(List<File>?)? mediaFiles;
  Function(File?)? file;
  bool? singlePick;
  ImageController controller = Get.put(ImageController());


  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      decoration: const BoxDecoration(
          // color:  Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                color: MyColors().purpleLight,borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
            margin: EdgeInsets.symmetric(vertical: 1.w,horizontal: 1.w),
            alignment: Alignment.center,
            child:MyText(title: 'Upload Media',clr: MyColors().whiteColor,fontWeight: FontWeight.w600,),

          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   decoration: BoxDecoration(
          //     color: MyColors().purpleColor,
          //     borderRadius: const BorderRadius.vertical(
          //       top: Radius.circular(20),
          //
          //     ),
          //
          //   ),
          //   alignment: Alignment.center,
          //   child: const MyText(title: "Upload Media",clr: Colors.white,weight: "Semi Bold",size: 18,),),

          SizedBox(height: 5.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  //Get.back()
                  Get.back();
                  File image = await controller.imgFromCamera();
                  if (image.path == "") {
                    CustomToast()
                        .showToast("Cancel", "No Image Selected", true);
                  } else {
                    // controller.mediaFiles.value.add(image) ;
                    if (singlePick != true) {
                      mediaFiles!(controller.mediaFiles.value);
                    }
                    else
                    {
                      file!(controller.imageProfile.value);
                    }
                    controller.mediaFiles.refresh();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Theme.of(context).cardColor,
                    //     Theme.of(context).cardColor,
                    //   ],
                    // ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).hintColor.withOpacity(0.1)
                    ),
                  ),
                  width: 40.w,
                  // height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.5.h),
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: MyColors().pinkColor,
                                radius: 6.5.w,
                                child: Padding(
                                  padding: EdgeInsets.all(6.sp),
                                  child: (const Icon(Icons.photo_camera,color: Colors.white,)),
                                )),
                            SizedBox(
                              height: 1.h,
                            ),
                            const MyText(
                              title: "Take photo",
                              clr: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.h,),
              GestureDetector(
                onTap: () async {
                  //Get.back()
                  Get.back();
                  // await controller.filesFromGallery();
                  if (singlePick != true) {
                    if (Platform.isIOS) {
                      print("IOS ha");
                      Get.bottomSheet(
                        iOSUploadMedia(
                          mediaFiles: (val) {
                            mediaFiles!(val);
                          },
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
                      // iOS-specific code
                    }
                    else {
                      RxList<File> files = await controller.filesFromGallery();
                      mediaFiles!(files);
                    }
                  }

                  else{
                    File image = await controller.imgFromGallery();
                    if (image.path == "") {
                      CustomToast()
                          .showToast("Cancel", "No Image Selected", true);
                    }
                    else {
                      // controller.mediaFiles.value.add(image) ;
                      file!(controller.imageProfile.value);
                      controller.mediaFiles.refresh();
                    }
                  }
                  // Get.toNamed('/Report');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).hintColor.withOpacity(0.1)
                    ),

                  ),
                  width: 40.w,
                  // height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.5.h),
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: MyColors().pinkColor,
                                radius: 6.5.w,
                                child: Padding(
                                  padding: EdgeInsets.all(6.sp),
                                  child: ( const Icon(Icons.folder,color: Colors.white,)),
                                )),
                            SizedBox(
                              height: 1.h,
                            ),
                            const MyText(
                              title: "From gallery",
                              clr: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h,),
        ],
      ),
    );
  }
}

class iOSUploadMedia extends StatelessWidget {
  iOSUploadMedia({Key? key, this.mediaFiles, this.file, this.singlePick = false})
      : super(key: key);
  Responsive responsive = Responsive();
  MyColors colors = MyColors();
  Function(List<File>?)? mediaFiles;
  Function(File?)? file;
  bool? singlePick;
  ImageController controller = Get.put(ImageController());


  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      decoration: const BoxDecoration(
        // color:  Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                color: MyColors().purpleLight,borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
            margin: EdgeInsets.symmetric(vertical: 1.w,horizontal: 1.w),
            alignment: Alignment.center,
            child:MyText(title: 'Choose Media',clr: MyColors().whiteColor,fontWeight: FontWeight.w600,),

          ),

          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   decoration: BoxDecoration(
          //     color: Theme
          //         .of(context)
          //         .primaryColorDark,
          //     borderRadius: const BorderRadius.vertical(
          //       top: Radius.circular(20),
          //
          //     ),
          //
          //   ),
          //   alignment: Alignment.center,
          //   child: const MyText(title: "Choose Media",clr: Colors.white,weight: "Semi Bold",size: 18,),),

          SizedBox(height: 5.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  Get.back();
                  RxList<File> files = await controller.filesFromGallery(onlyImage:true);
                  mediaFiles!(files);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Theme.of(context).cardColor,
                    //     Theme.of(context).cardColor,
                    //   ],
                    // ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).hintColor.withOpacity(0.1)
                    ),
                  ),
                  width: 40.w,
                  // height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.5.h),
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: MyColors().pinkColor,
                                radius: 6.5.w,
                                child: Padding(
                                  padding: EdgeInsets.all(6.sp),
                                  child: (const Icon(Icons.image,color: Colors.white,)),
                                )),
                            SizedBox(
                              height: 1.h,
                            ),
                            const MyText(
                              title: "Image",
                              clr: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.h,),
              GestureDetector(
                onTap: () async {
                  Get.back();
                  RxList<File> files = await controller.filesFromGallery(onlyVideo: true);
                  mediaFiles!(files);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).hintColor.withOpacity(0.1)
                    ),

                  ),
                  width: 40.w,
                  // height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.5.h),
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: MyColors().pinkColor,
                                radius: 6.5.w,
                                child: Padding(
                                  padding: EdgeInsets.all(6.sp),
                                  child: ( const Icon(Icons.video_collection_rounded,color: Colors.white,)),
                                )),
                            SizedBox(
                              height: 1.h,
                            ),
                            const MyText(
                              title: "Video",
                              clr: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h,),
        ],
      ),
    );
  }
}
