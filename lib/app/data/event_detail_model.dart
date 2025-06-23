import 'dart:convert';

EventDetailsModel eventDetailsModelFromJson(String str) => EventDetailsModel.fromJson(json.decode(str));

String eventDetailsModelToJson(EventDetailsModel data) => json.encode(data.toJson());

class EventDetailsModel {
  bool? status;
  String? message;
  EventDetailsData? data;
  dynamic chatRoomId;
  DateTime? deleteUpdateTime;

  EventDetailsModel({
    this.status,
    this.message,
    this.data,
    this.chatRoomId,
   this.deleteUpdateTime,

  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) => EventDetailsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : EventDetailsData.fromJson(json["data"]),
    chatRoomId: json["chatRoomId"],
    deleteUpdateTime: json["deleteUpdateTime"] == null ? null : DateTime.parse(json["deleteUpdateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "chatRoomId": chatRoomId,
    "deleteUpdateTime": deleteUpdateTime?.toIso8601String(),

  };
}

class EventDetailsData {
  Event? event;
  List<User>? users;
  bool? isAvailable;
  int? totalUsers;

  EventDetailsData({
    this.event,
    this.users,
    this.isAvailable,
    this.totalUsers,
  });

  factory EventDetailsData.fromJson(Map<String, dynamic> json) => EventDetailsData(
    event: json["event"] == null ? null : Event.fromJson(json["event"]),
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    isAvailable: json["isAvailable"],
    totalUsers: json["totalUsers"],
  );

  Map<String, dynamic> toJson() => {
    "event": event?.toJson(),
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    "isAvailable": isAvailable,
    "totalUsers": totalUsers,
  };
}

class Event {
  Destination? destination;
  String? id;
  String? title;
  DateTime? date;
  DateTime? time;
  String? description;
  int? expectedAttendees;
  bool? isPublic;
  User? userId;
  bool? isExpired;

  Event({
    this.destination,
    this.id,
    this.title,
    this.date,
    this.time,
    this.description,
    this.expectedAttendees,
    this.isPublic,
    this.userId,
    this.isExpired,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    id: json["_id"],
    title: json["title"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    description: json["description"],
    expectedAttendees: json["expectedAttendees"],
    isPublic: json["isPublic"],
    userId: json["userId"] == null ? null : User.fromJson(json["userId"]),
    isExpired: json["isExpired"],
  );

  Map<String, dynamic> toJson() => {
    "destination": destination?.toJson(),
    "_id": id,
    "title": title,
    "date": date?.toIso8601String(),
    "time": time?.toIso8601String(),
    "description": description,
    "expectedAttendees": expectedAttendees,
    "isPublic": isPublic,
    "userId": userId?.toJson(),
    "isExpired": isExpired,
  };
}

class Destination {
  String? type;
  List<double>? coordinates;
  String? name;
  double? longitude;
  double? latitude;

  Destination({
    this.type,
    this.coordinates,
    this.name,
    this.longitude,
    this.latitude,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x.toDouble())),
    name: json["name"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "name": name,
    "longitude": longitude,
    "latitude": latitude,
  };
}

class User {
  ProfilePic? profilePic;
  String? id;
  String? fullName;
  String? phone;

  User({
    this.profilePic,
    this.id,
    this.fullName,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    profilePic: json["profilePic"] == null ? null : ProfilePic.fromJson(json["profilePic"]),
    id: json["_id"],
    fullName: json["fullName"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "profilePic": profilePic?.toJson(),
    "_id": id,
    "fullName": fullName,
    "phone": phone,
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
