import 'dart:async';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:provider/provider.dart';
import '../../constance/assets_path.dart';
import '../../constance/language/language.dart';
import '../../constance/textstyle.dart';

import '../../model/update_consultationModel.dart';
import '../../provider/chat_provider.dart';

class AstrologerChat extends StatelessWidget {
  final ConsultationData? mconsultationData;

  AstrologerChat({required this.mconsultationData});

  @override
  void dispose() {}

  messageUi(Color color, Color textcolor, String message, String align) {
    return Container(
      width: 230,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(
              2.0,
              2.0,
            ),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(
                  color: textcolor,
                  fontSize: 15,
                  fontFamily: "assets/fonts/montsrrat/montserrat_medium.ttf",
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatProvider = Provider.of<AstrologerChatProvider>(context, listen: false);
      chatProvider.initchat(mconsultationData!,context);
    });
    return Consumer<AstrologerChatProvider>(builder: (context, chatProvider, child)
    {
      return WillPopScope(
        onWillPop: () async {
          return showAlertDialog(chatProvider, context);
        },
        child: Scaffold(
          backgroundColor: light_yellow,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: colPrimary,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Image.asset(
                AssetsPath.logo,
                height: 40.0,
                width: 40.0,
              ),
            ),
            title: Text(
              Languages.of(context)!.aiAstrologyS,
              style: semiBoldTextStyle(fontSize: dimen16, color: black),
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5),
                color: colPrimary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: "dkdkkdkdkkdkdkkdkd",
                            width: 33,
                            height: 33,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(
                                  Icons.error_outline,
                                  color: lightText,
                                  size: 33,
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          chatProvider.consultationData.fullName!,
                          style: semiBoldTextStyle(
                            fontSize: dimen16,
                            color: colBlackText,
                          ),
                        ),
                      ],
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: secondaryTextColor,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(
                    //           2), // Adjust the value for desired roundness
                    //     ),
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: 10), // Removes extra padding
                    //   ),
                    //   onPressed: () {
                    //     chatProvider.updateConsultation(
                    //         context, "1", chatProvider.consultationData.conId!,
                    //         int.parse(chatProvider.consultationData
                    //             .consultationType.toString()), "02:00", 0);
                    //   },
                    //   child: Text(
                    //     Languages.of(context)!.end_consultation,
                    //     style: regularTextStyle(
                    //       fontSize: dimen10,
                    //       color: textWhite,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   color: light_pink,
              //   padding: const EdgeInsets.all(8),
              //   child: Text(
              //     "${Languages.of(context)!.paid_minute} ${chatProvider.displayTime}",
              //     textAlign: TextAlign.center,
              //     style: mediumTextStyle(
              //       fontSize: dimen16,
              //       color: colBlackText,
              //     ),
              //   ),
              // ),
              Expanded(
                child: SingleChildScrollView(
                  controller: chatProvider.scrollController,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: colPrimary),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${chatProvider.consultationData
                                    .fullName} - ${chatProvider.consultationData
                                    .gender}",
                                style: boldTextStyle(
                                  fontSize: dimen16,
                                  color: colBlackText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${Languages.of(context)!
                                    .dob_short} ${chatProvider.consultationData
                                    .dateOfBirth} ${chatProvider
                                    .consultationData.timeOfBirth ?? ''}",
                                style: regularTextStyle(
                                  fontSize: dimen16,
                                  color: lightText,
                                ),
                              ),
                              Text(
                                "${chatProvider.consultationData
                                    .placeOfBirth} - ${chatProvider
                                    .consultationData.pincode}",
                                style: regularTextStyle(
                                  fontSize: dimen16,
                                  color: lightText,
                                ),
                              ),
                              Text(
                                "${chatProvider.consultationData.concernTopic}",
                                style: regularTextStyle(
                                  fontSize: dimen14,
                                  color: lightText,
                                ),
                              ),
                              if (chatProvider.consultationData.partnerName !=
                                  null)
                                Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      chatProvider.consultationData
                                          .partnerName!,
                                      style: boldTextStyle(
                                        fontSize: dimen16,
                                        color: lightText,
                                      ),
                                    ),
                                    Text(
                                      "${Languages.of(context)!
                                          .dob_short} ${chatProvider
                                          .consultationData
                                          .partnerDob} ${chatProvider
                                          .consultationData.partnerTob}",
                                      style: regularTextStyle(
                                        fontSize: dimen14,
                                        color: lightText,
                                      ),
                                    ),
                                    Text(
                                      chatProvider.consultationData
                                          .partnerPob ??
                                          '',
                                      style: regularTextStyle(
                                        fontSize: dimen14,
                                        color: lightText,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      chatProvider.messages.isEmpty
                          ? SizedBox.shrink()
                          : Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: chatProvider.messages.length,
                          itemBuilder: (context, index) {
                            final message = chatProvider.messages[index];
                            return buildItem(
                              chatProvider,
                              index,
                              message.message,
                              message.user_id,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: chatProvider.messageController,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: "Type message ...",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 12,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        chatProvider
                            .sendMessage(chatProvider.messageController.text);
                      },
                      child: Transform.rotate(
                        angle: -45 * (3.14159 / 180),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colSecondary,
                          ),
                          child: Icon(
                            Icons.send,
                            color: textWhite,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildItem(AstrologerChatProvider provider, int index,
      String message_data, String msg_sender_id) {
    if (message_data != null) {
      if (msg_sender_id == "astro_"+provider.consultationData.astroId.toString()) {
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                    child: Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.topRight,
                  child:
                      messageUi(secondaryTextColor, Colors.white, message_data, "right"),
                )),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            index == provider.messages.length - 1
                ? SizedBox(
                    height: 80,
                  )
                : Container()
          ],
        );
      } else {
        return Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.topLeft,
                    child: messageUi(
                        Colors.white, colBlackText, message_data, "left"),
                  ),
                ],
              ),
              index == provider.messages.length - 1
                  ? SizedBox(height: 80)
                  : Container()
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  Future<void> removeRoom(AstrologerChatProvider provider) async {
    provider.databaseReference.remove();
    //  controller.databaseReference.remove();
  }

  showAlertDialog(AstrologerChatProvider provider, BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(Languages.of(context)!.no,
          style: TextStyle(
              color: appTheme, fontWeight: FontWeight.w600, fontSize: 14)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        Languages.of(context)!.yes,
        style: TextStyle(
            color: appTheme, fontWeight: FontWeight.w600, fontSize: 14),
      ),
      onPressed: () {
        provider.isYouLeft = true;
        removeRoom(provider);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        Languages.of(context)!.exit,
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: Text(
        Languages.of(context)!.are_your_sure_exit_chat,
        style: TextStyle(color: Colors.black45, fontSize: 13),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
