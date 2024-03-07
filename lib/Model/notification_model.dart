class NotificationModel {
  String id='';
  String title='';
  String body='';
  String notificationType='';
  String productId='';
  String createdAt='';
  String senderId='';
  String firstName='';
  String lastName='';
  String orderId='';
  String roomId='';
  String requestId='';
  String orderStatus='';
  dynamic senderName;
  String senderImage='';

  NotificationModel({
    this.id='',
    this.title='',
    this.body='',
    this.notificationType='',
    this.createdAt='',
    this.senderId='',
    this.senderName,
    this.orderId='',
    this.requestId='',
    this.senderImage='',
    this.roomId='',
    this.firstName='',
    this.orderStatus='',
    this.productId='',
    this.lastName='',
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    title = json['title']??'';
    body = json['body']??'';
    notificationType = json['notification_type']??'';
    createdAt = json['createdAt']??'';
    senderId = json['sender_id']??'';
    senderName = json['sender_name'];
    senderImage = json['sender_image']??'';
    firstName = json['first_name']??'';
    lastName = json['last_name']??'';
    orderId = json['order_id']??'';
    requestId = json['request_id']??'';
    roomId = json['room_id']??'';
    orderStatus = json['order_status']??'';
    productId = json['product_id']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['title'] = title;
    json['order_id'] = orderId;
    json['body'] = body;
    json['notification_type'] = notificationType;
    json['createdAt'] = createdAt;
    json['sender_id'] = senderId;
    json['room_id'] = roomId;
    json['sender_name'] = senderName;
    json['request_id'] = requestId;
    json['product_id'] = productId;
    json['sender_image'] = senderImage;
    json['first_name'] = firstName;
    json['last_name'] = lastName;
    json['order_status'] = orderStatus;
    return json;
  }
}