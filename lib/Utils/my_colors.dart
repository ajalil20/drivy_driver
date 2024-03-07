import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: const Color(0xffF3F1F2),
    primaryColorDark: const Color(0xffce0000),
  colorScheme: const ColorScheme.light(primary: Color(0xffF2951F),),

  // colorScheme: ColorScheme.fromSwatch().copyWith(
  //   secondary: Colors.white, // Your accent color
  // ),
    primaryColorLight: const Color(0xffF2951F),
      primaryColor:const Color(0xff0599B0),

    errorColor: Colors.red,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          color: Colors.black
      ),
      titleMedium: TextStyle(
          color: Colors.white
      ),
      titleSmall: TextStyle(
          color: Colors.black
      ),
    ),

    bottomAppBarColor: const Color(0xff8E9192),//hintcolor
    selectedRowColor: const Color(0xffffffff),//text_color
    indicatorColor: const Color(0xffFFFFFF),//screenContrastColor
    disabledColor: const Color(0xff09101D),//ScreenShadowColor
    hoverColor: const Color(0xff2972FE),// BlueWidgetColorColor
    dividerColor: const Color(0xff646464),//divider color

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff252525)
    ),
    // cardColor: Color(0xff394452),
    cardColor: const Color(0xff252525),
    focusColor: const Color(0xff161B20),//lightBlackColor
    canvasColor: Colors.transparent,
    hintColor:const Color(0xff4A4A4A) ,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        }
    ),
    // textSelectionTheme: const TextSelectionThemeData(cursorColor: Color(0xff161B20), selectionColor: Colors.white,)
    );


ThemeData lightTheme = ThemeData(
    errorColor: Colors.red,
    primaryColorDark: const Color(0xffce0000),
    primaryColorLight: const Color(0xffF2951F),
    primaryColor:const Color(0xff0599B0),
  // colorScheme: ColorScheme.fromSwatch().copyWith(
  //   secondary: Colors.white, // Your accent color
  // ),
  colorScheme: const ColorScheme.light(primary: Color(0xffF2951F),),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xffF2951F)),
  ),

    brightness: Brightness.light,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          color: Colors.black
      ),
      // titleMedium: TextStyle(
      //     color: Colors.white
      // ),
      titleSmall: TextStyle(
          color: Colors.black
      ),
    ),
    backgroundColor: const Color(0xffF3F1F2),
    // cardColor: Color(0xff394452),
    cardColor: const Color(0xffEBEEF2),
    canvasColor: Colors.transparent,

    hintColor:const Color(0xff4A4A4A) ,
    indicatorColor: const Color(0xff394452),//screenContrastColor
    disabledColor: const Color(0xffFFFFFF),//ScreenShadowColor
    hoverColor: const Color(0xff2972FE),// BlueWidgetColorColor
    bottomAppBarColor: const Color(0xff8E9192),//hintcolor
    selectedRowColor: const Color(0xffffffff),//text_color
    focusColor: const Color(0xff161B20),//lightBlackColor
    dividerColor: const Color(0xff646464),
    // colorScheme: ColorScheme(brightness: brightness, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xffF4F6F9)
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      disabledColor: Colors.grey,


    ),
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        }
    ),
    // textSelectionTheme: const TextSelectionThemeData(cursorColor: Color(0xffF6F8FB), selectionColor: Color(0xff394452),)
);






class MyColors {
  Color primaryColor = const Color(0xffF2951F);
  Color linkColor = const Color(0xff21428E);
  Color borderColor = const Color(0xffB8BAC6);
  Color greyColor = const Color(0xff666666);
  Color greenColor = const Color(0xff1DB51A);
  Color redColor = const Color(0xffFC463B);
  Color deleteColor = const Color(0xffF14848);
  Color black = const Color(0xff000000);
  Color textColor = const Color(0xff1C1A1A);
  Color textColor2 = const Color(0xff465061);
  Color pinkColor = const Color(0xffF2951F);
  Color purpleColor = const Color(0xff540163);
  Color rateColor = const Color(0xffFF8800);
  Color fbColor = const Color(0xff1877F2);
  Color twitterColor = const Color(0xff03A4F5);
  Color purpleLight = const Color(0xff8120A5);
  Color blueColor = const Color(0xff171257);
  Color titleColor = const Color(0xff0A0942);
  Color stripeColor = const Color(0xff2C97DE);
  Color gPayColor = const Color(0xffFF4031);
  Color payPalColor = const Color(0xff002987);
  Color visaColor = const Color(0xff059BBF);
  Color errorColor = const Color(0xffE30000);
  Color starColor = const Color(0xffFF8800);
  Color whiteColor = const Color(0xffFFFFFF);
  Color lightGrey = const Color(0xffF5F5F5);
  Color shimmerColor = Colors.grey;
  Color shimmerBaseColor = Colors.grey.withOpacity(0.8);
  Color hintColor = const Color(0xff8E9192);
  // Color greyColor = const Color(0xff6A6A6A);
  Color darkGreyColor = const Color(0xff373737);
  Color lightGreyColor = const Color(0xffD5D5D5);
  // Color darkGreyColor=const Color(0xff646464);


  Color iconColor = const Color(0xffCCDCF9);
  Color prefixContainerColor=const Color(0xffE2EBFC);

}