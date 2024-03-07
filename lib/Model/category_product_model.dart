import 'package:drivy_driver/Model/stream_model.dart';
import 'package:drivy_driver/Model/user_model.dart';

class ProductsModel {
  String id='';
  String title='';
  var price;
  String description='';
  String category='';
  User? sellerId;
  List<String>? prodImages;
  Category? categoryId;
  String image='';
  var avgRating;
  var myRating;
  // Rating? rating;
  int quantity=1;
  int isFavourite=0;
  bool isChecked=false;
  List<StreamModel>? streaming;

  ProductsModel({
    this.id='',
    this.title='',
    this.price,
    this.description='',
    this.category='',
    this.image='',
    this.sellerId,
    // this.rating,
    this.prodImages,
    this.categoryId,
    this.avgRating,
    this.myRating,
    this.streaming,
    this.isChecked=false,
    this.quantity=1,
    this.isFavourite=0,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']??json['product_id']??'';
    title = json['title']??'';
    sellerId = (json['seller_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['seller_id'] as Map<String,dynamic>) : null;
    price = json['price'];
    quantity = json['quantity']??1;
    isFavourite = json['is_favourite']??0;
    description = json['description']??'';
    image = (json['prod_images'] as List?)!=null?((json['prod_images'] as List).isNotEmpty?(json['prod_images'] as List)[0]:''):'';
    avgRating = json['avg_rating']??0.0;
    myRating = json['my_rating'];
    categoryId = (json['category_id'] as Map<String,dynamic>?) != null ? Category.fromJson(json['category_id'] as Map<String,dynamic>) : null;
    category = categoryId?.categoryName??'';
    prodImages = (json['prod_images'] as List?)?.map((dynamic e) => e as String).toList();
    streaming = (json['streaming'] as List?)?.map((dynamic e) => StreamModel.fromJson(e as Map<String,dynamic>)).toList();
    // rating = (json['rating'] as Map<String,dynamic>?) != null ? Rating.fromJson(json['rating'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['title'] = title;
    json['price'] = price;
    json['description'] = description;
    json['category_name'] = category;
    json['seller_id'] = sellerId?.toJson();
    json['quantity'] = quantity;
    json['image'] = image;
    json['my_rating'] = myRating;
    json['is_favourite'] = isFavourite;
    json['avg_rating'] = avgRating;
    json['prod_images'] = prodImages;
    json['category_id'] = categoryId?.toJson();
    json['streaming'] = streaming?.map((e) => e.toJson()).toList();
// json['rating'] = rating?.toJson();
    return json;
  }
}
class OrderProductsModel {
  String id='';
  int quantity=1;
  OrderProductsModel({
    this.id='',
    this.quantity=1,
  });

  OrderProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['product_id']??'';
    quantity = json['quantity']??1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['product_id'] = id;
    json['quantity'] = quantity;
    return json;
  }
}
class Rating {
  var rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['rate'] = rate;
    json['count'] = count;
    return json;
  }
}
class Category {
  String id='';
  String categoryName='';

  Category({
    this.id='',
    this.categoryName='',
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    categoryName = json['name']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['name'] = categoryName;
    return json;
  }
}
class Reviews {
  String id='';
  User? userId;
  dynamic rating;
  String review='';
  String createdAt='';
  int isMyReview=0;

  Reviews({
    this.id='',
    this.userId,
    this.rating,
    this.review='',
    this.createdAt='',
    this.isMyReview=0,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    userId = (json['user_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['user_id'] as Map<String,dynamic>) : null;
    rating = json['rating']??0.0;
    review = json['review']??'';
    createdAt = json['createdAt']??'';
    isMyReview = json['is_my_review']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['user_id'] = userId?.toJson();
    json['rating'] = rating;
    json['review'] = review;
    json['createdAt'] = createdAt;
    json['is_my_review'] = isMyReview;
    return json;
  }
}