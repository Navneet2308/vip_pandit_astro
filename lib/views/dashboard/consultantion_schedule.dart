import 'dart:io';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../constance/language/language.dart';
import '../../constance/textstyle.dart';
import '../../provider/dashboard_provider.dart';
import '../../utils/function_utils.dart';

class ConsultantionSchedule extends StatelessWidget {
  const ConsultantionSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.getConsultationSchedule(context);
    });

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<DashboardProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.of(context)!.consultation_Schedule,
                              style: mediumTextStyle(
                                  fontSize: dimen17, color: black),
                            ),
                            SizedBox(height: 3),
                            Text(
                              Languages.of(context)!.consulation_schedule_text,
                              style: regularTextStyle(
                                fontSize: dimen13,
                                color: lightGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          provider.day_controllers.entries.map((entry) {
                            String day = entry.key;
                            List<TextEditingController> controllers =
                                entry.value;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row to show the day name and add button
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        day,
                                        style: regularTextStyle(
                                            fontSize: dimen15, color: colBlack),
                                      ),
                                    ),
                                    // Add Button
                                  ],
                                ),
                                // Display the text fields
                                ...controllers
                                    .asMap()
                                    .map((index, controller) {
                                  return MapEntry(
                                    index,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          // TextField for the time range (start and end time)
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                // Open time picker for the start time
                                                TimeOfDay? startPickedTime =
                                                await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                  TimeOfDay.now(),
                                                );
                                                if (startPickedTime !=
                                                    null) {
                                                  // Convert to 24-hour format (HH:mm)
                                                  String startTime =
                                                  formatTo24Hour(
                                                      startPickedTime);

                                                  // Open time picker for the end time
                                                  TimeOfDay? endPickedTime =
                                                  await showTimePicker(
                                                    context: context,
                                                    initialTime: startPickedTime
                                                        .replacing(
                                                        hour: startPickedTime
                                                            .hour +
                                                            1),
                                                  );
                                                  if (endPickedTime !=
                                                      null) {
                                                    // Convert to 24-hour format (HH:mm)
                                                    String endTime =
                                                    formatTo24Hour(
                                                        endPickedTime);

                                                    // Update the controller with the time range
                                                    controller.text =
                                                    '$startTime - $endTime';
                                                  }
                                                }
                                              },
                                              child: AbsorbPointer(
                                                child: TextField(
                                                  controller: controller,
                                                  decoration:
                                                  InputDecoration(
                                                    fillColor: white,
                                                    filled: true,
                                                    // Enable the background fill
                                                    border:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          dimen8),
                                                      borderSide:
                                                      BorderSide(
                                                        color:
                                                        textf_borderColor, // Border color
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          dimen8),
                                                      borderSide:
                                                      BorderSide(
                                                        color:
                                                        textf_borderColor, // Border color when focused
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          dimen8),
                                                      borderSide:
                                                      BorderSide(
                                                        color:
                                                        textf_borderColor, // Border color when enabled
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Add button only for the last TextField
                                          if (index ==
                                              controllers.length - 1)
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: appTheme,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      dimen8),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () =>
                                                      provider
                                                          .add_day_Field(day),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );

// Helper function to format TimeOfDay to 24-hour format (HH:mm)
                                  String _formatTo24Hour(TimeOfDay time) {
                                    final hour = time.hour < 10
                                        ? '0${time.hour}'
                                        : time.hour.toString();
                                    final minute = time.minute < 10
                                        ? '0${time.minute}'
                                        : time.minute.toString();
                                    return '$hour:$minute';
                                  }
                                })
                                    .values
                                    .toList(),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          provider.UpdateSchedule(context);
                        },
                        child: Container(

                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                            color: secondaryTextColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              Languages.of(context)!.update_schedule,
                              style: semiBoldTextStyle(
                                fontSize: 16.0,
                                color: colWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

}
