class APIEndpoints {
  ///Local Server URL
  static const baseURL = "https://drivy.lottawins.app/api/";
  static const baseImageURL = "";

  ///Local Server Socket URL
  static const socketBaseURL = "https://host2.appsstaging.com:3024/";

  static const user = "user/";
  static const driver = "driver/";
  static const login = "${user}login";
  static const signUp = "${user}register";
  static const forgotPassword = "forgot/password";
  static const verifyOtp = "confirm/otp";
  static const resetPassword = "reset/password";
  static const sendUserOtp = "${user}verify/sent/otp";
  static const verifyPhoneOtp = "${user}verify/validate/otp";
  static const editProfile = "${user}updateprofile";
  static const logout = "${user}logout";

  static const rides = "${driver}rides";
  static const ride = "${driver}ride";

  static const resendOTP = "resend-code";
  static const completeProfile = "complete-profile";
  static const socialLogin = "socialLogin";
  static const dashboard = "dashboard-data";
  static const addCard = "add-card";
  static const allCards = "cards";
  static const setCardDefault = "default-card";
  static const deleteCard = "deleteCard/";
  static const followUnfollow = "follow-unfollow/";
  static const merchantAccount = "merchant-account-setup";
  static const followers = "followers-list/";
  static const following = "following-list/";
  static const categories = "categories-list";
  static const deleteAccount = "delete-profile/";
  static const myProducts = "my-products";
  static const addProduct = "add-product";
  static const updateProduct = "update-product";
  static const deleteProduct = "delete-product/";
  static const getProductDetail = "product-details/";
  static const content = "content/";
  // static const profileDetails = "profile-details/";
  static const profileDetails = "view-profile/";
  static const addRemoveFavorite = "favourite-product/";
  static const product = "products-list";
  static const wishlist = "favourite-products-list";
  static const checkout = "add-order";
  static const myOrders = "my-orders";
  static const orderHistory = "orders-history";
  static const ordersDetails = "orders-details/";
  static const orderStatus = "update-order-status";
  static const addReview = "add-review";
  static const deleteReview = "delete-review/";
  static const productReviews = "product-review-list/";
  static const addUserReview = "add-user-review";
  static const deleteUserReview = "delete-user-review/";
  static const userReviews = "user-reviews/";
  static const myEarnings = "my-earnings";
  static const influencers = "influencers-list";
  static const addSchedule = "add-schedule";
  static const getSchedule = "influencers-schedule";
  static const deleteSchedule = "delete-schedule/";
  static const sellerProducts = "seller-products/";
  static const sendContract = "send-contract";
  static const getNotifications = "app-notification";
  static const onOffNotifications = "notification";
  static const chatList = "chat-list";
  static const contractHistoryInfluencer = "influencer-contract-history/";
  static const contractHistorySeller = "seller-contract-history/";
  static const acceptRejectContract = "accept-reject-request";
  static const sendImage = "send-image";
  static const startStreaming = "startStreaming";
  static const endStreaming = "endStreaming";
  static const joinToken = "joinToken";
  static const streams = "streaming-list";
  static const sendInvite = "send-invite";
  static const streamInvites = "streaming-invites-list";
  static const rejectInvite = "reject-invite/";
  static const cancelInvite = "cancel-invite/";
  static const streamInfluencers = "available-streaming-influencers";
  static const streamProducts = "request_id";
  static const streamViewers = "viewers-list/";
  static const saveStream = "save-recording";
  static const savedStreaming = "saved-streamings";
  static const streamingComments = "get_comments";

  // /api/streaming-comments/:room_id

  static const getMessages = "get_messages";
  static const sendMessage = "send_message";
  static const response = "response";
  static const error = "error";
  static const joinStreamSocket = "join_stream";
  static const addProductSocket = "add_product";
  static const endStream = "end_stream";
  static const leaveStreamSocket = "leave_stream";
  static const commentSocket = "comment_stream";
  static const deleteCommentSocket = "delete_comment";
  static const getComments = "get_comments";
  static const removeUser = "remove_user";
  static const stripeKey =
      "pk_test_51H0UoCJELxddsoRYqANwUqQLd24vQYATeVTsN7Sm1xnAD68ARNm6bK0vsdCSqisOhSMNCATShUvDmXdzeyW0Cezz00RbGzoMup";
}
