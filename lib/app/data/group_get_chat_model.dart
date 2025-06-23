import 'dart:convert';

GroupGetChatListModel groupGetChatListModelFromJson(String str) => GroupGetChatListModel.fromJson(json.decode(str));

String groupGetChatListModelToJson(GroupGetChatListModel data) => json.encode(data.toJson());

class GroupGetChatListModel {
  List<Message>? messages;

  GroupGetChatListModel({
    this.messages,
  });

  factory GroupGetChatListModel.fromJson(Map<String, dynamic> json) => GroupGetChatListModel(
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
  };
}

class Message {
  String? messageId;
  String? message;
  String? senderId;
  String? senderName;
  String? senderProfilePic;
  DateTime? timestamp;

  Message({
    this.messageId,
    this.message,
    this.senderId,
    this.senderName,
    this.senderProfilePic,
    this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    messageId: json["messageId"],
    message: json["message"],
    senderId: json["senderId"],
    senderName: json["senderName"],
    senderProfilePic: json["senderProfilePic"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "messageId": messageId,
    "message": message,
    "senderId": senderId,
    "senderName": senderName,
    "senderProfilePic": senderProfilePic,
    "timestamp": timestamp?.toIso8601String(),
  };
}
