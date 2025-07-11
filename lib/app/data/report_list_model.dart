// import 'dart:convert';
//
// ReportListModel reportListModelFromJson(String str) => ReportListModel.fromJson(json.decode(str));
//
// String reportListModelToJson(ReportListModel data) => json.encode(data.toJson());
//
// class ReportListModel {
//   bool? status;
//   String? message;
//   ReportListData? data;
//
//   ReportListModel({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory ReportListModel.fromJson(Map<String, dynamic> json) => ReportListModel(
//     status: json["status"],
//     message: json["message"],
//     data: json["data"] == null ? null : ReportListData.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data?.toJson(),
//   };
// }
//
// class ReportListData {
//   List<ReportList>? docs;
//   int? totalDocs;
//   int? limit;
//   int? page;
//   int? totalPages;
//   int? pagingCounter;
//   bool? hasPrevPage;
//   bool? hasNextPage;
//   dynamic prevPage;
//   int? nextPage;
//
//   ReportListData({
//     this.docs,
//     this.totalDocs,
//     this.limit,
//     this.page,
//     this.totalPages,
//     this.pagingCounter,
//     this.hasPrevPage,
//     this.hasNextPage,
//     this.prevPage,
//     this.nextPage,
//   });
//
//   factory ReportListData.fromJson(Map<String, dynamic> json) => ReportListData(
//     docs: json["docs"] == null ? [] : List<ReportList>.from(json["docs"]!.map((x) => ReportList.fromJson(x))),
//     totalDocs: json["totalDocs"],
//     limit: json["limit"],
//     page: json["page"],
//     totalPages: json["totalPages"],
//     pagingCounter: json["pagingCounter"],
//     hasPrevPage: json["hasPrevPage"],
//     hasNextPage: json["hasNextPage"],
//     prevPage: json["prevPage"],
//     nextPage: json["nextPage"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "docs": docs == null ? [] : List<dynamic>.from(docs!.map((x) => x.toJson())),
//     "totalDocs": totalDocs,
//     "limit": limit,
//     "page": page,
//     "totalPages": totalPages,
//     "pagingCounter": pagingCounter,
//     "hasPrevPage": hasPrevPage,
//     "hasNextPage": hasNextPage,
//     "prevPage": prevPage,
//     "nextPage": nextPage,
//   };
// }
//
// class ReportList {
//   String? id;
//   String? rideId;
//   String? createdById;
//   String? reason;
//   String? details;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   ReportList({
//     this.id,
//     this.rideId,
//     this.createdById,
//     this.reason,
//     this.details,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory ReportList.fromJson(Map<String, dynamic> json) => ReportList(
//     id: json["_id"],
//     rideId: json["rideId"],
//     createdById: json["createdById"],
//     reason: json["reason"],
//     details: json["details"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "rideId": rideId,
//     "createdById": createdById,
//     "reason": reason,
//     "details": details,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//   };
// }


// To parse this JSON data, do
//
//     final reportListModel = reportListModelFromJson(jsonString);

import 'dart:convert';

ReportListModel reportListModelFromJson(String str) => ReportListModel.fromJson(json.decode(str));

String reportListModelToJson(ReportListModel data) => json.encode(data.toJson());

class ReportListModel {
  bool? status;
  String? message;
  ReportListData? data;

  ReportListModel({
    this.status,
    this.message,
    this.data,
  });

  factory ReportListModel.fromJson(Map<String, dynamic> json) => ReportListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ReportListData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ReportListData {
  List<ReportDataDocsList>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  ReportListData({
    this.docs,
    this.totalDocs,
    this.limit,
    this.page,
    this.totalPages,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  factory ReportListData.fromJson(Map<String, dynamic> json) => ReportListData(
    docs: json["docs"] == null ? [] : List<ReportDataDocsList>.from(json["docs"]!.map((x) => ReportDataDocsList.fromJson(x))),
    totalDocs: json["totalDocs"],
    limit: json["limit"],
    page: json["page"],
    totalPages: json["totalPages"],
    pagingCounter: json["pagingCounter"],
    hasPrevPage: json["hasPrevPage"],
    hasNextPage: json["hasNextPage"],
    prevPage: json["prevPage"],
    nextPage: json["nextPage"],
  );

  Map<String, dynamic> toJson() => {
    "docs": docs == null ? [] : List<dynamic>.from(docs!.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "limit": limit,
    "page": page,
    "totalPages": totalPages,
    "pagingCounter": pagingCounter,
    "hasPrevPage": hasPrevPage,
    "hasNextPage": hasNextPage,
    "prevPage": prevPage,
    "nextPage": nextPage,
  };
}

class ReportDataDocsList {
  String? id;
  String? rideId;
  String? reason;
  DateTime? createdAt;
  DateTime? updatedAt;
  ReportedId? reportedId;
  CreatedById? createdById;
  Ride? ride;

  ReportDataDocsList({
    this.id,
    this.rideId,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.reportedId,
    this.createdById,
    this.ride,
  });

  factory ReportDataDocsList.fromJson(Map<String, dynamic> json) => ReportDataDocsList(
    id: json["_id"],
    rideId: json["rideId"],
    reason: json["reason"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    reportedId: json["reportedId"] == null ? null : ReportedId.fromJson(json["reportedId"]),
    createdById: json["createdById"] == null ? null : CreatedById.fromJson(json["createdById"]),
    ride: json["ride"] == null ? null : Ride.fromJson(json["ride"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "rideId": rideId,
    "reason": reason,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "reportedId": reportedId?.toJson(),
    "createdById": createdById?.toJson(),
    "ride": ride?.toJson(),
  };
}

class CreatedById {
  String? id;
  bool? isRegister;
  String? role;
  bool? pinkMode;
  String? fullName;
  String? phone;
  dynamic email;
  String? city;
  CreatedByIdProfilePic? profilePic;
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
  List<dynamic>? friendAddresses;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CreatedById({
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
  });

  factory CreatedById.fromJson(Map<String, dynamic> json) => CreatedById(
    id: json["_id"],
    isRegister: json["isRegister"],
    role: json["role"],
    pinkMode: json["pinkMode"],
    fullName: json["fullName"],
    phone: json["phone"],
    email: json["email"],
    city: json["city"],
    profilePic: json["profilePic"] == null ? null : CreatedByIdProfilePic.fromJson(json["profilePic"]),
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
    friendAddresses: json["friendAddresses"] == null ? [] : List<dynamic>.from(json["friendAddresses"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
    "friendAddresses": friendAddresses == null ? [] : List<dynamic>.from(friendAddresses!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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

class CreatedByIdProfilePic {
  String? key;
  String? url;

  CreatedByIdProfilePic({
    this.key,
    this.url,
  });

  factory CreatedByIdProfilePic.fromJson(Map<String, dynamic> json) => CreatedByIdProfilePic(
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

class ReportedId {
  String? id;
  bool? isRegister;
  String? role;
  bool? pinkMode;
  dynamic fullName;
  dynamic phone;
  String? email;
  dynamic city;
  ReportedIdProfilePic? profilePic;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ReportedId({
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
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ReportedId.fromJson(Map<String, dynamic> json) => ReportedId(
    id: json["_id"],
    isRegister: json["isRegister"],
    role: json["role"],
    pinkMode: json["pinkMode"],
    fullName: json["fullName"],
    phone: json["phone"],
    email: json["email"],
    city: json["city"],
    profilePic: json["profilePic"] == null ? null : ReportedIdProfilePic.fromJson(json["profilePic"]),
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ReportedIdProfilePic {
  dynamic key;

  ReportedIdProfilePic({
    this.key,
  });

  factory ReportedIdProfilePic.fromJson(Map<String, dynamic> json) => ReportedIdProfilePic(
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
  };
}

class Ride {
  String? id;
  String? riderId;
  Destination? origin;
  Destination? destination;
  int? price;
  dynamic tripType;
  RecurringTrip? recurringTrip;
  DateTime? date;
  DateTime? time;
  ReturnTrip? returnTrip;
  dynamic arrivalDate;
  dynamic arrivalTime;
  int? seatAvailable;
  Preferences? preferences;
  bool? isStarted;
  bool? isCompleted;
  bool? isCancelled;
  List<dynamic>? riders;
  List<dynamic>? drivers;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Ride({
    this.id,
    this.riderId,
    this.origin,
    this.destination,
    this.price,
    this.tripType,
    this.recurringTrip,
    this.date,
    this.time,
    this.returnTrip,
    this.arrivalDate,
    this.arrivalTime,
    this.seatAvailable,
    this.preferences,
    this.isStarted,
    this.isCompleted,
    this.isCancelled,
    this.riders,
    this.drivers,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
    id: json["_id"],
    riderId: json["riderId"],
    origin: json["origin"] == null ? null : Destination.fromJson(json["origin"]),
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    price: json["price"],
    tripType: json["tripType"],
    recurringTrip: json["recurringTrip"] == null ? null : RecurringTrip.fromJson(json["recurringTrip"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    returnTrip: json["returnTrip"] == null ? null : ReturnTrip.fromJson(json["returnTrip"]),
    arrivalDate: json["arrivalDate"],
    arrivalTime: json["arrivalTime"],
    seatAvailable: json["seatAvailable"],
    preferences: json["preferences"] == null ? null : Preferences.fromJson(json["preferences"]),
    isStarted: json["isStarted"],
    isCompleted: json["isCompleted"],
    isCancelled: json["isCancelled"],
    riders: json["riders"] == null ? [] : List<dynamic>.from(json["riders"]!.map((x) => x)),
    drivers: json["drivers"] == null ? [] : List<dynamic>.from(json["drivers"]!.map((x) => x)),
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "riderId": riderId,
    "origin": origin?.toJson(),
    "destination": destination?.toJson(),
    "price": price,
    "tripType": tripType,
    "recurringTrip": recurringTrip?.toJson(),
    "date": date?.toIso8601String(),
    "time": time?.toIso8601String(),
    "returnTrip": returnTrip?.toJson(),
    "arrivalDate": arrivalDate,
    "arrivalTime": arrivalTime,
    "seatAvailable": seatAvailable,
    "preferences": preferences?.toJson(),
    "isStarted": isStarted,
    "isCompleted": isCompleted,
    "isCancelled": isCancelled,
    "riders": riders == null ? [] : List<dynamic>.from(riders!.map((x) => x)),
    "drivers": drivers == null ? [] : List<dynamic>.from(drivers!.map((x) => x)),
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Destination {
  String? name;
  String? type;
  List<double>? coordinates;
  dynamic originDestinationFair;

  Destination({
    this.name,
    this.type,
    this.coordinates,
    this.originDestinationFair,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    name: json["name"],
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    originDestinationFair: json["originDestinationFair"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "originDestinationFair": originDestinationFair,
  };
}

class Preferences {
  Other? other;
  dynamic luggageType;

  Preferences({
    this.other,
    this.luggageType,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
    other: json["other"] == null ? null : Other.fromJson(json["other"]),
    luggageType: json["luggageType"],
  );

  Map<String, dynamic> toJson() => {
    "other": other?.toJson(),
    "luggageType": luggageType,
  };
}

class Other {
  bool? appreciatesConversation;
  bool? enjoysMusic;
  bool? smokeFree;
  bool? petFriendly;
  bool? winterTires;
  bool? coolingOrHeating;
  bool? babySeat;
  bool? heatedSeats;

  Other({
    this.appreciatesConversation,
    this.enjoysMusic,
    this.smokeFree,
    this.petFriendly,
    this.winterTires,
    this.coolingOrHeating,
    this.babySeat,
    this.heatedSeats,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
    appreciatesConversation: json["AppreciatesConversation"],
    enjoysMusic: json["EnjoysMusic"],
    smokeFree: json["SmokeFree"],
    petFriendly: json["PetFriendly"],
    winterTires: json["WinterTires"],
    coolingOrHeating: json["CoolingOrHeating"],
    babySeat: json["BabySeat"],
    heatedSeats: json["HeatedSeats"],
  );

  Map<String, dynamic> toJson() => {
    "AppreciatesConversation": appreciatesConversation,
    "EnjoysMusic": enjoysMusic,
    "SmokeFree": smokeFree,
    "PetFriendly": petFriendly,
    "WinterTires": winterTires,
    "CoolingOrHeating": coolingOrHeating,
    "BabySeat": babySeat,
    "HeatedSeats": heatedSeats,
  };
}

class RecurringTrip {
  List<dynamic>? recurringTripIds;
  List<dynamic>? recurringTripDays;
  bool? isRecurringTripEnabled;

  RecurringTrip({
    this.recurringTripIds,
    this.recurringTripDays,
    this.isRecurringTripEnabled,
  });

  factory RecurringTrip.fromJson(Map<String, dynamic> json) => RecurringTrip(
    recurringTripIds: json["recurringTripIds"] == null ? [] : List<dynamic>.from(json["recurringTripIds"]!.map((x) => x)),
    recurringTripDays: json["recurringTripDays"] == null ? [] : List<dynamic>.from(json["recurringTripDays"]!.map((x) => x)),
    isRecurringTripEnabled: json["isRecurringTripEnabled"],
  );

  Map<String, dynamic> toJson() => {
    "recurringTripIds": recurringTripIds == null ? [] : List<dynamic>.from(recurringTripIds!.map((x) => x)),
    "recurringTripDays": recurringTripDays == null ? [] : List<dynamic>.from(recurringTripDays!.map((x) => x)),
    "isRecurringTripEnabled": isRecurringTripEnabled,
  };
}

class ReturnTrip {
  dynamic returnTripId;
  bool? isReturnTrip;
  dynamic returnDate;
  dynamic returnTime;

  ReturnTrip({
    this.returnTripId,
    this.isReturnTrip,
    this.returnDate,
    this.returnTime,
  });

  factory ReturnTrip.fromJson(Map<String, dynamic> json) => ReturnTrip(
    returnTripId: json["returnTripId"],
    isReturnTrip: json["isReturnTrip"],
    returnDate: json["returnDate"],
    returnTime: json["returnTime"],
  );

  Map<String, dynamic> toJson() => {
    "returnTripId": returnTripId,
    "isReturnTrip": isReturnTrip,
    "returnDate": returnDate,
    "returnTime": returnTime,
  };
}
