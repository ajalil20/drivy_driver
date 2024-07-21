import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:drivy_driver/Utils/local_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Component/custom_toast.dart';
import '../Utils/utils.dart';
import 'api_endpoints.dart';

class BaseService {
  late String baseURL = APIEndpoints.baseURL;
  // late String baseURL = "https://22f5-2400-adc1-125-f500-9407-8bcc-4c70-2154.ngrok.io/api";
  String? token;
  int requestTimeout = 20;

  Future baseGetAPI(url,
      {successMsg,
      loading,
      status,
      utfDecoded,
      bool return404 = false,
      bool errorToast = true,
      bool direct = false,
      hasToken = true,
      required BuildContext context}) async {
    if (loading == true && loading != null) {
      EasyLoading.show(status: 'Please wait...');
    }
    token = SharedPreference().getBearerToken();
    print("url");
    print(baseURL + url);
    print(token.toString());
    String bearerAuth = 'Bearer ' + "$token";
    http.Response response;
    try {
      response = await http
          .get(
            Uri.parse(baseURL + url),
            headers: hasToken == true
                ? <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization': bearerAuth,
                    'Accept': 'application/json'
                  }
                : null,
          )
          .timeout(Duration(seconds: requestTimeout));
      log(response.body);
      log("Status code");
      log(response.statusCode.toString());
      EasyLoading.dismiss();
      if (direct == true) {
        return response.body;
      }

      if (status != null) {
        return response.statusCode;
      }

      var jsonData;
      if (response.statusCode == 200) {
        if (utfDecoded == true) {
          jsonData = json.decode(utf8.decode(response.bodyBytes));

          return jsonData;
        }
        jsonData = json.decode(response.body);
        if (successMsg != null) {
          CustomToast().showToast("", successMsg, false);
        }
        return jsonData;
      } else if (response.statusCode == 401) {
        if (context.mounted) Utils.logout(c: context);
        jsonData = json.decode(response.body);
        return jsonData;
      } else {
        jsonData = json.decode(response.body);
        return jsonData;
      }
    } on TimeoutException catch (e) {
      onTimeout();
    } catch (SocketException) {
      EasyLoading.dismiss();
      AlertDialog(
        content: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 20,
                ),
                SizedBox(height: 10),
                Text(
                  "There seems to be your network problem or a server side issue. Please try again or report the bug to the manager.",
                ),
                SizedBox(height: 20),
              ],
            )),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                // color: terColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: new Text(
                    "Okay",
                  ),
                ),
                // color: secondaryColor,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ],
      );
      return null;
    }
  }

  Future basePostAPI(url, body,
      {successMsg, loading, loadingOff, required BuildContext context}) async {
    EasyLoading.instance.userInteractions = false;
    if (loading == true && loading != null) {
      EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
    }
    token = SharedPreference().getBearerToken();
    print("url here ");
    print(baseURL + url);
    print(body);
    print(token.toString());
    String bearerAuth = 'Bearer ' + "$token";

    http.Response response;

    try {
      response = await http
          .post(Uri.parse(baseURL + url),
              headers: <String, String>{
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': bearerAuth
              },
              body: jsonEncode(body))
          .timeout(Duration(seconds: requestTimeout));
      print("Response here");
      print(baseURL + url);
      log(response.body);
      if (loadingOff == null) EasyLoading.dismiss();

      var jsonData;
      if (response.statusCode == 401) {
        if (context.mounted) Utils.logout(c: context);
      } else {
        jsonData = json.decode(response.body);
        return jsonData;
      }

      // if (response.statusCode == 200) {
      //   jsonData = json.decode(response.body);
      //   if (successMsg != null) {
      //     CustomToast().showToast("Message",successMsg, false);
      //   }
      //   return jsonData;
      // } else if (response.statusCode == 400) {
      //   jsonData = json.decode(response.body);
      //   // CustomToast().showToast("Error",jsonData["message"], true);
      //   // return {};
      //   return jsonData;
      // } else if (response.statusCode == 401) {
      //   jsonData = json.decode(response.body);
      //
      //   return {};
      // } else {
      //   jsonData = json.decode(response.body);
      //   throw Exception('Failed');
      // }
    } on TimeoutException catch (e) {
      onTimeout();
    } catch (SocketException) {
      print("Catch ma");
      // print(SocketException);
      EasyLoading.dismiss();
      return null;
    }
  }

  Future basePutApi(url, body,
      {successMsg, loading, loadingOff, required BuildContext context}) async {
    EasyLoading.instance.userInteractions = false;
    if (loading == true && loading != null) {
      EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
    }
    token = SharedPreference().getBearerToken();
    print("url here ");
    print(baseURL + url);
    print(body);
    print(token.toString());
    String bearerAuth = 'Bearer ' + "$token";

    http.Response response;

    try {
      response = await http
          .put(Uri.parse(baseURL + url),
              headers: <String, String>{
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': bearerAuth
              },
              body: jsonEncode(body))
          .timeout(Duration(seconds: requestTimeout));
      print("Response here");
      print(baseURL + url);
      log(response.body);
      if (loadingOff == null) EasyLoading.dismiss();

      var jsonData;
      if (response.statusCode == 401) {
        if (context.mounted) Utils.logout(c: context);
      } else {
        jsonData = json.decode(response.body);
        return jsonData;
      }

      // if (response.statusCode == 200) {
      //   jsonData = json.decode(response.body);
      //   if (successMsg != null) {
      //     CustomToast().showToast("Message",successMsg, false);
      //   }
      //   return jsonData;
      // } else if (response.statusCode == 400) {
      //   jsonData = json.decode(response.body);
      //   // CustomToast().showToast("Error",jsonData["message"], true);
      //   // return {};
      //   return jsonData;
      // } else if (response.statusCode == 401) {
      //   jsonData = json.decode(response.body);
      //
      //   return {};
      // } else {
      //   jsonData = json.decode(response.body);
      //   throw Exception('Failed');
      // }
    } on TimeoutException catch (e) {
      onTimeout();
    } catch (SocketException) {
      print("Catch ma");
      // print(SocketException);
      EasyLoading.dismiss();
      return null;
    }
  }

  Future baseFormPostAPI(url, Map<String, String> body, files, keys,
      {successMsg, loading, pop = true, required BuildContext context}) async {
    EasyLoading.instance.userInteractions = false;
    if (loading == true && loading != null) {
      EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
    }
    token = SharedPreference().getBearerToken();
    log(baseURL + url);
    log(token.toString());
    String bearerAuth = 'Bearer ' + "$token";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseURL + url));

      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "${bearerAuth}"
      });
      // headers: <String, String>{
      //   'Accept': 'application/json',
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Authorization': bearerAuth
      // },
      print("File yk bahar ${files.length}");

      for (int i = 0; i < files.length && files != null; i++) {
        print("File yaha hain ${keys[i]} ${files[i].path}");
        request.files
            .add(await http.MultipartFile.fromPath(keys[i], files[i].path));
      }
      request.fields.addAll(body);

      var response = await request.send();
      if (loading == true) {
        EasyLoading.dismiss();
      }

      print(response.statusCode.toString() + "check status");

      if (response.statusCode == 200) {
        if (successMsg != null) {
          CustomToast().showToast("Message", successMsg, false);
        }
        if (pop == true) {
          // Modular.to.pop();
        }

        var temp = await response.stream.bytesToString();
        log(temp);

        return json.decode((temp));
      } else if (response.statusCode == 400) {
        var temp = await response.stream.bytesToString();
        log(temp);
        return json.decode(temp);
      } else if (response.statusCode == 401) {
        if (context.mounted) Utils.logout(c: context);
      } else if (response.statusCode == 500) {
        var temp = await response.stream.bytesToString();
        log(temp);
        CustomToast().showToast('Error', 'Something went wrong.', true);
        return json.decode(temp);
      } else {
        throw Exception('Failed');
      }
    } on TimeoutException catch (e) {
      onTimeout();
    } catch (SocketException) {
      log(SocketException.toString());
      CustomToast().showToast('Error', 'Something went wrong.', true);
      EasyLoading.dismiss();
      return null;
    }
  }

  Future baseDeleteAPI(url,
      {successMsg,
      loading,
      status,
      utfDecoded,
      bool return404 = false,
      bool errorToast = true,
      bool direct = false,
      required BuildContext context,
      back = false}) async {
    EasyLoading.instance.userInteractions = false;
    if (loading == true && loading != null) {
      EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
    }

    token = SharedPreference().getBearerToken();
    log(baseURL + url);
    log(token.toString());
    String bearerAuth = 'Bearer ' + "$token";
    log(baseURL + url);

    http.Response response;
    try {
      response = await http.delete(
        Uri.parse(baseURL + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerAuth
        },
      ).timeout(Duration(seconds: requestTimeout));
      log(response.body);
      if (loading == true && loading != null) {
        EasyLoading.dismiss();
      }
      if (direct == true) {
        return response.body;
      }

      if (status != null) {
        return response.statusCode;
      }

      var jsonData;
      if (response.statusCode == 200 || response.statusCode == 400) {
        if (utfDecoded == true) {
          jsonData = json.decode(utf8.decode(response.bodyBytes));
          return jsonData;
        }
        jsonData = json.decode(response.body);
        if (back == true) {
          Get.back();
        }
        if (successMsg != null) {
          CustomToast().showToast("", successMsg, false);
        }
        return jsonData;
      } else if (response.statusCode == 401) {
        if (context.mounted) Utils.logout(c: context);
        return jsonData;
      } else if (response.statusCode == 404) {
        jsonData = json.decode(response.body);
        if (return404) {
          return jsonData;
        }
      } else {
        jsonData = json.decode(response.body);
      }
    } catch (socketException) {
      if (loading == true && loading != null) EasyLoading.dismiss();
      return null;
    }
  }

  dynamic onTimeout() {
    CustomToast().showToast('Error', 'Network error', true);
    EasyLoading.dismiss();
    return http.Response('Error', 408);
  }
}
