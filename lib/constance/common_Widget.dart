import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'language/language.dart';
import 'my_colors.dart';

Widget buildDatePickerField(
  BuildContext context,
  String label,
  String hintText,
  Function(String) onChanged,
  String selectedDate,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Heading with consistent padding and style
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          label,
          style: regularTextStyle(fontSize: dimen15, color: Colors.black),
        ),
      ),
      const SizedBox(height: 8), // Spacing between label and field
  GestureDetector(
  onTap: () async {
  DateTime today = DateTime.now();
  DateTime firstDate = label == Languages.of(context)!.sugggest_time_interview
  ? today.add(Duration(days: 1)) // Enforce selecting a date after today
      : DateTime(1900);
  DateTime lastDate = label == Languages.of(context)!.sugggest_time_interview
  ? DateTime(2100)
      : DateTime(2025);

  DateTime initialDate = firstDate.isAfter(DateTime(2010)) ? firstDate : DateTime(2010);
  DateTime? pickedDate = await showDatePicker(
  context: context,
  initialDate: initialDate,
  firstDate: firstDate,
  lastDate: lastDate,
  );

  if (pickedDate != null) {
  String formattedDate =
  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
  onChanged(formattedDate);
  }
  },
  child: Container(
  width: double.infinity,
  margin: const EdgeInsets.symmetric(horizontal: 15.0),
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
  decoration: BoxDecoration(
  border: Border.all(color: Colors.grey, width: 0.5),
  borderRadius: BorderRadius.circular(10),
  ),
  child: Text(
  selectedDate.isEmpty ? hintText : selectedDate,
  style: TextStyle(
  color: selectedDate.isEmpty ? Colors.grey : Colors.black,
  fontSize: 16,
  ),
  ),
  ),
  ),
    ],
  );
}

Widget buildHalfWidthTextField(
    BuildContext context,
  String label,
  String hintText,
  Function(String) onChanged,
  String value,
) {
  int? maxLength;
  TextInputType keyboardType = TextInputType.text;

  if (label==(Languages.of(context)!.pincode)){
    keyboardType = TextInputType.number;
    maxLength = 6;
  } else if (label==(Languages.of(context)!.exp_in_year)) {
    keyboardType = TextInputType.number;
    maxLength = 10;
  } else if (label==(Languages.of(context)!.callChargePerMin)) {
    keyboardType = TextInputType.number;
    maxLength = 10;
  }
  else if (label==(Languages.of(context)!.chatChargePerMin)) {
    keyboardType = TextInputType.number;
    maxLength = 10;
  }

  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: regularTextStyle(fontSize: dimen15, color: colBlack),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: textHint, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    initialValue: value,
                    onChanged: onChanged,
                    keyboardType: keyboardType,
                    maxLength: maxLength,
                    style: regularTextStyle(fontSize: 14.0, color: colBlack),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle:
                          regularTextStyle(fontSize: 14.0, color: textHint),
                      fillColor: colBlack,
                      counterText: "", // Hides the character counter
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTextFieldProfileBio(
    BuildContext context,
  String label,
  String hintText,
  Function(String) onChanged,
  String value,
) {
  int? maxLength;
  TextInputType keyboardType = TextInputType.text;

  if (label==(Languages.of(context)!.emailAddress))
    {
    keyboardType = TextInputType.emailAddress;
    maxLength = 100;
  } else if (label==(Languages.of(context)!.phoneNumber) ||
      label==(Languages.of(context)!.chatChargePerMin) ||
      label==(Languages.of(context)!.callChargePerMin)
  ) {
    keyboardType = TextInputType.number;
    maxLength = 10; // Adjust as needed
  }
  else if ( label==(Languages.of(context)!.pincode)) {
    keyboardType = TextInputType.number;
    maxLength = 6;
  }else if ( label==(Languages.of(context)!.phoneNumber)) {
    keyboardType = TextInputType.phone;
    maxLength = 10;
  } else if ( label==(Languages.of(context)!.adhar_card_number)) {
    keyboardType = TextInputType.number;
    maxLength = 12;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          label,
          style: regularTextStyle(fontSize: dimen15, color: colBlack),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          height: 129,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: textHint, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  initialValue: value,
                  onChanged: onChanged,
                  style: regularTextStyle(fontSize: 14.0, color: colBlack),
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle:
                        regularTextStyle(fontSize: 14.0, color: textHint),
                    counterText: "", // Hides the max length counter
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

Widget buildTextField(
    BuildContext context,
  String label,
  String hintText,
  Function(String) onChanged,
  String value,
) {
  int? maxLength;
  TextInputType keyboardType = TextInputType.text;

  if (label==(Languages.of(context)!.adhar_card_number)) {
    keyboardType = TextInputType.number;
    maxLength = 12;
  }
  else if (label==(Languages.of(context)!.account_number)) {
    keyboardType = TextInputType.number;
    maxLength = 18;
  }
  else if (label==(Languages.of(context)!.emailAddress)) {
    keyboardType = TextInputType.emailAddress;
    maxLength = 100;
  } else if (label==(Languages.of(context)!.phoneNumber)) {
    keyboardType = TextInputType.number;
    maxLength = 10;
  }  else if (label==(Languages.of(context)!.emailAddress)) {
    keyboardType = TextInputType.emailAddress;
    maxLength = 22;
  } else if (label==(Languages.of(context)!.phoneNumber) ||
      label==(Languages.of(context)!.chatChargePerMin) ||
      label==(Languages.of(context)!.callChargePerMin)
 ) {
    keyboardType = TextInputType.number;
    maxLength = 10; // Adjust as needed
  }
  else if ( label==(Languages.of(context)!.bank_ifsc_code)) {
    keyboardType = TextInputType.text;
    maxLength = 11;
  }
  else if ( label==(Languages.of(context)!.pincode)) {
    keyboardType = TextInputType.number;
    maxLength = 6;
  }
  else if (label==(Languages.of(context)!.date_time)) {
    keyboardType = TextInputType.datetime;
  }
  else if (label==(Languages.of(context)!.dateOfBirth)) {
    keyboardType = TextInputType.datetime;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          label,
          style: regularTextStyle(fontSize: dimen15, color: colBlack),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: textHint, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  initialValue: value,
                  // Sets the initial value without a controller
                  onChanged: onChanged,
                  inputFormatters: [
                    if (label==(Languages.of(context)!.bank_ifsc_code))
                      UpperCaseTextFormatter(),
                    if (label==(Languages.of(context)!.bank_name))
                      UpperCaseTextFormatter(),
                  ],
                  style: regularTextStyle(fontSize: 14.0, color: colBlack),
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle:
                        regularTextStyle(fontSize: 14.0, color: textHint),
                    counterText: "", // Hides the max length counter
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
