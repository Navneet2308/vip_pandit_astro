import 'package:firebase_database/firebase_database.dart';

class MessageModel {
 final String message,messanger_name,user_id;

  MessageModel({
    required this.message,
    required this.messanger_name,
    required this.user_id,

  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'messanger_name': messanger_name,
      'user_id': user_id,
    };
  }

  factory MessageModel.fromDataSnapshot(DataSnapshot dataSnapshot) {
    final data = dataSnapshot.value as Map<dynamic, dynamic>?;
    final message = data?["message"] as String?;
    final messangerName = data?["messanger_name"] as String?;
    final userId = data?["user_id"] as String?;

    return MessageModel(
      message: message ?? "",
      messanger_name: messangerName ?? "",
        user_id:userId??"",
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      messanger_name: json['messanger_name'],
      user_id: json['user_id'],

    );
  }
}