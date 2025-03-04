import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  String btnName;
  Color bgColor;
  Color borderColor;
  GestureTapCallback onTap;
  double radius;
  double elevation;
  TextStyle textStyle;
  double height;


  GlobalButton(this.btnName, this.bgColor, this.borderColor,
      this.onTap, this.radius, this.elevation, this.textStyle,this.height ,{super.key});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed:onTap,
        style: ElevatedButton.styleFrom(
            elevation:elevation,
            backgroundColor:bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              side: BorderSide(color: borderColor,width: 1)
            ),

            textStyle:textStyle),
        child: Container(
          height: height,
         // padding: const EdgeInsets.only(top:12,bottom: 12),
          alignment: Alignment.center,
          width: double.infinity,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius:BorderRadius.circular(radius),
                // border: Border.all(color: borderColor,width: 1)
            ),
            child: Text(btnName,style: textStyle)));
  }
}
