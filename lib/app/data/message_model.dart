class MessageModel {
  final String id;
  final String message;
  final String senderId;
  final DateTime timestamp;
  String? senderName;
  String? senderProfilePic;

  MessageModel({
    required this.id,
    required this.message,
    required this.senderId,
    required this.timestamp,
    this.senderName,
    this.senderProfilePic,
  });

  factory MessageModel.fromMap(String id, Map<String, dynamic> data) {
    return MessageModel(
      id: id,
      message: data['message'],
      senderId: data['senderId'],
      timestamp: DateTime.parse(data['timestamp']),
      senderName: data['senderName'],
      senderProfilePic: data['senderProfilePic'],
    );
  }
}

class DataMsgModel {
  final List<MessageModel> messages;

  DataMsgModel({
    required this.messages,
  });

  factory DataMsgModel.fromMap(Map<String, dynamic> data) {
    final List<MessageModel> messages = [];
    data.forEach((key, value) {
      messages.add(MessageModel.fromMap(key, Map<String, dynamic>.from(value)));
    });

    return DataMsgModel(
      messages: messages,
    );
  }
}
