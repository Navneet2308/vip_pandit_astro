import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


String formatTo24Hour(TimeOfDay time) {
  final hour = time.hour < 10 ? '0${time.hour}' : time.hour.toString();
  final minute = time.minute < 10 ? '0${time.minute}' : time.minute.toString();
  return '$hour:$minute';
}
String convertTimeFormat(String time) {
  List<String> parts = time.split(":");

  if (parts.length == 2) {
    int first = int.parse(parts[0]);
    int second = int.parse(parts[1]);

    if (first > 0 && second == 0) {
      return "$first minute${first > 1 ? 's' : ''}";
    } else if (first == 0 && second > 0) {
      return "$second second${second > 1 ? 's' : ''}";
    } else if (first > 0 && second > 0) {
      return "$first minute${first > 1 ? 's' : ''} $second second${second > 1 ? 's' : ''}";
    }
  }

  return "Invalid format";
}

bool isValidEmail(String email) {
  final emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  return emailRegex.hasMatch(email);
}

String convertDateTime(String dateString) {
  String formattedDate = "";
  DateTime dateTime = DateTime.parse(dateString);
  try {
    formattedDate = DateFormat('dd-MM-yyyy HH:mm:aa').format(dateTime);
  } catch (e) {}
  return formattedDate;
}

String convertDate(String dateString) {
  String formattedDate = "";
  DateTime dateTime = DateTime.parse(dateString);
  try {
    formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
  } catch (e) {}
  return formattedDate;
}

void showErrorSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
void showSuccessSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showNormalSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.grey[300],
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
