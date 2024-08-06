import 'package:drivy_driver/Model/user_model.dart';

class RideData {
  int? id;
  int? userId;
  dynamic driverId;
  int? carId;
  int? pickupId;
  int? dropoffId;
  int? promocodeId;
  String? tripType;
  double? amount;
  String? status;
  String? driverStatus;
  String? paymentStatus;
  String? bookingType;
  dynamic totalRideTime;
  dynamic pmType;
  dynamic scheduleDatetime;
  dynamic hours;
  String? instruction;
  dynamic reason;
  dynamic startAt;
  dynamic completedAt;
  String? mainType;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  PickupAddress? pickupAddress;
  dynamic availPromocode;
  PickupAddress? dropoffAddress;
  Car? car;
  User? user;

  RideData(
      {this.id,
      this.userId,
      this.driverId,
      this.carId,
      this.pickupId,
      this.dropoffId,
      this.promocodeId,
      this.mainType,
      this.tripType,
      this.amount,
      this.status,
      this.driverStatus,
      this.paymentStatus,
      this.bookingType,
      this.totalRideTime,
      this.pmType,
      this.scheduleDatetime,
      this.hours,
      this.instruction,
      this.reason,
      this.startAt,
      this.completedAt,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.pickupAddress,
      this.availPromocode,
      this.dropoffAddress,
      this.car,
      this.user});

  RideData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    carId = json['car_id'];
    pickupId = json['pickup_id'];
    dropoffId = json['dropoff_id'];
    mainType = json['main_type'] ?? "chaufiuer";
    promocodeId = json['promocode_id'];
    tripType = json['trip_type'];
    amount =
        json['amount'] != null ? double.parse(json['amount'].toString()) : 0.0;
    status = json['status'];
    driverStatus = json['driver_status'];
    paymentStatus = json['payment_status'];
    bookingType = json['booking_type'];
    totalRideTime = json['total_ride_time'];
    pmType = json['pm_type'];
    scheduleDatetime = json['schedule_datetime'];
    hours = json['hours'];
    instruction = json['instruction'];
    reason = json['reason'];
    startAt = json['start_at'];
    completedAt = json['completed_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pickupAddress = json['pickup_address'] != null
        ? PickupAddress.fromJson(json['pickup_address'])
        : null;
    availPromocode = json['avail_promocode'];
    dropoffAddress = json['dropoff_address'] != null
        ? PickupAddress.fromJson(json['dropoff_address'])
        : null;
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class PickupAddress {
  int? id;
  int? userId;
  String? address;
  String? latitude;
  String? longitude;
  String? type;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic city;

  PickupAddress(
      {this.id,
      this.userId,
      this.address,
      this.latitude,
      this.longitude,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.city});

  PickupAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['city'] = city;
    return data;
  }
}

class Car {
  int? id;
  int? userId;
  int? brandId;
  String? carModelYear;
  String? carDrive;
  String? carSeats;
  String? carFuel;
  String? description;
  String? address;
  dynamic latitude;
  String? licensePlateNumberImage;
  dynamic longitude;
  double? perDayPrice;
  double? maximumDistance;
  String? overDistanceFee;
  String? deliveryFee;
  String? rules;
  String? licensePlateNumber;
  String? vinNumber;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic vehicleTypeId;
  int? recomended;
  dynamic avgRating;
  CarBrand? carBrand;
  List<Images>? images;
  List<dynamic>? dailyAvailability;
  User? owner;
  List<dynamic>? ratings;
  bool? isFavorite;

  Car(
      {this.id,
      this.userId,
      this.brandId,
      this.carModelYear,
      this.carDrive,
      this.carSeats,
      this.carFuel,
      this.description,
      this.address,
      this.latitude,
      this.licensePlateNumberImage,
      this.longitude,
      this.perDayPrice,
      this.maximumDistance,
      this.overDistanceFee,
      this.deliveryFee,
      this.rules,
      this.licensePlateNumber,
      this.vinNumber,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.vehicleTypeId,
      this.recomended,
      this.avgRating,
      this.carBrand,
      this.images,
      this.dailyAvailability,
      this.owner,
      this.ratings,
      this.isFavorite});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    brandId = json['brand_id'];
    carModelYear = json['car_model_year'];
    carDrive = json['car_drive'];
    carSeats = json['car_seats'];
    carFuel = json['car_fuel'];
    description = json['description'];
    address = json['address'];
    latitude = json['latitude'];
    licensePlateNumberImage = json['license_plate_number_image'];
    longitude = json['longitude'];
    // perDayPrice = json['per_day_price'];
    // maximumDistance = json['maximum_distance'];
    overDistanceFee = json['over_distance_fee'];
    deliveryFee = json['delivery_fee'];
    rules = json['rules'];
    licensePlateNumber = json['license_plate_number'];
    vinNumber = json['vin_number'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vehicleTypeId = json['vehicle_type_id'];
    recomended = json['recomended'];
    avgRating = json['avg_rating'];
    carBrand =
        json['car_brand'] != null ? CarBrand.fromJson(json['car_brand']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    // if (json['daily_availability'] != null) {
    //   dailyAvailability = <Null>[];
    //   json['daily_availability'].forEach((v) {
    //     dailyAvailability!.add(v);
    //   });
    // }
    owner = json['owner'] != null ? User.fromJson(json['owner']) : null;
    if (json['ratings'] != null) {
      ratings = <Null>[];
      json['ratings'].forEach((v) {
        ratings!.add(v);
      });
    }
    isFavorite = json['is_favorite'];
  }
}

class CarBrand {
  int? id;
  String? brandName;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic brandImage;
  CarBrand? carBrand;

  CarBrand(
      {this.id,
      this.brandName,
      this.status,
      this.createdAt,
      this.carBrand,
      this.updatedAt,
      this.brandImage});

  CarBrand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    status = json['status'];
    createdAt = json['created_at'];
    carBrand =
        json['car_brand'] != null ? CarBrand.fromJson(json['car_brand']) : null;
    updatedAt = json['updated_at'];
    brandImage = json['brand_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand_name'] = brandName;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['brand_image'] = brandImage;
    data['car_brand'] = carBrand?.toJson();
    return data;
  }
}

class Images {
  String? filePath;

  Images({this.filePath});

  Images.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_path'] = filePath;
    return data;
  }
}
