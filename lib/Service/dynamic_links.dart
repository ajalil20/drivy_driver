import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Controller/home_controller.dart';
import 'package:drivy_user/Model/category_product_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/local_shared_preferences.dart';
import 'package:drivy_user/main.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

class DynamicLinkProvider {
  ///Create Link
  Future<List<String>> createLink({String? postId, postIndex,required Uint8List capturedImage}) async {
    final String url =
        "${AppStrings.DYNAMIC_URL}?${AppStrings.POST_ID}=$postId&${AppStrings.POST_INDEX}=$postIndex";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        androidParameters: const AndroidParameters(
            packageName: AppStrings.APP_PACKAGE_NAME,
            minimumVersion: AppStrings.ANDROID_MINIMUM_VERSION),
        iosParameters: const IOSParameters(
            bundleId: AppStrings.APP_BUNDLE_ID,
            minimumVersion: AppStrings.IOS_MINIMUM_VERSION,
            appStoreId: AppStrings.APP_STORE_ID),
        link: Uri.parse(url),
        uriPrefix: AppStrings.DYNAMIC_URL);
    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/temp_image.jpg');
    await file.writeAsBytes(capturedImage);


    // return file.path;//refLink.shortUrl.toString();
    return [file.path,refLink.shortUrl.toString()];
  }

  /// Initialize dynamic link
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks() async {
    ///this will call when app is in foreground
    dynamicLinks.onLink.listen((dynamicLinkData) {
     // AppDialogs.showToast(message: "from forgound state");
      // Listen and retrieve dynamic links here
      final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK

      // Ex: product/013232
      if (deepLink.isEmpty) return;
      handleDeepLink(queryParam: dynamicLinkData.link.queryParameters);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });

    ///this will call when app is in killed state
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await dynamicLinks.getInitialLink();
      if (initialLink == null) return;
      handleDeepLink(queryParam: initialLink.link.queryParameters);
    } catch (e) {
      print("error is " + e.toString());
    }
  }

  void handleDeepLink({Map<String, dynamic>? queryParam}) {
     print('queryParam');
     print(queryParam);
    if (queryParam != null) {
      if (SharedPreference().getUser() != null) {
        AppNavigation.navigateToRemovingAll(globalkey.currentContext, AppRouteName.HOME_SCREEN_ROUTE,arguments: ScreenArguments(index: 1));
        bool t = HomeController.i.checkProduct(id: queryParam[AppStrings.POST_ID]);
        if(t==true){
          HomeController.i.getProductDetail(globalkey.currentContext,p: HomeController.i.currentProduct.value);
          AppNavigation.navigateTo(globalkey.currentContext!, AppRouteName.PRODUCT_DETAIL_ROUTE);
        } else{
          CustomToast().showToast('Error', 'No product found', true);
        }

        // AppNavigation.navigateToRemovingAll(
        //     StaticData.navigatorKey.currentContext!,
        //     AppRouteName.FISH_TALK_POST_DETAILS_NEW_SCREEN_ROUTE,
        //     arguments: FishTalkPostDetailsNewRoutingArguments(
        //         fromDynamicLink: true,
        //         postId: queryParam[AppStrings.POST_ID],
        //         postIndex: int.parse(queryParam[AppStrings.POST_INDEX])));
      }
    }
  }
}
