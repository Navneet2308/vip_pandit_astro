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
  bool _isFind = false;
  bool isYouLeft = false;
  final ApiService apiService = ApiService();

  String _message = "Please wait for astrologer...";
  late ConsultationData consultationData;
  late StreamSubscription<DatabaseEvent> listener;
  late final StopWatchTimer stopWatchTimer = StopWatchTimer();

  bool get isFind => _isFind;
  String get message => _message;


  @override
  void onInit() {
    // consultationData = Get.arguments[0];
    // super.onInit();
  }


  @override
  void onClose() {
    stopWatchTimer.dispose();
    listener.cancel();
    // WidgetsBinding.instance.removeObserver(Get.context!!);
    // super.onClose();
  }
  void end(BuildContext context) {
    removeRoom(context);
  }

  void startStopwatch() {
    stopWatchTimer.onStartTimer();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused && !isYouLeft) {
      isYouLeft = true;
      print("isYouLeft_value_new"+isYouLeft.toString());

      final databaseReference = FirebaseDatabase.instance.ref().child("room_call");
      await databaseReference.child(consultationData.conId.toString()).remove();    }
  }

  void removeRoomListener(BuildContext context) {
    final databaseReference = FirebaseDatabase.instance.ref().child("room_call");
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    listener = databaseReference.child(consultationData.conId.toString()).onChildRemoved.listen((event) async {
      print("isYouLeft_value"+isYouLeft.toString());
      if (!isYouLeft) {
        Fluttertoast.showToast(msg: "User Left");
        print("start");
        try {
          final response = await apiService.post_auth(ApiPath.updateConsultation, {
            "status": 2,
            // "charge_amount":0,
            // "duration":"00:00",
            "con_id": consultationData.conId!,
            "consultation_type": consultationData.consultationType.toString()
          });
          final mResponse = UpdateConsultationModel.fromJson(response);
          if (mResponse.message != null) {
            print("start_1");
            CustomNavigators.pushReplacementNavigate(
                ConsultationComplete(mconsultationData: mResponse.data!),context);
          }
        } catch (error) {
          print("start_2"+error.toString());
        } finally {
          notifyListeners();
        }
      }
      listener.cancel();
    });
  }

  Future<void> removeRoom(BuildContext context) async {
    final databaseReference = FirebaseDatabase.instance.ref().child("room_call");
    await databaseReference.child(consultationData.conId.toString()).remove();
    Navigator.pop(context);

  }

  void showExitDialog(BuildContext context) {
    AlertDialog(
      title: const Text(
        "Exit",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: const Text(
        "Are you sure you want to exit this call?",
        style: TextStyle(fontSize: 13, color: Colors.black45),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "No",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color:colPrimary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            isYouLeft = true;
            removeRoom(context);
            Navigator.pop(context);
            Navigator.pop(context);
            // Get.back(); // Close dialog
            // Get.back(); // Navigate back
          },
          child:  Text(
            "Yes",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color:  colPrimary,
            ),
          ),
        ),
      ],
    );
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
        builder: (context) => VideoCall(
        ),
      ));


      // Perform any other actions after updating the status and name
    } catch (error) {
      // Handle errors here
      print('Error updating room status: $error');
    }  }



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
