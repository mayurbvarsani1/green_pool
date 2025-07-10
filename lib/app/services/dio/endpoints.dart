import 'dart:io';

import '../../../app_environment.dart';

class Endpoints {
  Endpoints._();

  //TODO: update in android manifest too if any changes
  static String googleApiKey = Platform.isAndroid
      ? 'AIzaSyAs_QL4LPuvaU23w-t0wOUJyUziRmSIlkE'
      : 'AIzaSyBq5jpn2f8NAb4pb562ejP2YCg47uX1_nU';

  static const String googleAutocompleteApiUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const String googlePlaceApiUrl =
      'https://maps.googleapis.com/maps/api/place';

  // base url
  static String baseUrl = AppEnvironment.baseApiUrl;

  static String success_url =
      "http://api.greenpool.ca/v1/payment/paymentSuccess";
  static String cancel_url =
      "http://api.greenpool.ca/v1/payment/paymentCancelled";

  // receiveTimeout
  static const int receiveTimeout = 150000;

  // connectTimeout
  static const int connectionTimeout = 150000;
  static const canadaLat = 56.1304;
  static const canadaLong = 106.3468;

  //post url
  static const String register = "auth/register";
  static const String vehicleDetails = "driver/vehicledetails";
  static const String bugReport = "company/appBugReportByUser";
  static const String fileDispute = "fileDispute";
  static const String driverPostRide = "driver/ride";
  static const String riderFindRide = "rider/ride";
  static const String riderCreateAlert = "rider/createAlert";
  static const String sendRequestToRider =
      "driver/sendRequestToRider"; // to send request to riders from Send Requests view
  static const String sendRequestToDriver = "rider/sendReuestToDriver";
  static const String rateAnyUser = "user/ratingByUser";
  static const String studentDiscount = "email/send";
  static const String addAmount = "payment/addAmount";
  static const String appRating = "app/ratingByUser";
  static const String userSupportSendMessage = "userSupport/user";
  static const String userSupportFirstMessage = "userSupport/welComeMessage";
  static const String authorizeStripeToken = "payment/autherizeStripeToken";
  static const String transferAmountToWallet = "payment/transferAmountToWallet";
  static String stripeBankUrl =
      "https://connect.stripe.com/oauth/v2/authorize?response_type=code&client_id=ca_PdUqFXZWXjitnEqUgtSHiHKEWonW8gWJ&scope=read_write&redirect_uri=${baseUrl}payment/stripe/callback";
  static const String createStripeAccount = "stripe/accounts";
  static const String stripeOnboarding = "stripe/accounts/onboard";
  static const String transferWalletBalance =
      "stripe/accounts/transfer-wallet-balance";
  static const String riderCancelReq = "rider/cancelRequest";
  static const String riderDeleteRide = "rider/cancelAllRide";

  //get url
  static const String userLogin = "auth/login";
  static const String userByID = "user";
  static const String getChatRoomId = "chat/getChatRoomId?receiverId=";
  static const String getChatList = "chat/chatRoomIds";
  static const String sendMessage = "chat";
  static const String searchSchools = "schools/searchByName/";
  static const String emergencyContacts = "user/emergencyContacts";
  static const String driverMyRides = "driver/myrides";
  static const String driverMyRidesDetails = "user/bookingDetails/";
  static const String allRecurringRides = "driver/recurringRides";
  static const String recurringRideDetails = "driver/recurringRides/";
  static const String rideHistory = "rider/rideHistory";
  static const String fileDisputeRides = "rider/fileDispute";
  static const String findMatchingDrivers =
      "rider/matchingDrivers"; // to get matching rides according to the Find ride data
  static const String riderAllSendRequests = 'rider/matchingDrivers?rideId=';
  static const String allDriverSendRequests =
      "driver/matchingRiders/"; // to get riders in send request column
  static const String allDriverConfirmRequests =
      "driver/riderSendRequests/"; // to get all the requests that riders have sent to driver
  static const String acceptRidersRequest =
      "driver/acceptRiderRequest"; // to accept the riders request from Confirm Request View
  static const String rejectRidersRequest =
      "driver/rejectRiderRequest"; // to reject the riders request from Confirm Request View
  static const String viewDriversRequest =
      "rider/driverSendRequests/"; // to view the drivers request from Confirm Request View
  static const String companyDetails = "company/companyDetails";
  static const String rideFare = "admin/fare/";
  static const String privacyPolicy = "admin/app/privacyPolicy";
  static const String guideLines = "admin/app/guideLines/web";
  static const String cancelAndRefundPolicy =
      "admin/cancelAndRefundPolicy/driver";
  static const String walletBalance = "payment/walletBalance";
  static const String transactions = "payment/transactions";
  static const String notifications = "user/notifications";
  static const String helpAndSupport = "company/helpAndSupport";
  static const String aboutUs = "admin/app/aboutUs";
  static const String promoCode = "admin/promoCode/web";
  static const String checkForPayBtn = "driver/riderCheck/";
  static const String getRideDetail = "driver/ride/";
  static const String verifyPromo = "admin/promoCode/search?search=";
  static const String unreadCount = "driver/rides/unreadCount";
  static const String allArchivedChats = "chat/archivedChats";
  static const String driverHistory = "driver/driverHistory/";
  static const String prevPostedRides = "driver/rides/recent";

  //patch url
  static const String emergencyContactsUpdate = "user/emergencyContacts";
  static const String userDetails = "user/updateProfileDetails";
  static const String acceptDriversRequest = "rider/acceptDriverRequest";
  static const String rejectDriversRequest = "rider/rejectDriverRequest";
  static const String startRide = "driver/startRideByDriver";
  static const String endRide = "driver/endRideByDriver";
  static const String pickUpRider = "rider/pickUpRider";
  static const String dropOffRider = "rider/dropOffRider";
  static const String pinkMode = "user/updatePinkMode";
  static const String notificationPreferences =
      "user/updateNotificationPreferences";
  static const String cancelRide = "driver/cancelRideByMyRides";
  static const String riderCancelRide = "rider/cancelRideByMyRides";
  static String googleBaseUrl = "https://maps.googleapis.com/maps/api/";
  static const String getArrivalTime = "directions/json?origin=";
  static const String enableOrDisableRecurring =
      "driver/recurringRides?driverRideId=";
  static const String addPromoCode = "rider/ride/promoCode";
  static const String archiveMsg = "chat/archive/";
  static const String unarchiveMsg = "chat/unarchive/";

  //delete url
  static const String deleteChat = "chat/deleteChat";
  static const String deleteAccount = "/user";

  //put url
  static const String editRide = "driver/rides/";


  /// TODO: group carpooll api

  static const String getEventListApi = "event/";     //get post get
  static const String jointEventApi = "event/join"; // post
  static const String sendChatApi = "chat/group-chat"; // post
  static const String getChatListApi = "chat?chatRoomId"; // get
  static const String deleteGroupChatApi = "chat/delete-event-message"; // Post
  static const String getGroupChatRoomApi = "chat/group-chat-room"; // get


  static const String addReport = "report"; // Post
  static const String getReportList = "report"; // Get
  static const String userBlock = "block"; // Post
  static const String getBlockList = "block?page=1&limit=10"; // Get
  static const String createAddress = "user/createAddress"; // Post
  static const String getCreateAddress = "user"; // Get




}