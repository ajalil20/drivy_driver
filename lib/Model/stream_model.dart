import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Model/chat_model.dart';
import 'package:drivy_driver/Model/user_model.dart';

class StreamModel {
  String id='';
  User? sellerId;
  User? influencerId;
  String roomId='';
  dynamic thumbnailImage;
  String description='';
  String createdAt='';
  String updatedAt='';
  int totalViews=0;
  int isEnded=0;
  int productsCount=0;
  int viewCount=0;
  Category? categoryId;
  List<Chat>? comments;
  String category='';
  String recordingUrl='';


  StreamModel({
    this.id='',
    this.sellerId,
    this.influencerId,
    this.roomId='',
    this.thumbnailImage,
    this.description='',
    this.createdAt='',
    this.updatedAt='',
    this.totalViews=0,
    this.isEnded=0,
    this.productsCount=0,
    this.viewCount=0,
    this.categoryId,
    this.comments,
    this.category='',
    this.recordingUrl='',
  });

  StreamModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    sellerId = (json['seller_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['seller_id'] as Map<String,dynamic>) : null;
    influencerId = (json['influencer_id'] as Map<String,dynamic>?) != null ? User.fromJson(json['influencer_id'] as Map<String,dynamic>) : null;
    // categoryId = (json['category_id'] as Map<String,dynamic>?) != null ? CategoryId.fromJson(json['category_id'] as Map<String,dynamic>) : null;
    roomId = json['room_id']??'';
    thumbnailImage = json['thumbnail_image'];
    description = json['description']??'';
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??'';
    recordingUrl = json['recording_url']??'';
    totalViews = json['total_views']??0;
    isEnded = json['is_ended']??0;
    productsCount = json['products_count']??0;
    viewCount = json['view_count']??0;
    comments = (json['comments'] as List?)?.map((dynamic e) => Chat.fromJson(e as Map<String,dynamic>)).toList();
    categoryId = (json['category_id'] as Map<String,dynamic>?) != null ? Category.fromJson(json['category_id'] as Map<String,dynamic>) : null;
    category = categoryId?.categoryName??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['seller_id'] = sellerId?.toJson();
    json['influencer_id'] = influencerId?.toJson();
    json['room_id'] = roomId;
    json['thumbnail_image'] = thumbnailImage;
    json['description'] = description;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['is_ended'] = isEnded;
    json['view_count'] = viewCount;
    json['products_count'] = productsCount;
    json['total_views'] = totalViews;
    json['recording_url'] = recordingUrl;
    json['category_id'] = categoryId?.toJson();
    json['comments'] = comments?.map((e) => e.toJson()).toList();
    return json;
  }
}