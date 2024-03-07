import 'dart:developer';
import 'package:get/get.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/utils.dart';

class SocketNavigationClass {
  static SocketNavigationClass? _instance;

  SocketNavigationClass._();

  static SocketNavigationClass? get instance {
    _instance ??= SocketNavigationClass._();
    return _instance;
  }

  void socketResponseMethod({dynamic r}) {
    log("Data:$r");
    if (r != null) {
      if (r['object_type']==AppStrings.GET_ALL_MESSAGES || r["object_type"] == AppStrings.GET_SINGLE_MESSAGES) {
        HomeController.i.setChatMessages(r: r);
      }
     /// STREAM_JOINED,STREAM_LEAVED,STREAM_COMMENTED,STREAM_COMMENT_DELETED 3no pa same response return ho rha ha
      else if (r['object_type']==AppStrings.STREAM_JOINED ||
          r['object_type']==AppStrings.STREAM_LEAVED ||
          r['object_type']==AppStrings.STREAM_COMMENTED ||
          r['object_type']==AppStrings.STREAM_COMMENT_DELETED ||
          r['object_type']==AppStrings.PRODUCT_ADDED
      ) {
        HomeController.i.onStreamJoined(r: r['data']);
      }else if (r['object_type']==AppStrings.GET_COMMENT_LIST) {
        HomeController.i.onStreamJoined(r: r['data']);
        HomeController.i.getRecordedStreamComments(r: r['data']);
      }
      Utils().loadingOff();
    }
  }

  void socketErrorMethod({dynamic errorResponseData}) {
    if (errorResponseData != null) {
      if (errorResponseData["object_type"] == AppStrings.ERROR) {
        Utils().loadingOff();
      }
    }
  }
}
