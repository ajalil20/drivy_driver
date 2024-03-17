import 'package:drivy_driver/Model/user_model.dart';

class ScreenArguments {
  bool? fromEdit,fromRental,fromForgetPassword,fromRide ,fromLiveStream,hasInfluencer, isFirebase,contractPending,contractSigned,isMe,showSellerProfileOnly,fromSignup;
  String? url;
  int? index;
  User? u;
  ScreenArguments({this.fromEdit,this.fromLiveStream,this.fromForgetPassword,this.fromRental,this.hasInfluencer,this.url,this.index,this.isFirebase,showSellerProfileOnly,this.contractPending,this.contractSigned,this.isMe,this.u,this.fromRide,this.fromSignup});
}