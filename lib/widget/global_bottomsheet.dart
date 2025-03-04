import 'package:flutter/material.dart';

class GlobalBottomSheet {

  static void show({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = false,
    Color backgroundColor = Colors.white,
    double? elevation,
    ShapeBorder? shape,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      elevation: elevation ?? 8.0,
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: child,
        );
      },
    );
  }
}
