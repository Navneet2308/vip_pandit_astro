import 'dart:async';
import 'package:astrologeradmin/services/api_path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../constance/my_colors.dart';
import '../../../model/update_consultationModel.dart';
import '../../../services/ApiService.dart';
import '../../../widget/navigators.dart';
import '../../consultationComplete_view.dart';
import '../MyCall.dart';

class VideoProvider with ChangeNotifier {
  bool isYouLeft = false;
  final ApiService apiService = ApiService();

  String _message = "Please wait for astrologer...";
  late ConsultationData consultationData;
  StreamSubscription<DatabaseEvent>? listener;

  String get message => _message;
  bool hasHandled = false;

  @override
  void onInit() {
    // consultationData = Get.arguments[0];
    // super.onInit();
  }

  @override
  void onClose() {
    listener?.cancel();
  }

  void end(BuildContext context) {
    removeRoom(context);
  }

  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.paused && !isYouLeft) {
  //     isYouLeft = true;
  //     print("isYouLeft_value_new"+isYouLeft.toString());
  //     final databaseReference = FirebaseDatabase.instance.ref().child("room_call");
  //     await databaseReference.child(consultationData.conId.toString()).remove();
  //
  //   }
  // }

  void removeRoomListener(BuildContext context) async {
    // final databaseReference = FirebaseDatabase.instance.ref().child("room_call");
    // await listener?.cancel();
    // listener = databaseReference
    //     .child(consultationData.conId.toString())
    //     .onChildRemoved
    //     .listen((event) async {
    //   if (!isYouLeft && !hasHandled) {
    //     hasHandled = true;
    //     await listener?.cancel();
    //     await callEndAPI(context);
    //   }
    // });
  }

  Future<void> callEndAPI(BuildContext context) async {
    Fluttertoast.showToast(msg: "Customer Left");
    try {
      final response = await apiService.post_auth(
        ApiPath.updateConsultation,
        {
          "status": 2,
          "con_id": consultationData.conId!,
          "consultation_type": consultationData.consultationType.toString(),
        },
      );

      final mResponse = UpdateConsultationModel.fromJson(response);
      if (mResponse.message != null && context.mounted) {
        CustomNavigators.pushReplacementNavigate(
          ConsultationComplete(mconsultationData: mResponse.data!),
          context,
        );
      }
    } catch (error) {
      print("Errddddor: $error");
    }
  }


  Future<void> removeRoom(BuildContext context) async {
    final databaseReference =
        FirebaseDatabase.instance.ref().child("room_call");
    await databaseReference.child(consultationData.conId.toString()).remove();
    Navigator.pop(context);
  }


  Future<void> initSharedPreferences(BuildContext context) async {
    getDataFromFirebase(context);
  }

  Future<void> getDataFromFirebase(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child("room_call");
    try {
      await databaseReference.child(consultationData.conId.toString()).update({
        'status': 1,
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => VideoCall(),
      ));

      // Perform any other actions after updating the status and name
    } catch (error) {
      // Handle errors here
      print('Error updating room status: $error');
    }
  }

  // void createRoom(String roomId) {
  //   DatabaseReference roomsRef =
  //   FirebaseDatabase.instance.ref().child("room_call");
  //   DatabaseReference newRoomRef = roomsRef.child(roomId);
  //
  //   newRoomRef.set({
  //     'user_name': consultationData.fullName,
  //     'userId': consultationData.cusId,
  //     'status': 0,
  //     'callid': consultationData.conId.toString(),
  //     'createdBy': consultationData.cusId,
  //     'incomingCallId': consultationData.cusId,
  //   }).then((_) {
  //     newRoomRef.child('status').onValue.listen((event) {
  //       if (event.snapshot.value == 1) {
  //         newRoomRef.once().then((dshot) {
  //           // Get.offAndToNamed(Routes.videoCall);
  //         });
  //       }
  //     });
  //   }).catchError((error) {
  //     print('Failed to create room: $error');
  //   });
  // }

  void stopSearching(BuildContext context) {
    Navigator.pop(context);
  }
}
