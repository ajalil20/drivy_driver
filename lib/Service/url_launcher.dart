import 'dart:io';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sizer/sizer.dart';
import '../View/base_view.dart';
import 'api_endpoints.dart';
import 'base_service.dart';
import 'navigation_service.dart';

class ContentScreen extends StatefulWidget {
  String? title, contentType,url;
  Function(bool)? isMerchantSetupDone;

  ContentScreen({this.title, this.contentType, this.isMerchantSetupDone,this.url});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  bool _isLoading = true;
  double? _opacity = 0;
  String url = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(context);
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      body: Stack(
        children: [
          if (!_isLoading)
            Opacity(
              opacity: _opacity ?? 0,
              child: WebView(
                initialUrl: url,
                //AppStrings.WEB_VIEW_URL,
                onPageStarted: (String? url) {},
                onPageFinished: (String? url) {
                  setState(() {
                    _opacity = 1.0;
                    _isLoading = false;
                  });
                  // if(widget.getUrl!=null){
                  //   widget.getUrl!(url??"");
                  // }
                  getUrl(url: url);
                },
                backgroundColor: Colors.white,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          Visibility(
            visible: _isLoading,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }

  void getUrl({String? url}) async {
    try {
      if (widget.contentType == AppStrings.CREATE_MERCHANT){
        if (url?.contains(AppStrings.PRIVACYPOLICY) == true) {
          AppNavigation.navigatorPop(context);
          widget.isMerchantSetupDone != null
              ? widget.isMerchantSetupDone!(true)
              : null;
        }
      }
    } catch (error) {
      Navigator.of(context).pop();
    }
  }
  getData(context) async {
    BaseService baseService = BaseService();
    url = widget.url??'';
    // if (widget.contentType == AppStrings.PRIVACY_POLICY_TYPE) {
    //   var res = await baseService.baseGetAPI(
    //     APIEndpoints.content+AppStrings.PRIVACY_POLICY_TYPE,
    //     loading: false,context: context
    //   );
    //   url = res['data']['url'];
    // }
    // else if (widget.contentType == AppStrings.TERMS_AND_CONDITION_TYPE) {
    //   var res = await baseService.baseGetAPI(
    //     APIEndpoints.content+AppStrings.TERMS_AND_CONDITION_TYPE,
    //     loading: false,context: context
    //   );
    //   url = res['data']['url'];
    // }
    // else if (widget.contentType == AppStrings.CREATE_MERCHANT) {
    //   url=widget.url??'';
    //   // var res = await baseService.baseGetAPI(APIEndpoints.merchantAccount, loading: false,);
    //   // url = res['data'];
    // }
    // else {
    //   var res = await baseService.baseGetAPI(
    //     APIEndpoints.content,
    //     loading: false,context: context
    //   );
    //   url = res['data']['content'];
    // }
    setState(() {
      _opacity = 1.0;
      _isLoading = false;
    });
  }
  customAppBar(){
    return widget.contentType == AppStrings.CREATE_MERCHANT?null:AppBar(
      backgroundColor: MyColors().whiteColor,
      leading:  InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          AppNavigation.navigatorPop(context);
        },
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: .6.h, horizontal: 1.h),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 18.sp,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: MyText(title: widget.contentType == AppStrings.TERMS_AND_CONDITION_TYPE? 'Terms & Conditions':widget.contentType == AppStrings.PRIVACY_POLICY_TYPE?'Privacy Policy':'',
          center: true,
          line: 2,
          size: 18,
          toverflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w700,
          clr: MyColors().titleColor),
      elevation: 0,
    );
  }
}