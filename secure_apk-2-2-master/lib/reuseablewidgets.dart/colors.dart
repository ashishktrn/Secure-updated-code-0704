import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var Global_User_theme = Color.fromRGBO(123, 34, 83, 1);
var securePurpleColor = Color.fromRGBO(123, 34, 83, 1); //Value=0
const DarkBlue = Color.fromRGBO(90, 129, 153, 1); //Value=1
const DarkBrown = Color.fromRGBO(111, 91, 80, 1); //Value=2
const liteGreen = Color.fromRGBO(134, 184, 165, 1); //Value=3

//Loading bars

Widget circularBird() {
  return CircleAvatar(
    maxRadius: 23.r,
    backgroundColor: Colors.white,
    child: Container(
      margin: EdgeInsets.all(2.0),
      child: Image(
        color: Global_User_theme,
        image: AssetImage("images/bird.png"),
        alignment: Alignment.centerLeft,
      ),
    ),
  );
}
