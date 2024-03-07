
class User {
  String id='';
  String email='';
  String firstName='';
  String lastName='';
  String fullName='';
  // String fullName='';
  int followers=0;
  int following=0;
  int isFollowing=0;
  int isReviewed=0;
  dynamic userImage;
  String countryCode='US';
  String dialCode='1';
  dynamic phoneNumber;
  dynamic avgRating;
  String dob='';
  Location? location;
  SocialLinks? socialLinks;
  String role='';
  String userAuthentication='';
  String requestId='';
  String requestStatus='';
  int? isVerified;
  int? userIsProfileComplete;
  bool? isNotification;
  int? userIsForgot;
  dynamic userSocialType;
  dynamic userSocialToken;
  int totalReviews=0;
  int contractRequested=0;
  int isInvited=0;
  int isJoined=0;
  String? userDeviceType;
  String? userDeviceToken;
  String? createdAt;
  String? updatedAt;
  int? v;

  User({
    this.id='',
    this.email='',
    this.firstName='',
    this.lastName='',
    // this.fullName='',
    this.followers=0,
    this.following=0,
    this.contractRequested=0,
    this.isFollowing=0,
    this.isReviewed=0,
    this.isInvited=0,
    this.userImage,
    this.avgRating,
    this.countryCode='US',
    this.dialCode='1',
    this.phoneNumber,
    this.dob='',
    this.requestId='',
    this.requestStatus='',
    this.location,
    this.totalReviews=0,
    this.isJoined=0,
    this.socialLinks,
    this.role='',
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
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    email = json['email']??'';
    firstName = json['first_name']??'';
    lastName = json['last_name']??'';
    fullName='$firstName $lastName';
    requestId = json['request_id']??'';
    requestStatus = json['request_status']??'';
    userImage = json['user_image'];
    countryCode = json['country_code']??'US';
    dialCode = json['dial_code']??'1';
    phoneNumber = json['phone_number'];
    followers = json['followers_count']??json['follower_count']??0;
    following = json['following_count']??0;
    isFollowing = json['is_following']??0;
    isReviewed = json['is_reviewed']??0;
    totalReviews = json['totalReviews']??0;
    isInvited = json['is_invited']??0;
    isJoined = json['is_joined']??0;
    contractRequested = json['is_contract_requested']??0;
    avgRating = json['avg_rating'];
    dob = json['dob']??'';
    location = (json['location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['location'] as Map<String,dynamic>) : null;
    socialLinks = (json['social_links'] as Map<String,dynamic>?) != null ? SocialLinks.fromJson(json['social_links'] as Map<String,dynamic>) : null;
    role = json['role']??'';
    userAuthentication = json['user_authentication']??'';
    isVerified = json['is_verified'] as int?;
    userIsProfileComplete = json['user_is_profile_complete'] as int?;
    isNotification = json['is_notification'] as bool?;
    userIsForgot = json['user_is_forgot'] as int?;
    userSocialType = json['user_social_type'];
    userSocialToken = json['user_social_token'];
    userDeviceType = json['user_device_type'] as String?;
    userDeviceToken = json['user_device_token'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
    // fullName=firstName+lastName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['email'] = email;
    json['first_name'] = firstName;
    json['last_name'] = lastName;
    json['user_image'] = userImage;
    json['country_code'] = countryCode;
    json['dial_code'] = dialCode;
    json['is_contract_requested'] = contractRequested;
    json['phone_number'] = phoneNumber;
    json['dob'] = dob;
    json['is_invited'] = isInvited;
    json['is_following'] = isFollowing;
    json['is_reviewed'] = isReviewed;
    json['request_status'] = requestStatus;
    json['is_joined'] = isJoined;
    json['request_id'] = requestId;
    json['totalReviews'] = totalReviews;
    json['following_count'] = following;
    json['followers_count'] = followers;
    json['avg_rating'] = avgRating;
    json['location'] = location?.toJson();
    json['social_links'] = socialLinks?.toJson();
    json['role'] = role;
    json['user_authentication'] = userAuthentication;
    json['is_verified'] = isVerified;
    json['user_is_profile_complete'] = userIsProfileComplete;
    json['is_notification'] = isNotification;
    json['user_is_forgot'] = userIsForgot;
    json['user_social_type'] = userSocialType;
    json['user_social_token'] = userSocialToken;
    json['user_device_type'] = userDeviceType;
    json['user_device_token'] = userDeviceToken;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    return json;
  }
}

class Location {
  String? type;
  dynamic address;
  List<dynamic>? coordinates;

  Location({
    this.type,
    this.address,
    this.coordinates,
  });

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    address = json['address'];
    coordinates = (json['coordinates'] as List?)?.map((dynamic e) => e).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['type'] = type;
    json['address'] = address;
    json['coordinates'] = coordinates;
    return json;
  }
}

class SocialLinks {
  dynamic facebook;
  dynamic twitter;
  int instaFollowers=0;
  int twitterFollowers=0;

  SocialLinks({
    this.facebook,
    this.twitter,
    this.twitterFollowers=0,
    this.instaFollowers=0,
  });

  SocialLinks.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instaFollowers = json['no_insta_follower']??0;
    twitterFollowers = json['no_twitter_follower']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['facebook'] = facebook;
    json['twitter'] = twitter;
    json['no_twitter_follower'] = twitterFollowers;
    json['no_insta_follower'] = instaFollowers;
    return json;
  }
}