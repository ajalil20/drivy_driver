import 'package:drivy_driver/Model/user_model.dart';

class EarningModel {
  String id='';
  User? userId;
  dynamic amount;
  String? createdAt;

  EarningModel({
    this.id='',
    this.userId,
    this.amount,
    this.createdAt,
  });

  EarningModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    userId = (json['user_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['user_id'] as Map<String,dynamic>) : null;
    amount = json['amount'];
    createdAt = json['createdAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['user_id'] = userId?.toJson();
    json['amount'] = amount;
    json['createdAt'] = createdAt;
    return json;
  }
}