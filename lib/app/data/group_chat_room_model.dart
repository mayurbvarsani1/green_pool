
import 'dart:convert';

GroupChatRoomListModel groupChatRoomListModelFromJson(String str) => GroupChatRoomListModel.fromJson(json.decode(str));

String groupChatRoomListModelToJson(GroupChatRoomListModel data) => json.encode(data.toJson());

class GroupChatRoomListModel {
  List<ChatRoom>? chatRooms;

  GroupChatRoomListModel({
    this.chatRooms,
  });

  factory GroupChatRoomListModel.fromJson(Map<String, dynamic> json) => GroupChatRoomListModel(
    chatRooms: json["chatRooms"] == null ? [] : List<ChatRoom>.from(json["chatRooms"]!.map((x) => ChatRoom.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chatRooms": chatRooms == null ? [] : List<dynamic>.from(chatRooms!.map((x) => x.toJson())),
  };
}

class ChatRoom {
  List<DeletedUser>? deletedUser;
  String? id;
  String? user1;
  String? user2;
  dynamic ridePostId;
  String? chatRoomId;
  String? paymentStatus;
  String? lastMessage;
  DateTime? lastMessageTime;
  int? user1UnreadCount;
  int? user2UnreadCount;
  DateTime? deleteTimeByUser1;
  dynamic deleteTimeByUser2;
  bool? isLastMessageByUser1;
  bool? isLastMessageByUser2;
  bool? isArchivedByUser1;
  bool? isArchivedByUser2;
  dynamic driverRideId;
  dynamic riderRideId;
  RidesDetails? ridesDetails;
  dynamic distance;
  EventId? eventId;
  List<String>? users;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  DateTime? deleteUpdateTime;

  ChatRoom({
    this.deletedUser,
    this.id,
    this.user1,
    this.user2,
    this.ridePostId,
    this.chatRoomId,
    this.paymentStatus,
    this.lastMessage,
    this.lastMessageTime,
    this.user1UnreadCount,
    this.user2UnreadCount,
    this.deleteTimeByUser1,
    this.deleteTimeByUser2,
    this.isLastMessageByUser1,
    this.isLastMessageByUser2,
    this.isArchivedByUser1,
    this.isArchivedByUser2,
    this.driverRideId,
    this.riderRideId,
    this.ridesDetails,
    this.distance,
    this.eventId,
    this.users,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.deleteUpdateTime,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
    deletedUser: json["deletedUser"] == null ? [] : List<DeletedUser>.from(json["deletedUser"]!.map((x) => DeletedUser.fromJson(x))),
    id: json["_id"],
    user1: json["user1"],
    user2: json["user2"],
    ridePostId: json["ridePostId"],
    chatRoomId: json["chatRoomId"],
    paymentStatus: json["paymentStatus"],
    lastMessage: json["lastMessage"],
    lastMessageTime: json["lastMessageTime"] == null ? null : DateTime.parse(json["lastMessageTime"]),
    user1UnreadCount: json["user1UnreadCount"],
    user2UnreadCount: json["user2UnreadCount"],
    deleteTimeByUser1: json["deleteTimeByUser1"] == null ? null : DateTime.parse(json["deleteTimeByUser1"]),
    deleteTimeByUser2: json["deleteTimeByUser2"],
    isLastMessageByUser1: json["isLastMessageByUser1"],
    isLastMessageByUser2: json["isLastMessageByUser2"],
    isArchivedByUser1: json["isArchivedByUser1"],
    isArchivedByUser2: json["isArchivedByUser2"],
    driverRideId: json["driverRideId"],
    riderRideId: json["riderRideId"],
    ridesDetails: json["ridesDetails"] == null ? null : RidesDetails.fromJson(json["ridesDetails"]),
    distance: json["distance"],
    eventId: json["eventId"] == null ? null : EventId.fromJson(json["eventId"]),
    users: json["users"] == null ? [] : List<String>.from(json["users"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    deleteUpdateTime: json["deleteUpdateTime"] == null ? null : DateTime.parse(json["deleteUpdateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "deletedUser": deletedUser == null ? [] : List<dynamic>.from(deletedUser!.map((x) => x.toJson())),
    "_id": id,
    "user1": user1,
    "user2": user2,
    "ridePostId": ridePostId,
    "chatRoomId": chatRoomId,
    "paymentStatus": paymentStatus,
    "lastMessage": lastMessage,
    "lastMessageTime": lastMessageTime?.toIso8601String(),
    "user1UnreadCount": user1UnreadCount,
    "user2UnreadCount": user2UnreadCount,
    "deleteTimeByUser1": deleteTimeByUser1?.toIso8601String(),
    "deleteTimeByUser2": deleteTimeByUser2,
    "isLastMessageByUser1": isLastMessageByUser1,
    "isLastMessageByUser2": isLastMessageByUser2,
    "isArchivedByUser1": isArchivedByUser1,
    "isArchivedByUser2": isArchivedByUser2,
    "driverRideId": driverRideId,
    "riderRideId": riderRideId,
    "ridesDetails": ridesDetails?.toJson(),
    "distance": distance,
    "eventId": eventId?.toJson(),
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "deleteUpdateTime": deleteUpdateTime?.toIso8601String(),
  };
}

class DeletedUser {
  String? userId;
  DateTime? deleteUpdateTime;

  DeletedUser({
    this.userId,
    this.deleteUpdateTime,
  });

  factory DeletedUser.fromJson(Map<String, dynamic> json) => DeletedUser(
    userId: json["userId"],
    deleteUpdateTime: json["deleteUpdateTime"] == null ? null : DateTime.parse(json["deleteUpdateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "deleteUpdateTime": deleteUpdateTime?.toIso8601String(),
  };
}

class EventId {
  String? id;
  String? title;
  DateTime? date;

  EventId({
    this.id,
    this.title,
    this.date,
  });

  factory EventId.fromJson(Map<String, dynamic> json) => EventId(
    id: json["_id"],
    title: json["title"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "date": date?.toIso8601String(),
  };
}

class RidesDetails {
  Destination? origin;
  Destination? destination;
  dynamic date;
  dynamic time;
  dynamic price;
  dynamic seatAvailable;
  String? description;
  bool? pinkMode;
  String? id;

  RidesDetails({
    this.origin,
    this.destination,
    this.date,
    this.time,
    this.price,
    this.seatAvailable,
    this.description,
    this.pinkMode,
    this.id,
  });

  factory RidesDetails.fromJson(Map<String, dynamic> json) => RidesDetails(
    origin: json["origin"] == null ? null : Destination.fromJson(json["origin"]),
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    date: json["date"],
    time: json["time"],
    price: json["price"],
    seatAvailable: json["seatAvailable"],
    description: json["description"],
    pinkMode: json["pinkMode"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "origin": origin?.toJson(),
    "destination": destination?.toJson(),
    "date": date,
    "time": time,
    "price": price,
    "seatAvailable": seatAvailable,
    "description": description,
    "pinkMode": pinkMode,
    "_id": id,
  };
}

class Destination {
  String? name;
  List<dynamic>? coordinates;

  Destination({
    this.name,
    this.coordinates,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    name: json["name"],
    coordinates: json["coordinates"] == null ? [] : List<dynamic>.from(json["coordinates"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
