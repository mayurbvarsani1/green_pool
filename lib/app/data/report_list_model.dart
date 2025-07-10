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
  List<ReportList>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  int? nextPage;

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
    docs: json["docs"] == null ? [] : List<ReportList>.from(json["docs"]!.map((x) => ReportList.fromJson(x))),
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

class ReportList {
  String? id;
  String? rideId;
  String? createdById;
  String? reason;
  String? details;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ReportList({
    this.id,
    this.rideId,
    this.createdById,
    this.reason,
    this.details,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ReportList.fromJson(Map<String, dynamic> json) => ReportList(
    id: json["_id"],
    rideId: json["rideId"],
    createdById: json["createdById"],
    reason: json["reason"],
    details: json["details"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "rideId": rideId,
    "createdById": createdById,
    "reason": reason,
    "details": details,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
