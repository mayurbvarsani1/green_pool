import 'dart:convert';

EventListModel eventListModelFromJson(String str) => EventListModel.fromJson(json.decode(str));

String eventListModelToJson(EventListModel data) => json.encode(data.toJson());

class EventListModel {
  bool? status;
  String? message;
  Data? data;

  EventListModel({
    this.status,
    this.message,
    this.data,
  });

  factory EventListModel.fromJson(Map<String, dynamic> json) => EventListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<Doc>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    docs: json["docs"] == null ? [] : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
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

class Doc {
  String? id;
  String? title;
  Destination? destination;
  dynamic date;
  DateTime? time;
  int? expectedAttendees;
  bool? isExpired;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? isPublic;
  String? description;

  Doc({
    this.id,
    this.title,
    this.destination,
    this.date,
    this.time,
    this.expectedAttendees,
    this.isExpired,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isPublic,
    this.description,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    id: json["_id"],
    title: json["title"],
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    date: json["date"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    expectedAttendees: json["expectedAttendees"],
    isExpired: json["isExpired"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isPublic: json["isPublic"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "destination": destination?.toJson(),
    "date": date,
    "time": time?.toIso8601String(),
    "expectedAttendees": expectedAttendees,
    "isExpired": isExpired,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "isPublic": isPublic,
    "description": description,
  };
}

class Destination {
  String? name;
  String? type;
  List<double>? coordinates;
  double? longitude;
  double? latitude;

  Destination({
    this.name,
    this.type,
    this.coordinates,
    this.longitude,
    this.latitude,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    name: json["name"],
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "longitude": longitude,
    "latitude": latitude,
  };
}
