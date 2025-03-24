import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../model/messageModel.dart';
import '../model/update_consultationModel.dart';
import '../services/ApiService.dart';
import '../services/api_path.dart';
import '../services/user_prefences.dart';
import '../utils/function_utils.dart';
import '../views/consultationComplete_view.dart';
import '../widget/navigators.dart';

class AstrologerChatProvider extends ChangeNotifier {
  ScrollController listScrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  late DatabaseReference databaseReference;
  List<MessageModel> messages = [];
  bool isYouLeft = false;

  String myId = "";
  bool isHeaderVisible = true;
  int seconds = 0;

  final StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  String displayTime = "00:00";
  String my_name = "Astrologer";

  final ApiService apiService = ApiService();

  late String consultationType;
  ConsultationData consultationData = ConsultationData();

  initchat(ConsultationData mconsultationData,BuildContext context) {
    consultationData = mconsultationData!;
    initdb(context);
    notifyListeners();
  }

  Future<void> initdb(BuildContext context) async {
    my_name = await PreferencesServices.getPreferencesData(
        PreferencesServices.fullName);
    databaseReference = FirebaseDatabase.instance
        .ref()
        .child("astro_chat")
        .child(consultationData.conId.toString());
    validateDb(context);
  }

  void sendMessage(String message) async {
    if (message.isNotEmpty) {
      try {
        MessageModel messageModel = MessageModel(
          message: message,
          messanger_name: my_name,
          user_id: "astro_"+consultationData.astroId!.toString(),
        );
        await databaseReference
            .child("chathistory")
            .push()
            .set(messageModel.toJson());
        messageController.clear();
      } catch (error) {
        debugPrint("Failed to send message: $error");
      }
    }
  }

  void startTimer() {
    stopWatchTimer.onStartTimer();
  }

  void stopTimer() {
    stopWatchTimer.onStopTimer();
  }

  void resetTimer() {
    stopWatchTimer.onResetTimer();
  }

  void validateDb(BuildContext context) {
    messages.clear();
    databaseReference.child("chathistory").onChildAdded.listen((event) {
      final msgData = event.snapshot;
      if (msgData.value != null) {
        isHeaderVisible = false;
        MessageModel msgModel = MessageModel.fromDataSnapshot(msgData);
        messages.add(msgModel);
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
        notifyListeners();
      }
    });

    removeRoomListener(context);
  }

  void removeRoomListener(BuildContext context) {
    late StreamSubscription<DatabaseEvent> listener;
    listener = databaseReference.onChildRemoved.listen((event) {
      if (!isYouLeft) {
        Fluttertoast.showToast(msg: "Customer Left");
        end(context);
      }
      listener.cancel();
    });
  }

  Future<void> end(BuildContext context) async {
    try {
      final response = await apiService.post_auth(ApiPath.updateConsultation, {
        "status": 2,
        "con_id": consultationData.conId!,
        "consultation_type": consultationData.consultationType.toString()
      });
      final mResponse = UpdateConsultationModel.fromJson(response);
      if (mResponse.message != null) {
        CustomNavigators.pushReplacementNavigate(
            ConsultationComplete(mconsultationData: mResponse.data!),context);
      }
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  updateConsultation(BuildContext context, String mstatus, int con_id,
      int consultation_type, String duration, int charge_amount) async {
    try {
      final response = await apiService.post_auth(ApiPath.updateConsultation, {
        "status": mstatus,
        "con_id": con_id,
        "duration": duration,
        "charge_amount": charge_amount,
        "consultation_type": consultation_type
      });
      final mResponse = UpdateConsultationModel.fromJson(response);
      if (mResponse.message != null) {
        if (mstatus == "3") {
        } else {
          showSuccessSnackBar(context, mResponse.message!);
        }
      }
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    listScrollController.dispose();
    messageController.dispose();
    scrollController.dispose();
    stopWatchTimer.dispose();
    super.dispose();
  }
}
