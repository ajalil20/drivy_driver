import 'package:drivy_driver/Model/user_model.dart';

class ContractModel {
  String id='';
  User? userId;
  // User? influencerId;
  String startDate='';
  String endDate='';
  String paymentType='';
  String gift='';
  int price=0;
  String requestStatus='';
  String createdAt='';
  String updatedAt='';
  int? v;

  ContractModel({
    this.id='',
    this.userId,
    // this.influencerId,
    this.gift='',
    this.startDate='',
    this.endDate='',
    this.paymentType='',
    this.price=0,
    this.requestStatus='',
    this.createdAt='',
    this.updatedAt='',
    this.v,
  });

  ContractModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    userId = (json['user_id']??json['influencer_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['user_id']??json['influencer_id'] as Map<String,dynamic>) : null;
    startDate = json['start_date']??'';
    endDate = json['end_date']??'';
    paymentType = json['payment_type']??'';
    gift = json['gift']??'';
    price = json['price']??0;
    requestStatus = json['request_status']??'';
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??'';
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['user_id'] = userId?.toJson();
    json['start_date'] = startDate;
    json['end_date'] = endDate;
    json['gift'] = gift;
    json['payment_type'] = paymentType;
    json['price'] = price;
    json['request_status'] = requestStatus;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    return json;
  }
}
