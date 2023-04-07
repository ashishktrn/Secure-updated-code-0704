import 'package:flutter/material.dart';
import 'package:secure_apk/models/attendanceinformation_model.dart';
import 'package:secure_apk/data_grid_tables/tablefor_attendancedetails.dart';
import 'AttendancePageUsingMLAuth.dart';
import 'reuseablewidgets.dart/colors.dart';

class AttendanceInformationDetails extends StatefulWidget {
  const AttendanceInformationDetails({Key? key}) : super(key: key);

  @override
  State<AttendanceInformationDetails> createState() =>
      _AttendanceInformationDetailsState();
}

class _AttendanceInformationDetailsState
    extends State<AttendanceInformationDetails> {
  late List<AttendanceInformationModel> areaList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pipo History"),
          elevation: 1,
          shadowColor: Colors.white,
          backgroundColor: Global_User_theme,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.pushNamed(context, "attendancePage");

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => AttandencePageUisngMl(
              //               image: null,
              //               isPunchInOrOut: null,
              //             )));

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => showcasewidget()));
            },
            color: Colors.black,
          ),
          actions: [circularBird()],
        ),
        body: DataTablee2());
  }
}
