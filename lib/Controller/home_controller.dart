import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:drivy_driver/Model/new/my_rides.dart';
import 'package:drivy_driver/Model/new/ride_detail.dart';
import 'package:drivy_driver/Model/new/rides.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Model/card_model.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Model/chat_model.dart';
import 'package:drivy_driver/Model/contract_model.dart';
import 'package:drivy_driver/Model/earning_model.dart';
import 'package:drivy_driver/Model/order_model.dart';
import 'package:drivy_driver/Model/schedule_model.dart';
import 'package:drivy_driver/Model/user_model.dart';
import 'package:drivy_driver/Service/api_endpoints.dart';
import 'package:drivy_driver/Service/base_service.dart';
import 'package:drivy_driver/Service/dynamic_links.dart';
import 'package:drivy_driver/Service/socket_service.dart';
import 'package:drivy_driver/Service/stripe_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/app_strings.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:drivy_driver/Utils/local_shared_preferences.dart';
import 'package:drivy_driver/View/Products/add_product.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import '../Model/new/booking_detail_model.dart';
import '../Model/notification_model.dart';
import '../Model/stream_model.dart';
import '../Service/navigation_service.dart';
import '../Utils/utils.dart';
import 'global_controller.dart';

class HomeController extends GetxController {
  static HomeController get i => Get.find();
  BaseService b = BaseService();

  RxList<ProductsModel> products = List<ProductsModel>.empty().obs;
  RxList<ProductsModel> sellerProducts = List<ProductsModel>.empty().obs;
  RxList<ProductsModel> liveProducts = List<ProductsModel>.empty().obs;
  RxList<ProductsModel> liveStreamingProducts = List<ProductsModel>.empty().obs;
  RxList<ProductsModel> tempAllLiveProducts = List<ProductsModel>.empty().obs;
  RxList<ProductsModel> searchProducts = List<ProductsModel>.empty().obs;
  RxList<Reviews> productReviews = List<Reviews>.empty().obs;
  RxList<Reviews> userReviews = List<Reviews>.empty().obs;
  RxList<ProductsModel> wishlist = List<ProductsModel>.empty().obs;
  RxList<NotificationModel> notifications = List<NotificationModel>.empty().obs;
  RxList<Category> categories = List<Category>.empty().obs;
  Rx<ProductsModel> currentProduct = ProductsModel().obs;
  RxList<User> followers = List<User>.empty().obs;
  RxList<User> following = List<User>.empty().obs;
  String totalEarning = '0';
  RxList<EarningModel> earnings = List<EarningModel>.empty().obs;
  Rx<User> endUser = User().obs;
  RxList<User> userProfileVisits = List<User>.empty().obs;
  Rx<User> sellerUser = User().obs;
  Rx<User> influencerUser = User().obs;
  RxList<User> influencers = List<User>.empty().obs;
  RxList<User> searchInfluencers = List<User>.empty().obs;
  RxList<User> users = List<User>.empty().obs;
  RxList<User> streamingUsers = List<User>.empty().obs;

  RxList<ScheduleModel> tSchedule = List<ScheduleModel>.empty().obs;
  RxList<ScheduleModel> schedule = List<ScheduleModel>.empty().obs;
  List<OrderProductsModel> orderProducts = [];
  List<ScheduleModel> scheduleList = [];
  Rx<DateTime> selectedDate = DateTime.now().obs;

  int currentActiveRideId = 0;

  String name = "",
      cardNumber = "",
      month = "",
      year = '',
      cvc = "",
      token = '',
      category = '',
      price = '',
      description = '',
      address = '',
      zipCode = '',
      state = '',
      rating = '',
      review = '',
      startDate = '${DateTime.now()}',
      endDate = '',
      paymentMethod = '',
      amount = '';
  List fileName = [], files = [];
  List<FileNetwork> temp = [];
  bool cameraPermission = false;
  bool microphonePermission = false;

  ///Card
  Rx<CardModel> defaultCard = CardModel().obs;
  RxList<CardModel> cards = List<CardModel>.empty().obs;
  RxList<RideData> rides = List<RideData>.empty().obs;

  ///Card end

  /// Order
  RxList<OrderModel> recentOrders = List<OrderModel>.empty().obs;
  RxList<OrderModel> pastOrders = List<OrderModel>.empty().obs;
  Rx<OrderModel> orderDetail = OrderModel().obs;
  Rx<ProductsModel> orderProduct = ProductsModel().obs;

  /// Order end

  /// Contract
  Rx<ContractModel> contract = ContractModel().obs;
  RxList<ContractModel> recentContract = List<ContractModel>.empty().obs;
  RxList<ContractModel> historyContract = List<ContractModel>.empty().obs;

  /// Contract end

  /// Chat
  RxList<Chat> tChats = List<Chat>.empty().obs;
  RxList<Chat> chats = List<Chat>.empty().obs;
  RxList<Chat> inboxChats = List<Chat>.empty().obs;

  /// Chat end

  /// Stream start
  String roomID = "", streamToken = "";
  RxList<StreamModel> streams = List<StreamModel>.empty().obs;
  RxList<StreamModel> searchStreams = List<StreamModel>.empty().obs;
  RxList<StreamModel> streamedVideos = List<StreamModel>.empty().obs;
  Rx<StreamModel> liveStreaming = StreamModel().obs;

  /// Stream end

  addProductValidation(context, {required bool fromEdit}) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (temp.isEmpty) {
      CustomToast().showToast('Error', 'At least one image is required', true);
    } else if (name.isEmpty) {
      CustomToast().showToast('Error', 'Title field can\'t be empty', true);
    } else if (category.isEmpty) {
      CustomToast().showToast('Error', 'Category can\'t be empty', true);
    } else if (price.isEmpty) {
      CustomToast().showToast('Error', 'Price field can\'t be empty', true);
    } else if (double.parse(price) < 1) {
      CustomToast()
          .showToast('Error', 'Price should be greater than equal to 1', true);
    } else if (description.isEmpty) {
      CustomToast()
          .showToast('Error', 'Description field can\'t be empty', true);
    } else {
      addProduct(context, onSuccess: () {
        AppNavigation.navigatorPop(context);
        CustomToast().showToast(
            'Success',
            fromEdit
                ? 'Product updated successfully'
                : 'Product added successfully',
            false);
      }, fromEdit: fromEdit);
    }
  }

  Future<void> addProduct(context,
      {required Function onSuccess, required bool fromEdit}) async {
    Map<String, String> jsonData;
    jsonData = {
      if (fromEdit) 'product_id': currentProduct.value.id,
      'title': name,
      "description": description,
      "price": double.parse(price).toString(),
      "category_id": category,
      for (int i = 0; i < temp.length; i++)
        if (temp[i].isNetwork) "prevImg": getUrlFiles(),
    };
    log(jsonData.toString());
    getFiles(title: 'prod_image');
    var res = await b.baseFormPostAPI(
        fromEdit ? APIEndpoints.updateProduct : APIEndpoints.addProduct,
        jsonData,
        files,
        fileName,
        loading: true,
        context: context);
    if (res['status'] == 1) {
      if (fromEdit) {
        int index = products.indexWhere((i) => i.id == currentProduct.value.id);
        if (index != -1) {
          products[index] = ProductsModel.fromJson(res['data']);
          currentProduct.value = products[index];
        }
      } else {
        products.add(ProductsModel.fromJson(res['data']));
      }
      update();
      onSuccess();
      CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  /// Cart
  String sellerID = '';
  RxList<ProductsModel> cart = List<ProductsModel>.empty().obs;
  RxDouble cartTotal = 0.0.obs, productTax = 12.5.obs, totalAmount = 0.0.obs;

  /// Cart end

  ///Products
  Future<void> getAllProducts(
      {loading,
      required BuildContext context,
      required bool myProducts}) async {
    var r = await b.baseGetAPI(
        myProducts ? APIEndpoints.myProducts : APIEndpoints.product,
        loading: loading ?? true,
        context: context);
    if (r != null) {
      products.value = (r['data'] as List)
          .map((data) => ProductsModel.fromJson(data))
          .toList();
    } else {
      products = List<ProductsModel>.empty().obs;
    }
    update();
  }

  Future<void> getSellerProducts(
      {loading, required BuildContext context, required String id}) async {
    sellerProducts = List<ProductsModel>.empty().obs;
    var r = await b.baseGetAPI(APIEndpoints.sellerProducts + id,
        loading: loading ?? true, context: context);
    if (r != null) {
      sellerProducts.value = (r['data'] as List)
          .map((data) => ProductsModel.fromJson(data))
          .toList();
    } else {
      sellerProducts = List<ProductsModel>.empty().obs;
    }
    update();
  }

  Future<void> getLiveStreamProducts(
      {loading, required BuildContext context, required String id}) async {
    var r = await b.baseGetAPI(APIEndpoints.streamProducts + roomID,
        loading: loading ?? true, context: context);
    if (r != null) {
      liveStreamingProducts.value = (r['data'] as List)
          .map((data) => ProductsModel.fromJson(data))
          .toList();
    } else {
      liveStreamingProducts = List<ProductsModel>.empty().obs;
    }
    update();
  }

  Future<void> deleteProduct(context,
      {required Function onSuccess,
      required String id,
      required int index}) async {
    var res = await b.baseDeleteAPI(
        APIEndpoints.deleteProduct + currentProduct.value.id,
        loading: true,
        context: context);
    if (res['status'] == 1) {
      onSuccess();
      products.removeAt(index);
      update();
      CustomToast().showToast('Success', res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<void> addRemoveFavorite(context,
      {required Function onSuccess, required String id}) async {
    var res = await b.baseGetAPI(APIEndpoints.addRemoveFavorite + id,
        loading: true, context: context);
    if (res['status'] == 1) {
      onSuccess();
      updateFavorite(id: id);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  updateFavorite({required String id}) {
    int index = products.indexWhere((i) => i.id == id);
    int indexWishList = wishlist.indexWhere((i) => i.id == id);
    int indexSellerList = sellerProducts.indexWhere((i) => i.id == id);
    int indexStreamProductList =
        liveStreamingProducts.indexWhere((i) => i.id == id);
    if (index != -1) {
      products[index].isFavourite == 1
          ? products[index].isFavourite = 0
          : products[index].isFavourite = 1;
    }
    if (indexWishList != -1) {
      // wishlist[indexWishList].isFavourite==1?wishlist[indexWishList].isFavourite=0:wishlist[indexWishList].isFavourite=1;
      if (wishlist[indexWishList].isFavourite == 1) {
        wishlist.removeAt(indexWishList);
      }
    }
    if (indexSellerList != -1) {
      sellerProducts[indexSellerList].isFavourite == 1
          ? sellerProducts[indexSellerList].isFavourite = 0
          : sellerProducts[indexSellerList].isFavourite = 1;
    }
    if (indexStreamProductList != -1) {
      liveStreamingProducts[indexStreamProductList].isFavourite == 1
          ? liveStreamingProducts[indexStreamProductList].isFavourite = 0
          : liveStreamingProducts[indexStreamProductList].isFavourite = 1;
    }

    //Commented because profile detail ma favorite wapis toggle ho raha to
    // ussi state pa ajata jis pa tha
    if (currentProduct.value.id == id) {
      currentProduct.value.isFavourite == 1
          ? currentProduct.value.isFavourite = 0
          : currentProduct.value.isFavourite = 1;
    }
    update();
  }

  Future<void> addProductLiveStream({required String id}) async {
    int index = products.indexWhere((i) => i.id == id);
    int tempIndex = tempAllLiveProducts.indexWhere((i) => i.id == id);
    if (index != -1) {
      products[index].isChecked = !products[index].isChecked;
      update();
    }
    if (tempIndex == -1) {
      tempAllLiveProducts.add(products[index]);
    }
    liveProducts = List<ProductsModel>.empty().obs;
    for (var v in products) {
      if (v.isChecked) {
        liveProducts.add(v);
      }
    }
  }

  Future<void> getSearchProducts({required String s}) async {
    searchProducts.clear();
    if (products.isNotEmpty) {
      for (var v in products) {
        String name = v.title;
        if (name.toLowerCase().contains(s.toLowerCase())) {
          searchProducts.add(v);
        }
      }
    }
    update();
  }

  Future<void> getSearchInfluencers({required String s}) async {
    searchInfluencers.clear();
    if (influencers.isNotEmpty) {
      for (var v in influencers) {
        String fName = v.firstName;
        String lName = v.lastName;
        if (fName.toLowerCase().contains(s.toLowerCase()) ||
            lName.toLowerCase().contains(s.toLowerCase())) {
          searchInfluencers.add(v);
        }
      }
    }
    update();
  }

  Future<void> getSearchStream({required String s}) async {
    searchStreams.clear();
    if (streams.isNotEmpty) {
      for (var v in streams) {
        String sFName = v.sellerId?.firstName ?? '';
        String sLName = v.sellerId?.lastName ?? '';
        String iFName = v.influencerId?.firstName ?? '';
        String iLName = v.influencerId?.lastName ?? '';
        String description = v.description ?? '';
        if (sFName.toLowerCase().contains(s.toLowerCase()) ||
            sLName.toLowerCase().contains(s.toLowerCase()) ||
            iFName.toLowerCase().contains(s.toLowerCase()) ||
            iLName.toLowerCase().contains(s.toLowerCase()) ||
            description.toLowerCase().contains(s.toLowerCase())) {
          searchStreams.add(v);
        }
      }
    }
    update();
  }

  Future<void> getWishlistProducts(
      {loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.wishlist,
        loading: loading ?? true, context: context);
    if (r != null) {
      wishlist.value = (r['data'] as List)
          .map((data) => ProductsModel.fromJson(data))
          .toList();
    } else {
      wishlist = List<ProductsModel>.empty().obs;
    }
    update();
  }

  removeWishlistProduct({required ProductsModel p}) {
    /// For removing favorite in wish list
    int index = wishlist.indexWhere((i) => i.id == p.id);

    /// For removing favorite in products list
    int productsIndex = products.indexWhere((i) => i.id == p.id);
    if (index != -1) {
      wishlist.removeAt(index);
      update();
    }
    if (productsIndex != -1) {
      products[productsIndex].isFavourite = 0;
      update();
    }
  }

  Future<void> getProductDetail(context,
      {required ProductsModel p, bool? loading}) async {
    currentProduct.value = p;
    getProductReviews(context: context, p: p);
    var r = await b.baseGetAPI(APIEndpoints.getProductDetail + p.id,
        loading: loading ?? true, context: context);
    currentProduct.value = ProductsModel.fromJson(r['data']);
    update();
  }

  checkProduct({required String id}) {
    int index = products.indexWhere((i) => i.id == id);
    if (index != -1) {
      currentProduct.value = products[index];
      return true;
    } else {
      return false;
    }
  }

  void shareProduct(
      {String? postId,
      int? postIndex,
      required Uint8List capturedImage}) async {
    //   AppDialogs.progressAlertDialog(context: globalkey.navigatorKey.currentContext!);

    DynamicLinkProvider()
        .createLink(
            postId: postId, postIndex: postIndex, capturedImage: capturedImage)
        .then((value) async {
      //AppNavigation.navigatorPop(StaticData.navigatorKey.currentContext!);
      // Constants.shareUrl(url: value);
      print("DynamicLinkProvider called");
      await Share.shareFiles([value[0]], text: value[1]);
      // await Share.share(value);
    });
    //
  }

  Future<void> getCategories({loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.categories,
        loading: loading ?? true, context: context);
    if (r != null) {
      categories.value =
          (r['data'] as List).map((data) => Category.fromJson(data)).toList();
    }
    for (var v in categories) {
      log(v.id);
      log(v.categoryName);
    }
    print(categories.length);
    update();
  }

  orderValidation(context, {required Function onSuccess}) {
    if (cards.isEmpty) {
      CustomToast().showToast('Error', 'Add payment card', true);
    } else if (!checkDefaultCard()) {
      CustomToast().showToast('Error', 'Select payment card', true);
    } else if (address.isEmpty) {
      CustomToast().showToast('Error', 'Address field is required', true);
    } else if (zipCode.isEmpty) {
      CustomToast().showToast('Error', 'Zip code field is required', true);
    } else if (state.isEmpty) {
      CustomToast().showToast('Error', 'State field is required', true);
    } else {
      checkOut(context, onSuccess: onSuccess);
    }
  }

  Future<void> checkOut(context, {required Function onSuccess}) async {
    createOrderList();
    Map jsonData = {
      "card_id": defaultCard.value.id,
      "address": address,
      "state": state,
      "zip_code": zipCode,
      "price": cartTotal.value,
      "sub_total": totalAmount.value,
      'seller_id': cart.first.sellerId?.id,
      'tax': productTax.value,
      "products": orderProducts.map((orders) => orders.toJson()).toList(),
    };
    log(jsonData.toString());
    var res = await b.basePostAPI(APIEndpoints.checkout, jsonData,
        loading: true, context: context);
    if (res['status'] == 1) {
      onSuccess();
      emptyCart();
      // CustomToast().showToast("Success",res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  checkDefaultCard() {
    int index = cards.indexWhere((i) => i.isActive == 1);
    if (index != -1) {
      defaultCard.value = cards[index];
      return true;
    } else {
      return false;
    }
  }

  checkSellerInCart({required ProductsModel p}) {
    // int index = cart.indexWhere((i) => i.sellerId == p.sellerId);
    // print(index);
    log(sellerID);
    log(p.id);
    if (sellerID == p.sellerId?.id) {
      return true;
    } else {
      return false;
    }
  }

  createOrderList() {
    orderProducts = <OrderProductsModel>[];
    for (var element in cart) {
      orderProducts
          .add(OrderProductsModel(id: element.id, quantity: element.quantity));
    }
  }

  emptyCart() {
    cart = List<ProductsModel>.empty().obs;
    cartTotal = 0.0.obs;
    totalAmount = 0.0.obs;
    SharedPreference().setCart(cart: jsonEncode(cart));
    // GetStorageRepo.setValue(LocalDBKeys.CART, jsonEncode(cart));
  }

  ///Products End

  ///Order History
  Future<void> getOrderHistory(
      {loading, required BuildContext context, required bool recent}) async {
    bool userRole = GlobalController.values.userRole.value == UserRole.user;
    var r = await b.basePostAPI(
        userRole ? APIEndpoints.myOrders : APIEndpoints.orderHistory,
        {'type': recent ? AppStrings.CURRENT : AppStrings.HISTORY},
        loading: loading ?? false,
        context: context);
    if (r != null) {
      if (recent) {
        recentOrders.value = (r['data'] as List)
            .map((data) => OrderModel.fromJson(data))
            .toList();
      } else {
        pastOrders.value = (r['data'] as List)
            .map((data) => OrderModel.fromJson(data))
            .toList();
      }
    } else {
      if (recent) {
        recentOrders.value = List<OrderModel>.empty().obs;
      } else {
        pastOrders.value = List<OrderModel>.empty().obs;
      }
    }
    update();
  }

  Future<void> getOrderDetails(
      {loading, required BuildContext context, required OrderModel o}) async {
    // orderDetail.value=o;
    var r = await b.baseGetAPI(APIEndpoints.ordersDetails + o.id,
        loading: loading ?? true, context: context);
    orderDetail.value = OrderModel.fromJson(r['data']);
    update();
  }

  Future<void> updateOrderStatus(context,
      {required Function onSuccess,
      required OrderModel o,
      required String status}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map jsonData = {"order_id": o.id, "status": status};
    var res = await b.basePostAPI(APIEndpoints.orderStatus, jsonData,
        loading: true, context: context);
    if (res['status'] == 1) {
      onSuccess();
      recentOrderStatusUpdate(o: o, status: status);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  // recentOrderStatusUpdate({required OrderModel o,required String status}){
  //   int index = recentOrders.indexWhere((i) => i.id == o.id);
  //   if (index != -1) {
  //     if(status==AppStrings.CANCELLED || status==AppStrings.COMPLETED){
  //       recentOrders.removeAt(index);
  //       o.orderStatus=status;
  //       pastOrders.add(o);
  //     } else{
  //       recentOrders[index].orderStatus=status;
  //     }
  //     update();
  //   }
  // }
  recentOrderStatusUpdate({required OrderModel o, required String status}) {
    int index = recentOrders.indexWhere((i) => i.id == o.id);
    if (index != -1) {
      if (status == AppStrings.CANCELLED || status == AppStrings.COMPLETED) {
        o.orderStatus = status;
        int recentOrdersIndex = recentOrders.indexWhere((i) => i.id == o.id);
        pastOrders.add(recentOrders[recentOrdersIndex]);
        recentOrders.removeAt(index);
      } else {
        recentOrders[index].orderStatus = status;
      }
      update();
    }
  }

  /// User/product Reviews
  giveReviewValidation(context,
      {required bool edit, Reviews? r, required bool isProduct}) {
    if (review.isEmpty) {
      CustomToast().showToast('Error', 'Review field can\'t be empty', true);
    } else {
      // giveReview(context,onSuccess: (){AppNavigation.navigatorPop(context);},edit: edit,isProduct: isProduct);
    }
  }

  Future<void> getProductReviews(
      {loading,
      required BuildContext context,
      required ProductsModel p}) async {
    productReviews = List<Reviews>.empty().obs;
    var r = await b.baseGetAPI(APIEndpoints.productReviews + p.id,
        loading: loading ?? true, context: context);
    if (r['data'] != null) {
      orderProduct.value.avgRating = r['data']['avgRating'] ?? 0.0;
      productReviews.value = (r['data']['reviews'] as List)
          .map((data) => Reviews.fromJson(data))
          .toList();
    } else {
      productReviews = List<Reviews>.empty().obs;
    }
    update();
  }

  Future<void> deleteReview(context,
      {required Function onSuccess, required Reviews r}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var res = await b.baseDeleteAPI(APIEndpoints.deleteReview + r.id,
        loading: true, context: context);
    if (res['status'] == 1) {
      int index = productReviews.indexWhere((i) => i.id == r.id);
      if (index != -1) {
        productReviews.removeAt(index);
        orderProduct.value.myRating = null;
        orderProduct.value.avgRating = res['data']['avg_rating'] ?? 0.0;
        update();
      }
      onSuccess();
      CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  editReview({required Reviews r, required bool isProduct}) {
    if (isProduct) {
      int index = productReviews.indexWhere((i) => i.id == r.id);
      if (index != -1) {
        productReviews[index] = r;
        productReviews[index].isMyReview = 1;
        update();
      }
    } else {
      int index = userReviews.indexWhere((i) => i.id == r.id);
      if (index != -1) {
        userReviews[index] = r;
        update();
      }
    }
  }

  /// User/product Reviews end

  ///Order History End

  ///Notifications
  Future<void> getNotifications(
      {loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.getNotifications,
        loading: loading ?? true, context: context);
    if (r != null) {
      notifications.value = (r['data'] as List)
          .map((data) => NotificationModel.fromJson(data))
          .toList();
    } else {
      notifications = List<NotificationModel>.empty().obs;
    }
    update();
  }

  Future<void> onOffNotifications(context,
      {required Function onSuccess, required bool on}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map jsonData = {
      "is_notification": on ? 'on' : 'off',
    };
    var res = await b.basePostAPI(APIEndpoints.onOffNotifications, jsonData,
        loading: true, context: context);
    if (res['status'] == 1) {
      onSuccess();
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  ///Notifications End

  /// Cart
  Future<void> addToCart({required ProductsModel p}) async {
    int index = cart.indexWhere((i) => i.id == p.id);
    if (index != -1) {
      cart[index].quantity = p.quantity;
      CustomToast().showToast(
          'Cart', '${p.title} quantity increased to ${p.quantity}', false);
    } else {
      cart.add(p);
      CustomToast().showToast('Cart', '${p.title} added to your cart', false);
    }
    getCartTotal();
  }

  getCartDelte() {
    for (var v in cart) {
      log(v.id);
      log(v.title);
    }
    log("Cart Length is ${cart.length}");
  }

  Future<void> removeFromCart({required ProductsModel p}) async {
    int index = cart.indexWhere((i) => i.id == p.id);
    if (index != -1) {
      CustomToast().showToast('Cart', '${p.title} removed from cart.', false);
      cart.removeAt(index);
      getCartTotal();
    }
  }

  Future<void> getProductQuantity() async {
    int index = cart.indexWhere((i) => i.id == currentProduct.value.id);
    if (index != -1) {
      currentProduct.value.quantity = cart[index].quantity;
      update();
    }
  }

  getCartTotal() {
    cartTotal.value = 0.0;
    totalAmount.value = 0.0;
    productTax.value = 0;
    for (var f in cart) {
      cartTotal.value += f.price * f.quantity;
      productTax.value = 12.5;
    }
    totalAmount.value = productTax.value + cartTotal.value;
    SharedPreference().setCart(cart: jsonEncode(cart));
    // getLocalCart();
    update();
  }

  getLocalCart() {
    String? d = SharedPreference().getCart();
    print("SharedPreference cart");
    if (d != null) {
      cart.value = (jsonDecode(d.toString()) as List)
          .map((data) => ProductsModel.fromJson(data))
          .toList();
    }

    getCartTotal();

    // if(d!=null){
    //   log(d.toString());
    //   var encodedData = jsonDecode(d);
    //   print('encodedData.length');
    //   print(encodedData.length);
    //   encodedData.forEach((element) {
    //     cart.add(ProductsModel.fromJson(element));
    //     print("cart element");
    //     print(element);
    //   });
    // }
    // getCartTotal();
  }

  /// Cart end

  /// Cards
  addCardValidation(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (name.isEmpty) {
      CustomToast()
          .showToast("Warning", "Card holder name field can't be empty", true);
    } else if (cardNumber.isEmpty) {
      CustomToast()
          .showToast("Warning", "Card Number field can't be empty.", true);
    } else if (cardNumber.length < 19) {
      CustomToast()
          .showToast("Warning", "Please enter valid card number.", true);
    } else if (month.isEmpty) {
      CustomToast()
          .showToast("Warning", "Expiry month field can't be empty.", true);
    } else if (year.isEmpty) {
      CustomToast()
          .showToast("Warning", "Expiry year field can't be empty.", true);
    } else if (int.parse(year) == DateTime.now().year &&
        int.parse(month) <= DateTime.now().month) {
      CustomToast().showToast("Warning", "Your card has been expired.", true);
    } else if (cvc.isEmpty) {
      CustomToast().showToast("Warning", "CVV field can't be empty.", true);
    } else if (cvc.length < 3) {
      CustomToast().showToast("Warning", "Please enter valid CVV.", true);
    } else {
      loadingOn();
      // token = await StripeService.stripeToken(cardNumber: cardNumber,expMonth: month,expYear: year,cvc: cvc)??'';
      // if(token!=''){
      //   await addCard(context,onSuccess:(){AppNavigation.navigatorPop(context);} );
      // }
      loadingOff();
    }
  }

  Future<void> addCard(context, {required Function onSuccess}) async {
    var res = await b.basePostAPI(APIEndpoints.addCard,
        {'card_number': cardNumber.replaceAll(' ', ''), "stripe_token": token},
        loading: false, context: context);
    if (res['status'] == 1) {
      onSuccess();
      CustomToast().showToast("Success", res['message'], false);
      if (cards.isEmpty) {
        cards.value = [];
      }
      cards.add(CardModel.fromJson(await res['data']));
      update();
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<void> setCardDefault(context,
      {required Function onSuccess,
      required String id,
      required int index}) async {
    var res = await b.basePostAPI(APIEndpoints.setCardDefault, {'card_id': id},
        loading: true, context: context);
    if (res['status'] == 1) {
      deactivateCards();
      cards[index].isActive = 1;
      cards.refresh();
      onSuccess();
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<bool> deleteCard(context,
      {required Function onSuccess,
      required String id,
      required int index}) async {
    var res = await b.baseDeleteAPI(APIEndpoints.deleteCard + id,
        loading: true, context: context);
    if (res['status'] == 1) {
      cards.removeAt(index);
      update();
      return true;
    } else {
      CustomToast().showToast("Error", res['message'], true);
      return false;
    }
  }

  Future<void> getCards(context, {loading}) async {
    var r = await b.baseGetAPI(APIEndpoints.allCards,
        loading: loading ?? true, context: context);
    if (r['data'] != null) {
      cards.value =
          (r['data'] as List).map((data) => CardModel.fromJson(data)).toList();
    } else {
      cards.value = List<CardModel>.empty();
    }
    update();
  }

  deactivateCards() {
    for (int i = 0; i < cards.length; i++) {
      cards[i].isActive = 0;
    }
    update();
  }

  /// Cards end

  getFiles({required String title}) {
    fileName = [];
    files = [];
    for (var v in temp) {
      if (!v.isNetwork) {
        files.add(File(v.path));
        fileName.add(title);
      }
    }
  }

  getUrlFiles() {
    String t = '[';
    for (var v in temp) {
      if (v.isNetwork) {
        t = '$t"${v.path}",';
      }
    }
    if (t.endsWith(",")) {
      t = t.substring(0, t.length - 1);
    }
    t = '$t]';
    return t;
  }

  ///Follow/Followers
  Future<void> getFollowers(
      {loading, required BuildContext context, required String id}) async {
    var r = await b.baseGetAPI(APIEndpoints.followers + id,
        loading: loading ?? true, context: context);
    if (r != null) {
      followers.value =
          (r['data'] as List).map((data) => User.fromJson(data)).toList();
      // AuthController.i.user.value.followers=followers.length;
    } else {
      followers = List<User>.empty().obs;
    }
    update();
  }

  Future<void> getFollowing(
      {loading, required BuildContext context, required String id}) async {
    var r = await b.baseGetAPI(APIEndpoints.following + id,
        loading: loading ?? true, context: context);
    if (r != null) {
      following.value =
          (r['data'] as List).map((data) => User.fromJson(data)).toList();
      // AuthController.i.user.value.following=following.length;
    } else {
      following = List<User>.empty().obs;
    }
    update();
  }

  Future<void> addFollowUnFollow(context,
      {required Function onSuccess, required String id}) async {
    var res = await b.baseGetAPI(APIEndpoints.followUnfollow + id,
        loading: true, context: context);
    if (res['status'] == 1) {
      // cards.add(CardModel.fromJson(res['data']));
      update();
      onSuccess();
      CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<void> getUserDetail(
      {loading, required BuildContext context, required String id}) async {
    var r = await b.baseGetAPI(APIEndpoints.profileDetails + id,
        loading: loading ?? true, context: context);
    if (r != null) {
      endUser.value = User.fromJson(r['data']);
      onProfileVisit();
    }
  }

  onProfileVisit() {
    userProfileVisits.add(endUser.value);
  }

  onProfileVisitBack() {
    print('userProfileVisits ${userProfileVisits.length}');
    // userProfileVisits.removeLast();
    if (userProfileVisits.isNotEmpty) {
      endUser.value = userProfileVisits.last;
      endUser.refresh();
    }
  }

  Future<void> getUserStreamedVideos(
      {loading,
      required BuildContext context,
      required String id,
      required String role}) async {
    var r = await b.basePostAPI(
        APIEndpoints.savedStreaming, {'id': id, 'role': role},
        loading: loading ?? false, context: context);
    if (r != null) {
      streamedVideos.value = (r['data']['stream'] as List)
          .map((data) => StreamModel.fromJson(data))
          .toList();
      if (r['data']['live_stream'] != null) {
        liveStreaming.value = StreamModel.fromJson(r['data']['live_stream']);
      } else {
        liveStreaming = StreamModel().obs;
      }
    } else {
      streamedVideos = List<StreamModel>.empty().obs;
    }
    update();
  }

  /// Follow/Followers End
  Future<void> getInfluencers({loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.influencers,
        loading: loading ?? true, context: context);
    if (r != null) {
      influencers.value =
          (r['data'] as List).map((data) => User.fromJson(data)).toList();
    } else {
      influencers = List<User>.empty().obs;
    }
    update();
  }

  Future<void> getStreamInfluencers(
      {loading, required BuildContext context}) async {
    // var r = await b.baseGetAPI(APIEndpoints.streamInfluencers+'/${DateTime.now().toUtc()}',loading: loading??true,context: context);
    var r = await b.basePostAPI(
        APIEndpoints.streamInfluencers,
        {
          'room_id': roomID,
          'date': '${DateTime.now().toUtc()}',
        },
        loading: loading ?? true,
        context: context);
    if (r != null) {
      influencers.value =
          (r['data'] as List).map((data) => User.fromJson(data)).toList();
    } else {
      influencers = List<User>.empty().obs;
    }
    update();
  }

  /// Schedule
  Future<void> addSchedule(context, {required Function onSuccess}) async {
    Map<String, dynamic> jsonData;
    jsonData = {
      'start_date': startDate,
      'end_date': endDate,
      "schedule": scheduleList.map((v) => v.toJson()).toList(),
    };
    var res = await b.basePostAPI(APIEndpoints.addSchedule, jsonData,
        loading: true, context: context);
    if (res['status'] == 1) {
      schedule.value = (res['data']['schedule'] as List)
          .map((data) => ScheduleModel.fromJson(data))
          .toList();
      update();
      onSuccess();
      CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<void> getSchedule(context,
      {required String d, required String id}) async {
    schedule = List<ScheduleModel>.empty().obs;
    update();
    Map<String, String> jsonData;
    jsonData = {
      'user_id': id,
      "start_date": Utils.convertTimeToUTC(
          time: Utils.dayStartTime, date: DateTime.parse(d)),
      "end_date": Utils.convertTimeToUTC(
          time: Utils.dayEndTime, date: DateTime.parse(d)),
    };
    var res = await b.basePostAPI(APIEndpoints.getSchedule, jsonData,
        loading: true, context: context);
    if (res['status'] == 1) {
      schedule.value = (res['data'] as List)
          .map((data) => ScheduleModel.fromJson(data))
          .toList();
      // tSchedule.value = (res['data'] as List).map((data) => ScheduleModel.fromJson(data)).toList();
      // for (var v in tSchedule) {
      //   if (d == Utils.convertToLocalDate(time: v.startTime)) {
      //     schedule.add(v);
      //   }
      // }
    }
    update();
  }

  Future<void> deleteSchedule(context,
      {required Function onSuccess, required ScheduleModel s}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var res = await b.baseDeleteAPI(APIEndpoints.deleteSchedule + s.id,
        loading: true, context: context);
    if (res['status'] == 1) {
      int index = schedule.indexWhere((i) => i.id == s.id);
      if (index != -1) {
        schedule.removeAt(index);
        update();
      }
      onSuccess();
      CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  /// Schedule End

  ///Contract
  createContractValidation(context, {required Function onSuccess}) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (name.isEmpty) {
      CustomToast().showToast('Error', 'Influencer name is required', true);
    } else if (startDate.isEmpty) {
      CustomToast().showToast('Error', 'Start Date is required', true);
    } else if (endDate.isEmpty) {
      CustomToast().showToast('Error', 'End Date is required', true);
    } else if (DateFormat("MM-dd-yyyy")
        .parse(startDate)
        .isAfter(DateFormat("MM-dd-yyyy").parse(endDate))) {
      CustomToast().showToast(
          'Error', 'Start date must not be greater than end date', true);
    } else if (paymentMethod.isEmpty) {
      CustomToast().showToast('Error', 'Mode of payment is required', true);
    } else if (amount.isEmpty) {
      CustomToast().showToast(
          'Error',
          paymentMethod == AppStrings.GIFT
              ? 'Gift field can\'t be empty'
              : 'Price is required',
          true);
    } else {
      if (paymentMethod == AppStrings.OTP ||
          paymentMethod == AppStrings.COMMISION) {
        if (double.parse(amount) < 1) {
          CustomToast().showToast(
              'Error', 'Price should be greater than equal to 1', true);
        } else {
          AppNavigation.navigateTo(
            context,
            AppRouteName.PAY_INFLUENCER_ROUTE,
          );
        }
      } else {
        createContract(context, onSuccess: () {
          onSuccess();
        }, isGift: true);
      }
    }
  }

  createContractValidationII(context, {required Function onSuccess}) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (cards.isEmpty) {
      CustomToast().showToast('Error', 'Add payment card', true);
    } else if (!checkDefaultCard()) {
      CustomToast().showToast('Error', 'Select payment card', true);
    } else {
      createContract(context, onSuccess: () {
        onSuccess();
      }, isGift: false);
    }
  }

  Future<void> createContract(context,
      {required Function onSuccess, required bool isGift}) async {
    Map<String, String> jsonData;
    jsonData = {
      'influencer_id': endUser.value.id,
      'start_date': Utils.convertTimeToUTC(
          time: Utils.dayStartTime,
          date: Utils().convertToDateTime(d: startDate)),
      'end_date': Utils.convertTimeToUTC(
          time: Utils.dayEndTime, date: Utils().convertToDateTime(d: endDate)),
      // 'start_date':startDate,
      // 'end_date':endDate,
      if (isGift) 'gift': amount else 'price': amount,
      'payment_type': Utils().getContractPaymentKey(paymentMethod),
    };
    var res = await b.basePostAPI(APIEndpoints.sendContract, jsonData,
        loading: true, context: context);
    if (res['status'] == 1) {
      updateInfluencerContactStatus(
          status: AppStrings.PENDING_KEY, id: endUser.value.id);
      onSuccess();
      // CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<void> getContract(
      {loading, required BuildContext context, required String type}) async {
    bool sellerRole = GlobalController.values.userRole.value == UserRole.seller;
    var r = await b.baseGetAPI(
        sellerRole
            ? APIEndpoints.contractHistorySeller + type
            : APIEndpoints.contractHistoryInfluencer + type,
        loading: loading ?? true,
        context: context);
    if (r != null) {
      if (type == AppStrings.RECENT) {
        recentContract.value = (r['data'] as List)
            .map((data) => ContractModel.fromJson(data))
            .toList();
      } else {
        historyContract.value = (r['data'] as List)
            .map((data) => ContractModel.fromJson(data))
            .toList();
      }
    } else {
      if (type == AppStrings.RECENT) {
        recentContract.value = List<ContractModel>.empty().obs;
      } else {
        historyContract.value = List<ContractModel>.empty().obs;
      }
    }
    update();
  }

  onTapContract({required ContractModel c}) {
    contract.value = c;
  }

  Future<void> acceptRejectContract(context,
      {required Function onSuccess, required String status}) async {
    Map<String, String> jsonData;
    jsonData = {
      'request_id': contract.value.id,
      'request_status': status,
    };
    var res = await b.basePostAPI(APIEndpoints.acceptRejectContract, jsonData,
        loading: true, context: context);
    if (res['status'] == 1) {
      updateContactStatus(status: status);
      onSuccess();
      CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  updateContactStatus({required String status}) {
    int index = recentContract.indexWhere((i) => i.id == contract.value.id);
    if (index != -1) {
      recentContract[index].requestStatus = status;
      if (status == AppStrings.REJECTED_KEY) {
        recentContract.removeAt(index);
      }
    }
    update();
  }

  updateInfluencerContactStatus({required String status, required String id}) {
    int index = influencers.indexWhere((i) => i.id == id);
    if (index != -1) {
      influencers[index].requestStatus = status;
      endUser.value.requestStatus = status;
      endUser.refresh();
    }
    update();
  }

  ///Contract End

  /// Earning
  Future<void> getEarnings({loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.myEarnings,
        loading: loading ?? true, context: context);
    if (r != null) {
      totalEarning = '${r['data']['total_earnings'] ?? 0}';
      earnings.value = (r['data']['earning_details'] as List)
          .map((data) => EarningModel.fromJson(data))
          .toList();
    } else {
      totalEarning = '0';
      earnings = List<EarningModel>.empty().obs;
    }
    update();
  }

  /// Earning end

  loadingOn() {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
  }

  loadingOff() {
    EasyLoading.dismiss();
  }

  /// Chats
  void getAllMessages({required String id}) {
    SocketService.instance?.socketEmitMethod(
        eventName: APIEndpoints.getMessages,
        eventParamaters: {
          'sender_id': AuthController.i.user.value.id,
          'receiver_id': id,
        });
  }

  setChatMessages({required dynamic r}) {
    if (r['object_type'] == AppStrings.GET_ALL_MESSAGES) {
      chats.value =
          (r['data'] as List).map((data) => Chat.fromJson(data)).toList();
    } else {
      chats.add(Chat.fromJson(r['data']));
    }
    update();
  }

  void sendMessage(
      {required Function onSuccess,
      required String message,
      required String id,
      String? type}) {
    FocusManager.instance.primaryFocus?.unfocus();
    SocketService.instance?.socketEmitMethod(
        eventName: APIEndpoints.sendMessage,
        eventParamaters: {
          'sender_id': AuthController.i.user.value.id,
          'receiver_id': id,
          'message': message,
          'type': type,
        });
  }

  Future<void> sendImage(context) async {
    loadingOn();
    var res = await b.baseFormPostAPI(
        APIEndpoints.sendImage, {}, File(temp.first.path), ["message_image"],
        loading: false, context: context);
    if (res['status'] == 1) {
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  Future<void> getChats({loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.chatList,
        loading: loading ?? true, context: context);
    inboxChats = List<Chat>.empty().obs;
    tChats = List<Chat>.empty().obs;
    if (r != null) {
      tChats.value =
          (r['data'] as List).map((data) => Chat.fromJson(data)).toList();
      for (var v in tChats) {
        if (v.receiverId?.id != AuthController.i.user.value.id) {
          inboxChats.add(Chat(
              id: v.id,
              user: v.receiverId,
              type: v.type,
              attachment: v.attachment,
              isRead: v.isRead,
              isBlocked: v.isBlocked,
              createdAt: v.createdAt,
              updatedAt: v.updatedAt,
              message: v.message));
        } else if (v.senderId?.id != AuthController.i.user.value.id) {
          inboxChats.add(Chat(
              id: v.id,
              user: v.senderId,
              type: v.type,
              attachment: v.attachment,
              isRead: v.isRead,
              isBlocked: v.isBlocked,
              createdAt: v.createdAt,
              updatedAt: v.updatedAt,
              message: v.message));
        }
      }
    }
    // else{chats= List<Chat>.empty().obs;}
    update();
  }

  /// Chats end

  /// Live Streaming
  startStreamingValidation(context, {required Function onSuccess}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (temp.isEmpty) {
      CustomToast().showToast('Error', 'Thumbnail is required', true);
    } else if (!Platform.isIOS) {
      // checkCameraMicrophone();
      // if(!cameraPermission){
      //   CustomToast().showToast('Error', 'Camera access is required to go live', true);
      // }else if(!microphonePermission){
      //   CustomToast().showToast('Error', 'Microphone access is required to go live', true);
      // } else{
      //   startStreaming(context,onSuccess: (){onSuccess(); });
      // }

      if (!cameraPermission) {
        if (!(await Utils().requestCameraPermissions())) {
          CustomToast()
              .showToast('Error', 'Camera access is required to go live', true);
        }
      } else if (!microphonePermission) {
        if (!(await Utils().requestMicrophonePermissions())) {
          CustomToast().showToast(
              'Error', 'Microphone access is required to go live', true);
        }
      } else {
        startStreaming(context, onSuccess: () {
          onSuccess();
        });
      }
      // if(!(await Utils().requestCameraPermissions())){
      //   CustomToast().showToast('Error', 'Camera access is required to go live', true);
      // }else if(!(await Utils().requestMicrophonePermissions() )){
      //   CustomToast().showToast('Error', 'Microphone access is required to go live', true);
      // } else{
      //   startStreaming(context,onSuccess: (){onSuccess(); });
      // }
    } else {
      startStreaming(context, onSuccess: () {
        onSuccess();
      });
    }
  }

  Future<void> getStreaming({loading, required BuildContext context}) async {
    bool influencerRole =
        GlobalController.values.userRole.value == UserRole.influencer;
    var r = await b.baseGetAPI(
        influencerRole ? APIEndpoints.streamInvites : APIEndpoints.streams,
        loading: loading ?? true,
        context: context);
    if (r != null) {
      streams.value = (r['data'] as List)
          .map((data) => StreamModel.fromJson(data))
          .toList();
    } else {
      streams = List<StreamModel>.empty().obs;
    }
    update();
  }

  Future<void> startStreaming(context, {required Function onSuccess}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, String> jsonData = {
      'description':
          '${AuthController.i.user.value.firstName} ${AuthController.i.user.value.lastName} started streaming',
      'category_id': liveProducts.first.categoryId!.id.toString(),
      for (int i = 0; i < liveProducts.length; i++)
        "products[$i]": liveProducts[i].id,
    };
    print(jsonData);
    getFiles(title: 'thumbnail_image');
    var r = await b.baseFormPostAPI(
        APIEndpoints.startStreaming, jsonData, files, fileName,
        loading: true, context: context);
    if (r['status'] == 1 && r['data'] != null) {
      roomID = r['data']['room_id'];
      streamToken = r['data']['token'];
      onSuccess();
      CustomToast().showToast("Success", r['message'], false);
      startLeaveStreamingSocket(context, roomId: roomID, start: true);
      addProductToLiveStream();
    } else {
      CustomToast().showToast("Error", r['message'], true);
    }
  }

  checkCameraMicrophone() async {
    // microphonePermission
    final status = await Permission.camera.request();
    if (status.isGranted) {
      cameraPermission = true;
    } else if (status.isPermanentlyDenied) {
      CustomToast().showToast(
          'Camera access denied',
          'To enable camera access, please visit our app\'s settings. ⚙️',
          true);
      openAppSettings();
      return false;
    }
    final microphoneStatus = await Permission.microphone.request();
    if (microphoneStatus.isGranted) {
      microphonePermission = true;
    } else if (microphoneStatus.isPermanentlyDenied) {
      CustomToast().showToast(
          'Microphone access denied',
          'To enable microphone access, please visit our app\'s settings. ⚙️',
          true);
      openAppSettings();
      return false;
    }
  }

  addProductToLiveStream() {
    // List<String> t = [];
    // for (int i=0;i<liveProducts.length;i++){
    //   t.add(liveProducts[i].id);
    // }
    Map<String, dynamic> jsonData = {
      'user_id': AuthController.i.user.value.id,
      'room_id': roomID,
      // "products":  t.toString(),
      "products": liveProducts.map((orders) => orders.id).toList(),
      // for (int i=0;i<liveProducts.length;i++)
      //   "products[$i]": liveProducts[i].id,
    };
    log('addProductToLiveStream');
    log(jsonData.toString());
    SocketService.instance?.socketEmitMethod(
        eventName: APIEndpoints.addProductSocket, eventParamaters: jsonData);
  }

  Future<void> endStreaming(context, {required Function onSuccess}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool sellerRole = GlobalController.values.userRole.value == UserRole.seller;
    if (sellerRole) {
      endStreamingSocket(context);
    } else {
      startLeaveStreamingSocket(context, roomId: roomID, start: false);
    }
    emptyStreamingProducts();
    Map<String, String> jsonData = {
      'room_id': roomID,
      for (int i = 0; i < tempAllLiveProducts.length; i++)
        "products[$i]": tempAllLiveProducts[i].id,
    };
    var r = await b.basePostAPI(APIEndpoints.endStreaming, jsonData,
        loading: false, context: context);
    if (r['status'] == 1) {
      onSuccess();
      // CustomToast().showToast("Success", r['message'], false);
    } else {
      CustomToast().showToast("Error", r['message'], true);
    }
  }

  Future<void> startLeaveStreamingSocket(context,
      {String? id,
      String? r,
      required String roomId,
      required bool start}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String role = GlobalController.values.userRole.value == UserRole.seller
        ? AppStrings.BROADCASTER
        : GlobalController.values.userRole.value == UserRole.influencer
            ? AppStrings.CO_BROADCASTER
            : AppStrings.USER;
    log('startLeaveStreamingSocket');
    log({
      'user_id': id ?? AuthController.i.user.value.id,
      'room_id': roomId,
      'role': r ?? role,
    }.toString());
    SocketService.instance?.socketEmitMethod(
        eventName: start
            ? APIEndpoints.joinStreamSocket
            : APIEndpoints.leaveStreamSocket,
        eventParamaters: {
          'user_id': id ?? AuthController.i.user.value.id,
          'room_id': roomId,
          'role': r ?? role,
        });
  }

  Future<void> endStreamingSocket(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    SocketService.instance
        ?.socketEmitMethod(eventName: APIEndpoints.endStream, eventParamaters: {
      'room_id': roomID,
    });
  }

  Future<void> removeUserSocket(context, {required String id}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    SocketService.instance?.socketEmitMethod(
        eventName: APIEndpoints.removeUser,
        eventParamaters: {
          'admin_id': AuthController.i.user.value.id,
          'user_id': id,
          'room_id': roomID,
        });
    log("Event Name : ${APIEndpoints.removeUser}");
    log({
      'admin_id': AuthController.i.user.value.id,
      'user_id': id,
      'room_id': roomID,
    }.toString());
  }

  Future<void> commentStreamingSocket(context,
      {required String comment}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    SocketService.instance?.socketEmitMethod(
        eventName: APIEndpoints.commentSocket,
        eventParamaters: {
          'user_id': AuthController.i.user.value.id,
          'room_id': roomID,
          'comment': comment,
        });
    print({
      'user_id': AuthController.i.user.value.id,
      'room_id': roomID,
      'comment': comment,
    });
  }

  Future<void> getCommentStreamingSocket(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    SocketService.instance?.socketEmitMethod(
        eventName: APIEndpoints.getComments,
        eventParamaters: {
          'user_id': AuthController.i.user.value.id,
          'room_id': roomID,
        });
  }

  Future<void> deleteCommentStreamingSocket(context,
      {required String commentID}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    SocketService.instance?.socketEmitMethod(
        eventName: APIEndpoints.deleteCommentSocket,
        eventParamaters: {
          'user_id': AuthController.i.user.value.id,
          'room_id': roomID,
          'comment_id': commentID,
        });
  }

  Future<void> joinStreaming(context,
      {required Function onSuccess, required String roomId, String? id}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String role = GlobalController.values.userRole.value == UserRole.seller
        ? AppStrings.BROADCASTER
        : GlobalController.values.userRole.value == UserRole.influencer
            ? AppStrings.CO_BROADCASTER
            : AppStrings.USER;
    Map<String, String> jsonData = {
      'room_id': roomId,
      'role': role,
      if (id != null) 'request_id': id,
    };
    var r = await b.basePostAPI(APIEndpoints.joinToken, jsonData,
        loading: true, context: context);
    if (r['status'] == 1) {
      roomID = roomId;
      streamToken = r['data']['authToken'];
      onSuccess();
      startLeaveStreamingSocket(context, roomId: roomId, start: true);
      // CustomToast().showToast("Success", r['message'], false);
    } else {
      CustomToast().showToast("Error", r['message'], true);
    }
    return r['status'];
  }

  onStreamJoined({required dynamic r}) {
    bool sellerRole = GlobalController.values.userRole.value == UserRole.seller;
    if (sellerRole) {
      sellerUser.value = AuthController.i.user.value;
    }
    liveStreaming.value = StreamModel.fromJson(r);
    sellerUser.value = liveStreaming.value.sellerId ?? User();
    influencerUser.value = liveStreaming.value.influencerId ?? User();
    update();
  }

  Future<int> sendInvite(context,
      {required Function onSuccess, required String id}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var r = await b.basePostAPI(
        APIEndpoints.sendInvite, {'influencer_id': id, 'room_id': roomID},
        loading: true, context: context);
    if (r['status'] == 1) {
      int index = influencers.indexWhere((i) => i.id == id);
      if (index != -1) {
        influencers[index].requestId = r['data']['_id'];
      }
      onSuccess();
      CustomToast().showToast("Success", r['message'], false);
    } else {
      CustomToast().showToast("Error", r['message'], true);
    }
    return r['status'];
  }

  Future<void> rejectInvite(
      {loading, required BuildContext context, required String id}) async {
    bool sellerRole = GlobalController.values.userRole.value == UserRole.seller;
    var r = await b.baseGetAPI(
        sellerRole
            ? APIEndpoints.cancelInvite + id
            : APIEndpoints.rejectInvite + id,
        loading: loading ?? true,
        context: context);
    if (r['status'] == 1) {
      if (!sellerRole) {
        removeStreamInvite(id: id);
      } else {
        int index = influencers.indexWhere((i) => i.requestId == id);
      }
      update();
      CustomToast().showToast("Success", r['message'], false);
    } else {
      CustomToast().showToast("Error", r['message'], true);
    }
    update();
  }

  removeStreamInvite({required String id}) {
    int index = streams.indexWhere((i) => i.id == id);
    if (index != -1) {
      streams.removeAt(index);
      update();
    }
  }

  emptyStreamingProducts() {
    tempAllLiveProducts.value = List<ProductsModel>.empty().obs;
    liveProducts.value = List<ProductsModel>.empty().obs;
    for (var v in products) {
      v.isChecked = false;
    }
    update();
  }

  Future<void> getStreamingViewers(
      {loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.streamViewers + roomID,
        loading: loading ?? true, context: context);
    if (r != null) {
      streamingUsers.value =
          (r['data'] as List).map((data) => User.fromJson(data)).toList();
    } else {
      streamingUsers = List<User>.empty().obs;
    }
    update();
  }

  Future<void> saveStreaming(context,
      {required Function onSuccess, required bool save}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var res = await b.basePostAPI(APIEndpoints.saveStream,
        {'room_id': roomID, 'status': save ? 'yes' : 'no'},
        loading: true, context: context);
    if (res['status'] == 1) {
      onSuccess();
      CustomToast().showToast("Success", res['message'], false);
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  void getSavedStreamMessages() {
    SocketService.instance?.socketEmitMethod(
        eventName: APIEndpoints.streamingComments,
        eventParamaters: {
          'user_id': AuthController.i.user.value.id,
          'room_id': liveStreaming.value.roomId,
          'type': 'recording',
        });
  }

  getRecordedStreamComments({required dynamic r}) {
    if (r != null) {
      liveStreaming.value.comments =
          (r['comments'] as List).map((data) => Chat.fromJson(data)).toList();
    }
    update();
  }

  getRecordedStream({required StreamModel s}) {
    bool sellerRole = GlobalController.values.userRole.value == UserRole.seller;
    if (sellerRole) {
      sellerUser.value = AuthController.i.user.value;
    }
    liveStreaming.value = s;
    sellerUser.value = liveStreaming.value.sellerId ?? User();
    influencerUser.value = liveStreaming.value.influencerId ?? User();
    update();
  }

  /// Live Streaming End
  ///
  Future<void> getRides({loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.rides,
        loading: loading ?? true, context: context);
    if (r != null) {
      rides.value =
          (r['data'] as List).map((data) => RideData.fromJson(data)).toList();
    } else {
      rides = List<RideData>.empty().obs;
    }
    update();
  }

  Future<void> getDashboardData(
      {loading, required BuildContext context}) async {
    var r = await b.baseGetAPI(APIEndpoints.dashbaordStatistics,
        loading: loading ?? true, context: context);
    if (r != null) {
      if (r['data']['earning'] != null) {
        allEarnings.value = double.parse(r['data']['earning'].toString());
      } else {
        allEarnings.value = 0.0;
      }

      if (r['data']['totalRide'] != null) {
        totalRide.value = int.parse(r['data']['total_ride'].toString());
      } else {
        totalRide.value = 0;
      }
    } else {
      rides = List<RideData>.empty().obs;
    }
    update();
  }

  RxDouble allEarnings = 0.0.obs;
  RxInt totalRide = 0.obs;

  Future<void> getCurrentActiveRide(
      {loading, required BuildContext context}) async {
    polylines.clear();
    markers.clear();
    var r = await b.baseGetAPI('${APIEndpoints.rides}/$currentActiveRideId',
        loading: loading ?? true, context: context);
    if (r['data'] != null) {
      currentActiveRide = RideDetailData.fromJson(r['data']);

      startLatLng = LatLng(
          double.parse(
              currentActiveRide?.pickupAddress?.latitude.toString() ?? "0.0"),
          double.parse(
              currentActiveRide?.pickupAddress?.longitude.toString() ?? "0.0"));
      endLatLong = LatLng(
          double.parse(
              currentActiveRide?.dropoffAddress?.latitude.toString() ?? "0.0"),
          double.parse(
              currentActiveRide?.dropoffAddress?.longitude.toString() ??
                  "0.0"));
      update();

      // log(startLatLng!.latitude.toString());
      // log(startLatLng!.longitude.toString());

      // log(endLatLong!.latitude.toString());
      // log(endLatLong!.longitude.toString());

      await getPolyPoints(true);

      // / rides.value =
      //     (r['data'] as List).map((data) => RideData.fromJson(data)).toList();
    } else {
      currentActiveRide = null;

      update();
      // rides = List<RideData>.empty().obs;
    }
    update();
  }

  RideDetailData? currentActiveRide;

  Future<void> changeRideStatus(
    context, {
    required Function onSuccess,
    required String rideStatus,
    required String rideId,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, String> jsonData = {
      "status": rideStatus,
    };

    log(jsonData.toString());
    var res = await b.basePostAPI('${APIEndpoints.ride}/$rideId', jsonData,
        loading: true, context: context);

    if (res['success'] == true) {
      if (res['data'] != null) {
        // currentActiveRide = RideDetailData.fromJson(res['data']);
        currentActiveRide?.driverStatus = res['data']['driver_status'];

        currentActiveRide?.subTotal = res['data']['sub_total'] != null
            ? double.parse(res['data']['sub_total'].toString())
            : 0.0;
        currentActiveRide?.platformFee = res['data']['platform_fee'] != null
            ? double.parse(res['data']['platform_fee'].toString())
            : 0.0;
        // if (currentActiveRide?.driverStatus == 'end_drive') {
        //   // currentActiveRide?.subTotal = res['data']['sub_total'] != null
        //   //     ? double.parse(res['data']['sub_total'].toString())
        //   //     : 0.0;

        //   // currentActiveRide?.platformFee = res['data']['platform_fee'] != null
        //   //     ? double.parse(res['data']['platform_fee'].toString())
        //   //     : 0.0;
        // } else if (currentActiveRide?.driverStatus == "complete") {
        //   currentActiveRide = null;
        // }

        update();
        onSuccess();
      }
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }

  RideDetailData? _tripDataModel;
  RideDetailData? get tripDataModel => _tripDataModel;

  bool isPickup = true;

  Future<void> getBookingDetail(
      {loading, required BuildContext context, required int id}) async {
    var r = await b.baseGetAPI('${APIEndpoints.trips}/$id',
        loading: loading ?? true, context: context);
    if (r['data'] != null) {
      _tripDataModel = RideDetailData.fromJson(r['data']);

      update();
    } else {
      _tripDataModel = null;
      startLatLng = null;
      endLatLong = null;
      update();
    }
    // update();
  }

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  RxList<MyRideListData> previousTrips = List<MyRideListData>.empty().obs;

  ///Previous Trips
  Future<void> getPreviousTrips(
      {loading, required BuildContext context, bool isChauffer = false}) async {
    previousTrips.clear();
    var r = await b.baseGetAPI(
        isChauffer ? 'chauffeur-driver/myrides' : APIEndpoints.myRides,
        loading: loading ?? true,
        context: context);
    if (r != null) {
      previousTrips.value = (r['data'] as List)
          .map((data) => MyRideListData.fromJson(data))
          .toList();
    } else {
      previousTrips = List<MyRideListData>.empty().obs;
    }
    update();
  }

  GoogleMapController? mapController;

  void initMarker({required LatLng l, index}) async {
    final MarkerId markerId = MarkerId('MyLocation');

    final image = AuthController.i.user.value.userImage;

    final imageWidget = Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color: image == null ? MyColors().primaryColor : null,
          shape: BoxShape.circle,
          image: image != null
              ? DecorationImage(
                  image: NetworkImage(
                    image,
                  ),
                  fit: BoxFit.cover)
              : null,
          border: Border.all(color: MyColors().primaryColor, width: 2)),
      child: image == null
          ? const Icon(
              Icons.location_on,
              size: 100,
            )
          : null,
    );

    final Marker marker = Marker(
        markerId: markerId,
        icon: await imageWidget.toBitmapDescriptor(
            logicalSize: const Size(150, 150), imageSize: const Size(150, 150)),
        position: l,
        onTap: () async {});
    markers[markerId] = marker;
    markers.refresh();
    mapController?.animateCamera(CameraUpdate.newLatLng(
      LatLng(l.latitude, l.longitude),
    ));
  }

  Position? currentPosition;
  LatLng? startLatLng;
  LatLng? endLatLong;

  Future<void> getPolyPoints(bool pickup) async {
    polylineCoordinates.clear();
    streamSubscription?.cancel();
    markers.clear();
    await getCurrentUserLocation(true);
    log(isPickup.toString());
    log(currentPosition.toString());
  }

  createPolyLines() async {
    PolylinePoints polylinePoints = PolylinePoints();
    polylineCoordinates.clear();
    polylines.value = [];
    if (currentPosition != null) {
      if (currentActiveRide?.pickupAddress?.latitude != null &&
          currentActiveRide?.dropoffAddress?.latitude != null) {
        log("CREATING POLYLINE");

        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            AppStrings.GOOGLE_MAP_KEY,
            PointLatLng(
              currentPosition!.latitude,
              currentPosition!.longitude,
            ),

            // riderToCustomer
            isPickup
                ? PointLatLng(
                    double.parse(
                        currentActiveRide!.pickupAddress!.latitude.toString()),
                    double.parse(
                        currentActiveRide!.pickupAddress!.longitude.toString()),
                  )
                : PointLatLng(
                    double.parse(
                        currentActiveRide!.dropoffAddress!.latitude.toString()),
                    double.parse(currentActiveRide!.dropoffAddress!.longitude
                        .toString()),
                  ));

        log("POLY LINES ${polylines.length}");

        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            polylineCoordinates.add(
              LatLng(point.latitude, point.longitude),
            );
          }

          const MarkerId markerId = MarkerId('EndLocation');

          Polyline newPolyline = Polyline(
            polylineId: const PolylineId('route'),
            points: polylineCoordinates,
            color: MyColors().primaryColor,
          );
          polylines.value = [newPolyline];

          if (currentActiveRide != null) {
            final Marker marker = Marker(
                markerId: markerId,
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: const InfoWindow(title: 'Pickup Point'),
                position: isPickup
                    ? LatLng(
                        double.parse(currentActiveRide!.pickupAddress!.latitude
                            .toString()),
                        double.parse(currentActiveRide!.pickupAddress!.longitude
                            .toString()))
                    : LatLng(
                        double.parse(currentActiveRide!.dropoffAddress!.latitude
                            .toString()),
                        double.parse(currentActiveRide!
                            .dropoffAddress!.longitude
                            .toString())),
                onTap: () async {});
            markers[markerId] = marker;
            markers.refresh();
          }

          print(polylines.length);
          // update();
        }
      }
    }
  }

  RxList<Polyline> polylines = <Polyline>[].obs;
  List<LatLng> polylineCoordinates = [];
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  getCurrentUserLocation(bool getPolyPoints) async {
    final permission = await _geolocatorPlatform.checkPermission();
    log(permission.name);

    if (permission == LocationPermission.denied) {
      final status = await _geolocatorPlatform.requestPermission();

      if (status == LocationPermission.always ||
          status == LocationPermission.whileInUse) {
        _permissionGranted();
      }
    } else if (permission == LocationPermission.deniedForever) {
      // settins();
      _openAppSettings();
    } else {
      _permissionGranted(getPolyPpoints: getPolyPoints);
    }
  }

  void _openAppSettings() async {
    final opened = await _geolocatorPlatform.openAppSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }

    // _updatePositionList(
    //   _PositionItemType.log,
    //   displayValue,
    // );
  }

  StreamSubscription? streamSubscription;
  Timer? debounceTimer;

  String distanceInKMS = "";

  _permissionGranted({bool getPolyPpoints = false}) async {
    // EasyLoading.instance.userInteractions = false;
    // EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
    log("PermissionGranted");
    streamSubscription =
        _geolocatorPlatform.getPositionStream().listen((position) async {
      // userCurrentPosition.value = "${position.latitude},${position.longitude}";

      currentPosition = position;

      if (isPickup) {
        final distance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            double.parse(
                (currentActiveRide?.pickupAddress?.latitude.toString() ??
                    "0.0")),
            double.parse(
                (currentActiveRide?.pickupAddress?.longitude.toString() ??
                    "0.0")));

        double distanceInKiloMeters = distance / 1000;

        log("Distance: $distanceInKiloMeters");

        distanceInKMS = distanceInKiloMeters.toStringAsFixed(1) + " kms";

        // if (distance < 500) {
        //   isPickup = false;
        //   update();
        // }
      } else {
        final distance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            double.parse(
                (currentActiveRide?.dropoffAddress?.latitude.toString() ??
                    "0.0")),
            double.parse(
                (currentActiveRide?.dropoffAddress?.longitude.toString() ??
                    "0.0")));

        double distanceInKiloMeters = distance / 1000;

        log("Distance: $distanceInKiloMeters");

        distanceInKMS = "${distanceInKiloMeters.toStringAsFixed(1)} kms";
      }

      mapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(currentPosition!.latitude, currentPosition!.longitude)));

      initMarker(l: LatLng(position.latitude, position.longitude));

      if (getPolyPpoints) {
        if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
        debounceTimer = Timer(const Duration(seconds: 3), () {
          // polylines.clear();
          // polylineCoordinates.clear();
          createPolyLines();
        });
      }
    });
  }

  void closeStream() {
    isPickup = true;
    streamSubscription?.cancel();
    polylines.clear();
    polylineCoordinates.clear();
    markers.clear();
  }

  Future<void> cancelBooking(
    context, {
    required Function onSuccess,
    required String cancelReason,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, String> jsonData = {
      "status": "cancel",
      "reason": cancelReason,
    };

    log(jsonData.toString());
    var res = await b.basePutApi(
        '${APIEndpoints.trips}/${tripDataModel?.id}', jsonData,
        loading: true, context: context);

    if (res['success'] == true) {
      if (res['data'] != null) {
        CustomToast()
            .showToast('Success', 'Trip Cancelled Successfully', false);
        // setTripNull();
        closeStream();
        onSuccess();
      }
    } else {
      CustomToast().showToast("Error", res['message'], true);
    }
  }
}
