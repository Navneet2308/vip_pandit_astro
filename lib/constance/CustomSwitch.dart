import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;
  final String activeText;
  final String inactiveText;
  final double textSize;

  CustomSwitch({
    required this.value,
    required this.onToggle,
    this.activeText = "ON",
    this.inactiveText = "OFF",
    this.textSize = 13.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!value),
      child:
      value?
      Container(
        height: 35.0,
        width: 60.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.end,
            children: [
              SizedBox(width: 4),
              Text(
                activeText,
                style: TextStyle(fontSize: textSize, color: Colors.white),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 34.0,
                  width: 34.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                      boxShadow:[
                  BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  blurRadius: 1,
                  spreadRadius: 0,
                  offset: Offset(
                    0,
                    1,
                  ),
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.22),
                  blurRadius: 1,
                  spreadRadius: 0,
                  offset: Offset(
                  0,
                  1,
                ),
              ), BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.22),
                  blurRadius: 1,
                  spreadRadius: 0,
                  offset: Offset(
                  0,
                  1,
                ),
              ),BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.22),
                  blurRadius: 1,
                  spreadRadius: 0,
                  offset: Offset(
                  0,
                  1,
                ),
              ),

            ]

          ),
                ),
              ),
            ],
          ),
        ),
      ):
      Container(
        height: 35.0,
        width: 60.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment:
             MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 34.0,
                  width: 34.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                      boxShadow:[
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          blurRadius: 1,
                          spreadRadius: 0,
                          offset: Offset(
                            0,
                            1,
                          ),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.22),
                          blurRadius: 1,
                          spreadRadius: 0,
                          offset: Offset(
                            0,
                            1,
                          ),
                        ), BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.22),
                          blurRadius: 1,
                          spreadRadius: 0,
                          offset: Offset(
                            0,
                            1,
                          ),
                        ),BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.22),
                          blurRadius: 1,
                          spreadRadius: 0,
                          offset: Offset(
                            0,
                            1,
                          ),
                        ),

                      ]
                  ),
                ),
              ),
              SizedBox(width: 4),
              Text(
                 inactiveText,
                style: TextStyle(fontSize: textSize, color: Colors.white),
              ),
              SizedBox(width: 4),

            ],
          ),
        ),
      ),
    );
  }
}
