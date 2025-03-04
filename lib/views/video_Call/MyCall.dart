import 'package:astrologeradmin/constance/language/language.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../constance/contants.dart';
import 'controllers/video_provider.dart';


class VideoCall extends StatelessWidget {


  const VideoCall();

  @override
  Widget build(BuildContext context) {
    VideoProvider videoProvider = Provider.of<VideoProvider>(context);
    videoProvider.removeRoomListener(context);
    return Consumer<VideoProvider>(builder: (context, videoProvider, child)
    {
      return WillPopScope(
        onWillPop: () async {
          videoProvider.showExitDialog(context);
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              ZegoUIKitPrebuiltCall(
                appID: MyConst.appId,
                appSign: MyConst.appSign,
                userID: "astro_id"+videoProvider.consultationData.astroId.toString(),
                userName: MyConst.my_name,
                callID: "astrocallid_" +
                    videoProvider.consultationData.conId.toString(),
                events: ZegoUIKitPrebuiltCallEvents(
                  // Modify your custom configurations here.
                  onHangUpConfirmation: (ZegoCallHangUpConfirmationEvent event,

                      /// defaultAction to return to the previous page
                      Future<bool> Function() defaultAction,) async {
                    return await showDialog(
                      context: event.context,
                      barrierDismissible: false,
                      builder: (BuildContext mcontext) {
                        return AlertDialog(
                          title: Text(Languages.of(context)!.end_consultation,
                              style: TextStyle(color: Colors.black)),
                          content: Text(
                              Languages.of(context)!
                                  .end_consultation_description,
                              style: TextStyle(color: Colors.black)),
                          actions: [
                            ElevatedButton(
                              child: Text(Languages.of(context)!.cancel,
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () =>
                                  Navigator.of(mcontext).pop(false),
                            ),
                            ElevatedButton(
                              child: Text(
                                  Languages.of(context)!.yes,
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () {
                                Navigator.of(mcontext).pop(false);
                                videoProvider.end(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                  ..bottomMenuBarConfig = ZegoBottomMenuBarConfig(
                      hideAutomatically: false),
              ),
            ],
          ),
        ),
      );
    });
  }
}