
class User {
  String id='';
  String email='';
  String firstName='';
  String lastName='';
  String fullName='';
  dynamic userImage;
  String countryCode='US';
  String dialCode='1';
  dynamic phoneNumber;
  dynamic avgRating;
  String dob='';
  String userAuthentication='';
  String requestId='';
  String requestStatus='';
  int? isVerified;
  int? userIsProfileComplete;
  bool? isNotification;
  int? userIsForgot;
  dynamic userSocialType;
  dynamic userSocialToken;
  String? userDeviceType;
  String? userDeviceToken;
  String? createdAt;
  String? updatedAt;
  int? v;
  dynamic emirateId;
  String? currentMode;
  String? type;
  String? status;
  String? notification;
  String? nightMode;
  String country='';
  dynamic socialType;
  dynamic socialToken;
  dynamic stripeId;
  dynamic pmType;
  dynamic pmLastFour;
  dynamic trialEndsAt;
  String? token;
  dynamic emirateFront;
  dynamic emirateBack;
  List<dynamic>? license;
  dynamic licenseFrontImage;
  dynamic licenseBackImage;
  dynamic emirateFrontImage;
  dynamic emirateBackImage;
  dynamic registrationCardImage;
  bool? membership;
  dynamic address;

  User({
    this.id='',
    this.email='',
    this.firstName='',
    this.lastName='',
    this.userImage,
    this.avgRating,
    this.countryCode='US',
    this.dialCode='1',
    this.phoneNumber,
    this.dob='',
    this.requestId='',
    this.requestStatus='',
    this.fullName='',
    this.userAuthentication='',
    this.isVerified,
    this.userIsProfileComplete,
    this.isNotification,
    this.userIsForgot,
    this.userSocialType,
    this.userSocialToken,
    this.userDeviceType,
    this.userDeviceToken,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.emirateId,
    this.currentMode,
    this.type,
    this.status,
    this.notification,
    this.nightMode,
    this.country='',
    this.socialType,
    this.socialToken,
    this.stripeId,
    this.pmType,
    this.pmLastFour,
    this.trialEndsAt,
    this.token,
    this.emirateFront,
    this.emirateBack,
    this.license,
    this.licenseFrontImage,
    this.licenseBackImage,
    this.emirateFrontImage,
    this.emirateBackImage,
    this.registrationCardImage,
    this.membership,
    this.address,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString() ??'';
    email = json['email']??'';
    firstName = json['first_name']??'';
    lastName = json['last_name']??'';
    fullName='$firstName $lastName';
    requestId = json['request_id']??'';
    requestStatus = json['request_status']??'';
    userImage = json['profile_image'];
    countryCode = json['country_code']??'US';
    dialCode = json['dial_code']??'1';
    phoneNumber = json['phone'];
    avgRating = json['avg_rating'];
    dob = json['dateOfBirth']??'';
    userAuthentication = json['user_authentication']??'';
    isVerified = json['is_verified'] as int?;
    userIsProfileComplete = json['user_is_profile_complete'] as int?;
    isNotification = json['is_notification'] as bool?;
    userIsForgot = json['user_is_forgot'] as int?;
    userSocialType = json['user_social_type'];
    userSocialToken = json['user_social_token'];
    userDeviceType = json['user_device_type'] as String?;
    userDeviceToken = json['device_token'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
    // fullName=firstName+lastName;
    emirateId = json['emirate_id'];
    currentMode = json['current_mode'] as String?;
    type = json['type'] as String?;
    status = json['status'] as String?;
    notification = json['notification'] as String?;
    nightMode = json['night_mode'] as String?;
    country = json['country']??'';
    socialType = json['social_type'];
    socialToken = json['social_token'];
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    stripeId = json['stripe_id'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    trialEndsAt = json['trial_ends_at'];
    token = json['token'] as String?;
    emirateFront = json['emirate_front'];
    emirateBack = json['emirate_back'];
    license = json['license'] as List?;
    licenseFrontImage = json['license_front_image'];
    licenseBackImage = json['license_back_image'];
    emirateFrontImage = json['emirate_front_image'];
    emirateBackImage = json['emirate_back_image'];
    registrationCardImage = json['registration_card_image'];
    membership = json['membership'] as bool?;
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['email'] = email;
    json['first_name'] = firstName;
    json['last_name'] = lastName;
    json['profile_image'] = userImage;
    json['country_code'] = countryCode;
    json['dial_code'] = dialCode;
    json['phone'] = phoneNumber;
    json['dateOfBirth'] = dob;
    json['request_status'] = requestStatus;
    json['request_id'] = requestId;
    json['avg_rating'] = avgRating;
    json['user_authentication'] = userAuthentication;
    json['is_verified'] = isVerified;
    json['user_is_profile_complete'] = userIsProfileComplete;
    json['is_notification'] = isNotification;
    json['user_is_forgot'] = userIsForgot;
    json['user_social_type'] = userSocialType;
    json['user_social_token'] = userSocialToken;
    json['user_device_type'] = userDeviceType;
    json['device_token'] = userDeviceToken;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    json['emirate_id'] = emirateId;
    json['current_mode'] = currentMode;
    json['type'] = type;
    json['status'] = status;
    json['notification'] = notification;
    json['night_mode'] = nightMode;
    json['country'] = country;
    json['social_type'] = socialType;
    json['social_token'] = socialToken;
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    json['stripe_id'] = stripeId;
    json['pm_type'] = pmType;
    json['pm_last_four'] = pmLastFour;
    json['trial_ends_at'] = trialEndsAt;
    json['token'] = token;
    json['emirate_front'] = emirateFront;
    json['emirate_back'] = emirateBack;
    json['license'] = license;
    json['license_front_image'] = licenseFrontImage;
    json['license_back_image'] = licenseBackImage;
    json['full_name'] = fullName;
    json['emirate_front_image'] = emirateFrontImage;
    json['emirate_back_image'] = emirateBackImage;
    json['registration_card_image'] = registrationCardImage;
    json['membership'] = membership;
    json['address'] = address;
    return json;
  }
}