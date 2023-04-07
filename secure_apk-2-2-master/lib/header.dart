import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset("images/banner.png"),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              "Welcome to secure",
              style: TextStyle(
                  color: Color.fromRGBO(123, 34, 83, 1),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
