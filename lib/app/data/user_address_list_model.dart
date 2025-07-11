import 'dart:convert';

UserAddressListModel userAddressListModelFromJson(String str) => UserAddressListModel.fromJson(json.decode(str));

String userAddressListModelToJson(UserAddressListModel data) => json.encode(data.toJson());

class UserAddressListModel {
  bool? status;
  UserAddreesListData? data;
  String? message;

  UserAddressListModel({
    this.status,
    this.data,
    this.message,
  });

  factory UserAddressListModel.fromJson(Map<String, dynamic> json) => UserAddressListModel(
    status: json["status"],
    data: json["data"] == null ? null : UserAddreesListData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class UserAddreesListData {
  String? id;
  bool? isRegister;
  String? role;
  bool? pinkMode;
  String? fullName;
  String? phone;
  dynamic email;
  String? city;
  ProfilePic? profilePic;
  dynamic idPic;
  dynamic dob;
  String? gender;
  bool? isDriver;
  String? referralCode;
  bool? profileStatus;
  bool? vehicleStatus;
  String? status;
  RideCancellationDetails? rideCancellationDetails;
  int? wallet;
  String? connectedAccountId;
  int? rating;
  int? totalRides;
  bool? isRecurringTripEnabled;
  NotificationPreferences? notificationPreferences;
  String? firebaseUid;
  String? firebaseSignInProvider;
  dynamic stripeAccountId;
  List<FriendAddress>? friendAddresses;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<dynamic>? vehicleDetails;
  List<dynamic>? emergencyContactDetails;

  UserAddreesListData({
    this.id,
    this.isRegister,
    this.role,
    this.pinkMode,
    this.fullName,
    this.phone,
    this.email,
    this.city,
    this.profilePic,
    this.idPic,
    this.dob,
    this.gender,
    this.isDriver,
    this.referralCode,
    this.profileStatus,
    this.vehicleStatus,
    this.status,
    this.rideCancellationDetails,
    this.wallet,
    this.connectedAccountId,
    this.rating,
    this.totalRides,
    this.isRecurringTripEnabled,
    this.notificationPreferences,
    this.firebaseUid,
    this.firebaseSignInProvider,
    this.stripeAccountId,
    this.friendAddresses,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.vehicleDetails,
    this.emergencyContactDetails,
  });

  factory UserAddreesListData.fromJson(Map<String, dynamic> json) => UserAddreesListData(
    id: json["_id"],
    isRegister: json["isRegister"],
    role: json["role"],
    pinkMode: json["pinkMode"],
    fullName: json["fullName"],
    phone: json["phone"],
    email: json["email"],
    city: json["city"],
    profilePic: json["profilePic"] == null ? null : ProfilePic.fromJson(json["profilePic"]),
    idPic: json["idPic"],
    dob: json["dob"],
    gender: json["gender"],
    isDriver: json["isDriver"],
    referralCode: json["referralCode"],
    profileStatus: json["profileStatus"],
    vehicleStatus: json["vehicleStatus"],
    status: json["status"],
    rideCancellationDetails: json["rideCancellationDetails"] == null ? null : RideCancellationDetails.fromJson(json["rideCancellationDetails"]),
    wallet: json["wallet"],
    connectedAccountId: json["connected_account_id"],
    rating: json["rating"],
    totalRides: json["totalRides"],
    isRecurringTripEnabled: json["isRecurringTripEnabled"],
    notificationPreferences: json["notificationPreferences"] == null ? null : NotificationPreferences.fromJson(json["notificationPreferences"]),
    firebaseUid: json["firebaseUid"],
    firebaseSignInProvider: json["firebaseSignInProvider"],
    stripeAccountId: json["stripeAccountId"],
    friendAddresses: json["friendAddresses"] == null ? [] : List<FriendAddress>.from(json["friendAddresses"]!.map((x) => FriendAddress.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    vehicleDetails: json["vehicleDetails"] == null ? [] : List<dynamic>.from(json["vehicleDetails"]!.map((x) => x)),
    emergencyContactDetails: json["emergencyContactDetails"] == null ? [] : List<dynamic>.from(json["emergencyContactDetails"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isRegister": isRegister,
    "role": role,
    "pinkMode": pinkMode,
    "fullName": fullName,
    "phone": phone,
    "email": email,
    "city": city,
    "profilePic": profilePic?.toJson(),
    "idPic": idPic,
    "dob": dob,
    "gender": gender,
    "isDriver": isDriver,
    "referralCode": referralCode,
    "profileStatus": profileStatus,
    "vehicleStatus": vehicleStatus,
    "status": status,
    "rideCancellationDetails": rideCancellationDetails?.toJson(),
    "wallet": wallet,
    "connected_account_id": connectedAccountId,
    "rating": rating,
    "totalRides": totalRides,
    "isRecurringTripEnabled": isRecurringTripEnabled,
    "notificationPreferences": notificationPreferences?.toJson(),
    "firebaseUid": firebaseUid,
    "firebaseSignInProvider": firebaseSignInProvider,
    "stripeAccountId": stripeAccountId,
    "friendAddresses": friendAddresses == null ? [] : List<dynamic>.from(friendAddresses!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "vehicleDetails": vehicleDetails == null ? [] : List<dynamic>.from(vehicleDetails!.map((x) => x)),
    "emergencyContactDetails": emergencyContactDetails == null ? [] : List<dynamic>.from(emergencyContactDetails!.map((x) => x)),
  };
}

class FriendAddress {
  String? name;
  String? type;
  List<double>? coordinates;
  bool? isActive;
  String? id;

  FriendAddress({
    this.name,
    this.type,
    this.coordinates,
    this.isActive,
    this.id,
  });

  factory FriendAddress.fromJson(Map<String, dynamic> json) => FriendAddress(
    name: json["name"],
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    isActive: json["isActive"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "isActive": isActive,
    "_id": id,
  };
}

class NotificationPreferences {
  bool? trip;
  bool? alerts;
  bool? payments;
  bool? transactions;
  bool? offers;

  NotificationPreferences({
    this.trip,
    this.alerts,
    this.payments,
    this.transactions,
    this.offers,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) => NotificationPreferences(
    trip: json["trip"],
    alerts: json["alerts"],
    payments: json["payments"],
    transactions: json["transactions"],
    offers: json["offers"],
  );

  Map<String, dynamic> toJson() => {
    "trip": trip,
    "alerts": alerts,
    "payments": payments,
    "transactions": transactions,
    "offers": offers,
  };
}

class ProfilePic {
  String? key;
  String? url;

  ProfilePic({
    this.key,
    this.url,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
    key: json["key"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "url": url,
  };
}

class RideCancellationDetails {
  SuspensionDetails? suspensionDetails;
  int? count;

  RideCancellationDetails({
    this.suspensionDetails,
    this.count,
  });

  factory RideCancellationDetails.fromJson(Map<String, dynamic> json) => RideCancellationDetails(
    suspensionDetails: json["suspensionDetails"] == null ? null : SuspensionDetails.fromJson(json["suspensionDetails"]),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "suspensionDetails": suspensionDetails?.toJson(),
    "count": count,
  };
}

class SuspensionDetails {
  String? cancelPolicy;

  SuspensionDetails({
    this.cancelPolicy,
  });

  factory SuspensionDetails.fromJson(Map<String, dynamic> json) => SuspensionDetails(
    cancelPolicy: json["cancelPolicy"],
  );

  Map<String, dynamic> toJson() => {
    "cancelPolicy": cancelPolicy,
  };
}
