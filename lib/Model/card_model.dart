class CardModel {
  String id='';
  String userId='';
  int cardNumber=0;
  String stripeToken='';
  int isActive=0;
  int isBlocked=0;
  String createdAt='';
  String updatedAt='';
  int v=0;

  CardModel({
    this.id='',
    this.userId='',
    this.cardNumber=0,
    this.stripeToken='',
    this.isActive=0,
    this.isBlocked=0,
    this.createdAt='',
    this.updatedAt='',
    this.v=0,
  });

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    userId = json['userId']??'';
    cardNumber = json['card_number']??0;
    stripeToken = json['stripe_token']??'';
    isActive = json['is_active']??0;
    isBlocked = json['is_blocked']??0;
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??'';
    v = json['__v']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['userId'] = userId;
    json['card_number'] = cardNumber;
    json['stripe_token'] = stripeToken;
    json['is_active'] = isActive;
    json['is_blocked'] = isBlocked;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    return json;
  }
}