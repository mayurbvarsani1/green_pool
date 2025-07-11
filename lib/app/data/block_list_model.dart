import 'dart:convert';

BlockListModel blockListModelFromJson(String str) => BlockListModel.fromJson(json.decode(str));

String blockListModelToJson(BlockListModel data) => json.encode(data.toJson());

class BlockListModel {
  bool? status;
  String? message;
  BlockDataList? data;

  BlockListModel({
    this.status,
    this.message,
    this.data,
  });

  factory BlockListModel.fromJson(Map<String, dynamic> json) => BlockListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : BlockDataList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class BlockDataList {
  List<BlockDocList>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  BlockDataList({
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

  factory BlockDataList.fromJson(Map<String, dynamic> json) => BlockDataList(
    docs: json["docs"] == null ? [] : List<BlockDocList>.from(json["docs"]!.map((x) => BlockDocList.fromJson(x))),
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

class BlockDocList {
  String? id;
  String? details;
  DateTime? createdAt;
  BlockedUser? blockedUser;

  BlockDocList({
    this.id,
    this.details,
    this.createdAt,
    this.blockedUser,
  });

  factory BlockDocList.fromJson(Map<String, dynamic> json) => BlockDocList(
    id: json["_id"],
    details: json["details"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    blockedUser: json["blockedUser"] == null ? null : BlockedUser.fromJson(json["blockedUser"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "details": details,
    "createdAt": createdAt?.toIso8601String(),
    "blockedUser": blockedUser?.toJson(),
  };
}

class BlockedUser {
  String? id;
  String? email;

  BlockedUser({
    this.id,
    this.email,
  });

  factory BlockedUser.fromJson(Map<String, dynamic> json) => BlockedUser(
    id: json["_id"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
  };
}
