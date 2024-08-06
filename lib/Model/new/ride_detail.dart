import 'package:drivy_driver/Model/user_model.dart';

class RideDetailData {
  int? id;
  int? userId;
  int? driverId;
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
  String? pmType;
  String? mainType;
  dynamic scheduleDatetime;
  dynamic hours;
  dynamic instruction;
  dynamic reason;
  dynamic startAt;
  dynamic completedAt;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  double? platformFee;
  double? subTotal;
  dynamic schduleTime;
  dynamic arrivalTime;
  dynamic departureTime;
  dynamic serviceType;
  PickupAddress? pickupAddress;
  dynamic availPromocode;
  PickupAddress? dropoffAddress;
  dynamic carDetails;
  Car? car;
  User? user;
  User? chaufferDetails;
  dynamic paymentDetails;

  RideDetailData(
      {this.id,
      this.userId,
      this.driverId,
      this.carId,
      this.pickupId,
      this.dropoffId,
      this.mainType,
      this.promocodeId,
      this.chaufferDetails,
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
      this.platformFee,
      this.subTotal,
      this.schduleTime,
      this.arrivalTime,
      this.departureTime,
      this.serviceType,
      this.pickupAddress,
      this.availPromocode,
      this.dropoffAddress,
      this.carDetails,
      this.car,
      this.user,
      this.paymentDetails});

  RideDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    carId = json['car_id'];
    pickupId = json['pickup_id'];
    dropoffId = json['dropoff_id'];
    promocodeId = json['promocode_id'];
    tripType = json['trip_type'];
    amount =
        json['amount'] != null ? double.parse(json['amount'].toString()) : 0;
    status = json['status'];
    driverStatus = json['driver_status'];
    paymentStatus = json['payment_status'];
    bookingType = json['booking_type'];
    totalRideTime = json['total_ride_time'];
    pmType = json['pm_type'];
    scheduleDatetime = json['schedule_datetime'];
    chaufferDetails = json['chauffeur_details'] != null
        ? User.fromJson(json['chauffeur_details'])
        : null;
    hours = json['hours'];
    instruction = json['instruction'];
    reason = json['reason'];
    mainType = json['main_type'] ?? "chaufiuer";
    startAt = json['start_at'];
    completedAt = json['completed_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    platformFee = json['platform_fee'] != null
        ? double.parse(json['platform_fee'].toString())
        : 0;
    subTotal = json['sub_total'] != null
        ? double.parse(json['sub_total'].toString())
        : 0;
    schduleTime = json['schdule_time'];
    arrivalTime = json['arrival_time'];
    departureTime = json['departure_time'];
    serviceType = json['service_type'];
    pickupAddress = json['pickup_address'] != null
        ? PickupAddress.fromJson(json['pickup_address'])
        : null;
    availPromocode = json['avail_promocode'];
    dropoffAddress = json['dropoff_address'] != null
        ? PickupAddress.fromJson(json['dropoff_address'])
        : null;
    carDetails = json['car_details'];
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    paymentDetails = json['payment_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['driver_id'] = driverId;
    data['car_id'] = carId;
    data['pickup_id'] = pickupId;
    data['dropoff_id'] = dropoffId;
    data['promocode_id'] = promocodeId;
    data['trip_type'] = tripType;
    data['amount'] = amount;
    data['status'] = status;
    data['driver_status'] = driverStatus;
    data['chauffeur_details'] = chaufferDetails?.toJson();
    data['payment_status'] = paymentStatus;
    data['booking_type'] = bookingType;
    data['total_ride_time'] = totalRideTime;
    data['pm_type'] = pmType;
    data['schedule_datetime'] = scheduleDatetime;
    data['hours'] = hours;
    data['instruction'] = instruction;
    data['reason'] = reason;
    data['start_at'] = startAt;
    data['main_type'] = mainType;
    data['completed_at'] = completedAt;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['platform_fee'] = platformFee;
    data['sub_total'] = subTotal;
    data['schdule_time'] = schduleTime;
    data['arrival_time'] = arrivalTime;
    data['departure_time'] = departureTime;
    data['service_type'] = serviceType;
    if (pickupAddress != null) {
      data['pickup_address'] = pickupAddress!.toJson();
    }
    data['avail_promocode'] = availPromocode;
    if (dropoffAddress != null) {
      data['dropoff_address'] = dropoffAddress!.toJson();
    }
    data['car_details'] = carDetails;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['payment_details'] = paymentDetails;
    return data;
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
  dynamic description;
  dynamic address;
  dynamic latitude;
  String? licensePlateNumberImage;
  dynamic longitude;
  dynamic perDayPrice;
  double? maximumDistance;
  String? overDistanceFee;
  String? deliveryFee;
  String? rules;
  String? licensePlateNumber;
  String? vinNumber;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic? vehicleTypeId;
  int? recomended;
  dynamic? avgRating;
  CarBrand? carBrand;
  List<Images>? images;
  List<dynamic>? dailyAvailability;
  User? owner;
  // List<Null>? ratings;
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
      // this.ratings,
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
    perDayPrice = json['per_day_price'];
    maximumDistance = json['maximum_distance'] != null
        ? double.parse(json['maximum_distance'].toString())
        : 0;
    overDistanceFee = json['over_distance_fee'].toString();
    deliveryFee = json['delivery_fee'].toString();
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
    //     dailyAvailability!.add(new Null.fromJson(v));
    //   });
    // }
    owner = json['owner'] != null ? User.fromJson(json['owner']) : null;
    // if (json['ratings'] != null) {
    //   ratings = <Null>[];
    //   json['ratings'].forEach((v) {
    //     ratings!.add(new Null.fromJson(v));
    //   });
    // }
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['brand_id'] = brandId;
    data['car_model_year'] = carModelYear;
    data['car_drive'] = carDrive;
    data['car_seats'] = carSeats;
    data['car_fuel'] = carFuel;
    data['description'] = description;
    data['address'] = address;
    data['latitude'] = latitude;
    data['license_plate_number_image'] = licensePlateNumberImage;
    data['longitude'] = longitude;
    data['per_day_price'] = perDayPrice;
    data['maximum_distance'] = maximumDistance;
    data['over_distance_fee'] = overDistanceFee;
    data['delivery_fee'] = deliveryFee;
    data['rules'] = rules;
    data['license_plate_number'] = licensePlateNumber;
    data['vin_number'] = vinNumber;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['vehicle_type_id'] = vehicleTypeId;
    data['recomended'] = recomended;
    data['avg_rating'] = avgRating;
    if (carBrand != null) {
      data['car_brand'] = carBrand!.toJson();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    // if (dailyAvailability != null) {
    //   data['daily_availability'] =
    //       dailyAvailability!.map((v) => v.toJson()).toList();
    // }
    // if (owner != null) {
    //   data['owner'] = owner!.toJson();
    // }
    // if (ratings != null) {
    //   data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    // }
    data['is_favorite'] = isFavorite;
    return data;
  }
}

class CarBrand {
  int? id;
  String? brandName;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic brandImage;

  CarBrand(
      {this.id,
      this.brandName,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.brandImage});

  CarBrand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    status = json['status'];
    createdAt = json['created_at'];
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
