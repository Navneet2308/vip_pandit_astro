import 'package:flutter/material.dart';

class ProgressDialog {
  static void show(BuildContext context, {String? message}) {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false, // Prevent dismissing by tapping outside
    //   builder: (context) {
    //     return Dialog(
    //       backgroundColor: Colors.white,
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //       child: Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             const CircularProgressIndicator(),
    //             const SizedBox(height: 16),
    //             Text(
    //               message ?? "Please wait...",
    //               style: const TextStyle(fontSize: 16),
    //               textAlign: TextAlign.center,
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  static void hide(BuildContext context) {
    // if (Navigator.canPop(context)) {
    //   Navigator.of(context, rootNavigator: false).pop(); // Close the dialog
    // }
  }
}
