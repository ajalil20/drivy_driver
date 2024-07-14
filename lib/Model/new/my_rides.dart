import 'package:drivy_driver/Model/new/rides.dart';
import 'package:drivy_driver/Model/user_model.dart';

class MyRideListData {
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
  dynamic pmType;
  dynamic scheduleDatetime;
  dynamic hours;
  dynamic instruction;
  dynamic reason;
  dynamic startAt;
  dynamic completedAt;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  PickupAddress? pickupAddress;
  dynamic availPromocode;
  PickupAddress? dropoffAddress;
  Car? car;
  User? user;
  dynamic paymentDetails;

  MyRideListData(
      {this.id,
      this.userId,
      this.driverId,
      this.carId,
      this.pickupId,
      this.dropoffId,
      this.promocodeId,
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
      this.user,
      this.paymentDetails});

  MyRideListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    carId = json['car_id'];
    pickupId = json['pickup_id'];
    dropoffId = json['dropoff_id'];
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
    paymentDetails = json['payment_details'];
  }
}
