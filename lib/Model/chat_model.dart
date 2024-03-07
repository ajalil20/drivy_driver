import 'package:drivy_driver/Model/user_model.dart';

class Chat {
  String id='';
  User? senderId;
  User? receiverId;
  User? commentUser;
  User? user;
  String type='';
  dynamic attachment;
  String isRead='';
  String message='';
  String isBlocked='';
  String createdAt='';
  String updatedAt='';

  Chat({
    this.id='',
    this.senderId,
    this.receiverId,
    this.commentUser,
    this.user,
    this.type='',
    this.attachment,
    this.isRead='',
    this.isBlocked='',
    this.createdAt='',
    this.message='',
    this.updatedAt='',
  });

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    senderId = (json['sender_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['sender_id'] as Map<String,dynamic>) : null;
    receiverId = (json['receiver_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['receiver_id'] as Map<String,dynamic>) : null;
    commentUser = (json['user_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['user_id'] as Map<String,dynamic>) : null;
    type = json['type']??'';
    attachment = json['attachment'];
    isRead = json['is_read']??'';
    isBlocked = json['is_blocked']??'';
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??'';
    message = json['message']??json['comment']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['sender_id'] = senderId?.toJson();
    json['receiver_id'] = receiverId?.toJson();
    json['user_id'] = commentUser?.toJson();
    json['type'] = type;
    json['attachment'] = attachment;
    json['is_read'] = isRead;
    json['is_blocked'] = isBlocked;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['message'] = message;
    return json;
  }
}