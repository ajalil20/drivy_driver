import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
// import 'package:month_year_picker/month_year_picker.dart';
import 'package:drivy_driver/Utils/app_router.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'Utils/my_colors.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  configLoading();
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = APIEndpoints.stripeKey;
  // await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}
void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Color(0xffF2951F)
    ..textColor = Colors.transparent
    ..boxShadow=[BoxShadow(color: Colors.transparent)]
    ..maskType=EasyLoadingMaskType.custom
    ..loadingStyle=EasyLoadingStyle.custom
    ..indicatorSize = 35.0
    ..radius = 10.0
    ..maskColor = Colors.transparent//.withOpacity(0.6)
    ..userInteractions = false
    ..dismissOnTap = false;
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Sizer(builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          navigatorKey: globalkey,
          darkTheme: lightTheme,
          themeMode: ThemeMode.system,
          // localizationsDelegates: [
          //   MonthYearPickerLocalizations.delegate,
          // ],
          title: 'Drivy',
          locale: const Locale('en', 'US'),
          builder: EasyLoading.init(),
          // home: HomePage(),
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      });
  }
}


GlobalKey<NavigatorState> globalkey = GlobalKey();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}