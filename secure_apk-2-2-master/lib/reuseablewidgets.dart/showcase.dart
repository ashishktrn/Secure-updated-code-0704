import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'colors.dart';

class CustomshowcaseWidget extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;
  const CustomshowcaseWidget({
    required this.description,
    required this.child,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) => Showcase(
        key: globalKey,
        targetPadding: EdgeInsets.all(8),
        tooltipBackgroundColor: Global_User_theme,
        descTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        tooltipPadding: EdgeInsets.all(15),
        description: description,
        child: child,
      );
}
