import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Model/user_model.dart';

class OrderModel {
  String id='';
  User? seller;
  User? user;
  List<ProductsModel>? products;
  ShippingAddress? shippingAddress;
  String orderNumber='';
  var price;
  var tax;
  var subTotal;
  String orderStatus='';
  String orderPlacedDate='';

  OrderModel({
    this.id='',
    this.seller,
    this.user,
    this.products,
    this.shippingAddress,
    this.orderNumber='',
    this.price,
    this.tax,
    this.subTotal,
    this.orderStatus='',
    this.orderPlacedDate='',
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    // sellerId = json['seller_id']??'';
    user = (json['user_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['user_id'] as Map<String,dynamic>) : null;
    seller = (json['seller_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['seller_id'] as Map<String,dynamic>) : null;
    products = (json['products'] as List?)?.map((dynamic e) => ProductsModel.fromJson(e as Map<String,dynamic>)).toList();
    shippingAddress = (json['shipping_address'] as Map<String,dynamic>?) != null ? ShippingAddress.fromJson(json['shipping_address'] as Map<String,dynamic>) : null;
    orderNumber = json['order_number']??'';
    price = json['price'];
    tax = json['tax'];
    subTotal = json['sub_total'];
    orderStatus = json['order_status']??'';
    orderPlacedDate = json['order_placed_date'] ??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['seller_id'] = seller?.toJson();
    json['user_id'] = user?.toJson();
    json['products'] = products?.map((e) => e.toJson()).toList();
    json['shipping_address'] = shippingAddress?.toJson();
    json['order_number'] = orderNumber;
    json['price'] = price;
    json['tax'] = tax;
    json['sub_total'] = subTotal;
    json['order_status'] = orderStatus;
    json['order_placed_date'] = orderPlacedDate;
    return json;
  }
}

class ShippingAddress {
  String address='';
  String state='';
  String zipCode='';

  ShippingAddress({
    this.address='',
    this.state='',
    this.zipCode='',
  });

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    address = json['address']??'';
    state = json['state']??'';
    zipCode = json['zip_code']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['address'] = address;
    json['state'] = state;
    json['zip_code'] = zipCode;
    return json;
  }
}