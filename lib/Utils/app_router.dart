import 'package:drivy_user/View/User/Home/Rental/additional_service.dart';
import 'package:drivy_user/View/User/Home/Rental/rental_car_checkout.dart';
import 'package:drivy_user/View/User/More/help_support.dart';
import 'package:drivy_user/View/User/Home/Ride/ride.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/Arguments/content_argument.dart';
import 'package:drivy_user/Arguments/product_arguments.dart';
import 'package:drivy_user/Arguments/profile_screen_arguments.dart';
import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Model/user_model.dart';
import 'package:drivy_user/Service/url_launcher.dart';
import 'package:drivy_user/View/Authentication/enter_otp.dart';
import 'package:drivy_user/View/Authentication/forgot_password.dart';
import 'package:drivy_user/View/Authentication/login_screen.dart';
import 'package:drivy_user/View/Authentication/phone_login.dart';
import 'package:drivy_user/View/Authentication/pre_login.dart';
import 'package:drivy_user/View/Authentication/profile_setup.dart';
import 'package:drivy_user/View/Authentication/role_selection.dart';
import 'package:drivy_user/View/Authentication/signup_screen.dart';
import 'package:drivy_user/View/Chat/chatting.dart';
import 'package:drivy_user/View/Chat/messages.dart';
import 'package:drivy_user/View/Contract/contract_history.dart';
import 'package:drivy_user/View/Contract/create_contract.dart';
import 'package:drivy_user/View/Earnings/my_earnings.dart';
import 'package:drivy_user/View/Influencer/Schedule/create_schedule.dart';
import 'package:drivy_user/View/Influencer/influencer_list.dart';
import 'package:drivy_user/View/Influencer/influencer_profile.dart';
import 'package:drivy_user/View/Influencer/seller_stream_request.dart';
import 'package:drivy_user/View/Payment/all_cards.dart';
import 'package:drivy_user/View/Payment/select_payment.dart';
import 'package:drivy_user/View/Products/add_product.dart';
import 'package:drivy_user/View/Products/product_catalog.dart';
import 'package:drivy_user/View/Review/all_reviews.dart';
import 'package:drivy_user/View/Seller/pay_influencer.dart';
import 'package:drivy_user/View/Seller/seller_contract_history.dart';
import 'package:drivy_user/View/Seller/seller_earning.dart';
import 'package:drivy_user/View/Seller/seller_profile.dart';
import 'package:drivy_user/View/User/More/settings.dart';
import 'package:drivy_user/View/Products/product_detail.dart';
import 'package:drivy_user/View/User/more.dart';
import 'package:drivy_user/View/home_view.dart';
import 'package:drivy_user/View/my_video_player.dart';
import 'package:drivy_user/View/notifications.dart';
import 'package:drivy_user/View/Splash/splash.dart';

import '../View/Authentication/create_password.dart';
import '../View/Authentication/enter_phone.dart';
import '../View/Payment/add_card.dart';
import '../View/Products/cart.dart';
import '../View/User/Booking/booking_detail.dart';
import '../View/User/Home/City/check_out_city.dart';
import '../View/User/Home/City/city_detail.dart';
import '../View/User/Home/City/city_to_city.dart';
import '../View/User/Home/City/select_date.dart';
import '../View/User/Home/Driver/select_car.dart';
import '../View/User/Home/Rental/availability.dart';
import '../View/User/Home/Rental/car_detail.dart';
import '../View/User/Home/Rental/car_rental.dart';
import '../View/User/Home/Rental/rental_car_booking.dart';
import '../View/User/Home/Rental/rules.dart';
import '../View/User/Home/Ride/add_car.dart';
import '../View/User/Home/Ride/select_car.dart';
import '../View/User/More/Driver/my_drivers.dart';
import '../View/User/More/change_password.dart';
import '../View/User/More/payment_settings.dart';
import '../View/User/More/promo_codes.dart';
import '../View/User/More/saved_address.dart';
import 'app_router_name.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case AppRouteName.SPLASH_SCREEN_ROUTE:
            return SplashScreen();
            // return CustomBottomNavigationBar();
          case AppRouteName.ROLE_SELECTION:
            return RoleSelection();
          case AppRouteName.PRE_LOGIN_SCREEN_ROUTE:
            return PreLoginScreen();
          case AppRouteName.LOGIN_SCREEN_ROUTE:
            return LoginScreen();
          case AppRouteName.ENTER_PHONE_SCREEN_ROUTE:
            return EnterPhone();
          case AppRouteName.FORGET_PASSWORD_ROUTE:
            return ForgotPassword();
          case AppRouteName.SIGNUP_SCREEN_ROUTE:
            return SignupScreen();
          case AppRouteName.CreatePassword:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return CreatePassword(
              fromForgetPassword: arg?.fromForgetPassword??false,
            );
          case AppRouteName.ENTER_OTP_SCREEN_ROUTE:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return EnterOTP(
              isFirebase: arg?.isFirebase??false,
              fromForgetPassword: arg?.fromForgetPassword??false,
              // isFirebase: otpRoutingArgument?.isFirebase,
            );
        //   case AppRouteName.RESET_PASSWORD_SCREEN_ROUTE:
        //     return const ResetPasswordScreen();
        // // case AppRouteName.USER_COMPLETE_PROFILE_SCREEN_ROUTE:
        // //   return UserCompleteProfile();
          case AppRouteName.COMPLETE_PROFILE_SCREEN_ROUTE:
              ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return ProfileSetup(
              editProfile: arg?.fromEdit??false,
            );
          case AppRouteName.HOME_SCREEN_ROUTE:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return HomeView(i: arg?.index??0,);
            // return CustomBottomNavigationBar();
          case AppRouteName.PHONE_LOGIN_SCREEN_ROUTE:
            return PhoneLogin();
          case AppRouteName.PRODUCT_DETAIL_ROUTE:
            ProductArguments? arg = routeSettings.arguments as ProductArguments?;
            return ProductDetail(
              index: arg?.index??0,
                fromLiveStream: arg?.fromLiveStream??false
            );
          case AppRouteName.ADD_PRODUCT_ROUTE:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return AddProduct(
              fromEdit: arg?.fromEdit??false,
            );
          case AppRouteName.PAYMENT_METHOD_ROUTE:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return SelectPayment(
                fromLiveStream: arg?.fromLiveStream??false
            );
          case AppRouteName.MyDrivers:
            return MyDrivers();
          case AppRouteName.PromoCodes:
            return PromoCodes();
          case AppRouteName.PaymentSettings:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return PaymentSettings(
              fromRide: arg?.fromRide??false,
              fromRental: arg?.fromRental??false,
            );
          case AppRouteName.SavedAddress:
            return SavedAddress();
          case AppRouteName.HelpSupport:
            return HelpSupport();
          case AppRouteName.ChangePassword:
            return ChangePassword();
          case AppRouteName.Ride:
            return Ride();
          case AppRouteName.Availability:
            return Availability();
          case AppRouteName.Rules:
            return Rules();
          case AppRouteName.AdditionalService:
            return AdditionalService();
          case AppRouteName.SelectCarCategory:
            return SelectCarCategory();
          case AppRouteName.SelectCar:
            return SelectCar();
          case AppRouteName.AddCar:
            return AddCar();
          case AppRouteName.CarRentals:
            return CarRentals();
          case AppRouteName.CityToCity:
            return CityToCity();
          case AppRouteName.CityDetail:
            return CityDetail();
          case AppRouteName.SelectDate:
            return SelectDate();
          case AppRouteName.CheckoutCity:
            return CheckoutCity();
          case AppRouteName.CarDetail:
            return CarDetail();
          case AppRouteName.CityCarBooking:
            return CityCarBooking();
          case AppRouteName.RentalCarCheckout:
            return RentalCarCheckout();
          case AppRouteName.BookingDetail:
            return BookingDetail();



          case AppRouteName.SETTINGS_ROUTE:
            return Settings();
          case AppRouteName.SELLER_EARNING_ROUTE:
            return SellerEarning();
          case AppRouteName.SELLER_CONTRACT_HISTORY_ROUTE:
            return SellerContractHistory();
          case AppRouteName.SELLER_PROFILE_ROUTE:
            return SellerProfile();
          case AppRouteName.ALL_CARDS_ROUTE:
            return AllCards();
          case AppRouteName.ADD_CARD_ROUTE:
            return AddCard();
          case AppRouteName.CART_ROUTE:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return Cart(fromLiveStream: arg?.fromLiveStream??false,);
          case AppRouteName.NOTIFICATION_SCREEN_ROUTE:
            return NotificationScreen();
          case AppRouteName.MESSAGE_SCREEN_ROUTE:
            return Messages();
          case AppRouteName.CHAT_SCREEN_ROUTE:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            // return LiveStream(hasInfluencer: arg?.hasInfluencer??false,);
            return ChatScreen(u: arg?.u??User(),);
          case AppRouteName.MY_EARNING_SCREEN:
            return MyEarning();
          case AppRouteName.CONTRACT_HISTORY_SCREEN:
            return ContractHistory();
          case AppRouteName.PRODUCT_CATALOG_SCREEN_ROUTE:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return ProductCatalog(fromLiveStream: arg?.fromLiveStream);
          case AppRouteName.VIDEO_PLAYER_ROUTE:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return MyVideoPlayer(url: arg?.url??'',showSellerProfileOnly: arg?.showSellerProfileOnly??false,);
          case AppRouteName.CONTENT_SCREEN:
            ContentRoutingArgument? contentRoutingArgument = routeSettings.arguments as ContentRoutingArgument?;
            return ContentScreen(
              url: contentRoutingArgument?.url ?? "",
              contentType: contentRoutingArgument?.contentType,
              title: contentRoutingArgument?.title ?? "",
              isMerchantSetupDone: contentRoutingArgument?.isMerchantSetupDone,
            );
          case AppRouteName.INFLUENCER_PROFILE_ROUTE:
            ScreenArguments? arg = routeSettings.arguments as ScreenArguments?;
            return InfluencerProfile(contractPending: arg?.contractPending,contractSigned: arg?.contractSigned,);
          case AppRouteName.INFLUENCERS_LIST_ROUTE:
            return InfluencersList();
          case AppRouteName.CREATE_CONTRACT_SCREEN:
            return CreateContract();
          case AppRouteName.SELLER_STREAM_REQUEST_ROUTE:
            return SellerStreamRequest();
          case AppRouteName.ALL_REVIEWS_ROUTE:
            return AllReviews();
          case AppRouteName.PAY_INFLUENCER_ROUTE:
            return PayInfluencer();
          case AppRouteName.CREATE_SCHEDULE_ROUTE:
            return CreateSchedule();
          case AppRouteName.USER_PROFILE_ROUTE:
            ProfileScreenArguments? arg = routeSettings.arguments as ProfileScreenArguments?;
            return More(
              isMe: arg?.isMe??false,
              u: arg?.u,
            );
          default:
            return Container();
        }
      },
    );
  }
}
