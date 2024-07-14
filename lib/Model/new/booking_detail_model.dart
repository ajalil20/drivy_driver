class TripDataModel {
  int? id;
  int? userId;
  int? driverId;
  int? carId;
  int? pickupId;
  int? dropoffId;
  dynamic promocodeId;
  String? tripType;
  int? amount;
  String? status;
  String? driverStatus;
  String? paymentStatus;
  String? bookingType;
  dynamic totalRideTime;
  dynamic pmType;
  String? scheduleDatetime;
  dynamic hours;
  String? instruction;
  dynamic reason;
  dynamic startAt;
  dynamic completedAt;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? pickupAddress;
  dynamic availPromocode;
  String? dropoffAddress;

  TripDataModel(
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
      this.dropoffAddress});

  TripDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    carId = json['car_id'];
    pickupId = json['pickup_id'];
    dropoffId = json['dropoff_id'];
    promocodeId = json['promocode_id'];
    tripType = json['trip_type'];
    amount = json['amount'];
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
    pickupAddress = json['pickup_address'];
    availPromocode = json['avail_promocode'];
    dropoffAddress = json['dropoff_address'];
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
    data['payment_status'] = paymentStatus;
    data['booking_type'] = bookingType;
    data['total_ride_time'] = totalRideTime;
    data['pm_type'] = pmType;
    data['schedule_datetime'] = scheduleDatetime;
    data['hours'] = hours;
    data['instruction'] = instruction;
    data['reason'] = reason;
    data['start_at'] = startAt;
    data['completed_at'] = completedAt;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pickup_address'] = pickupAddress;
    data['avail_promocode'] = availPromocode;
    data['dropoff_address'] = dropoffAddress;
    return data;
  }
}
