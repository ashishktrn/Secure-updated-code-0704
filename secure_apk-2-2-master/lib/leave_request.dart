import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

import 'package:secure_apk/models/dateofjoiningdetailModel.dart';

import 'package:secure_apk/reuseablewidgets.dart/sessionexpire.dart';
import 'package:secure_apk/reuseablewidgets.dart/showcase.dart';
import 'package:showcaseview/showcaseview.dart';

// import 'package:snippet_coder_utils/FormHelper.dart';
// import 'package:snippet_coder_utils/ProgressHUD.dart';
// import 'package:snippet_coder_utils/hex_color.dart';
// import 'package:snippet_coder_utils/list_helper.dart';
// import 'package:snippet_coder_utils/multi_images_utils.dart';

//import 'package:sweetalert/sweetalert.dart';

import 'globals.dart';
import 'models/TeamLeavePlan.dart';
import 'models/eventCalenderModal.dart';
import 'reuseablewidgets.dart/Common.dart';
import 'reuseablewidgets.dart/colors.dart';
import 'reuseablewidgets.dart/loder.dart';

class showcasewidgetLeave extends StatelessWidget {
  late double leaveTypeforedit;
  late String reasonforedit;
  final KeyOne = GlobalKey();
  late String fromdateforedit;
  late String todateforedit;
  late double totaldaysforedit;
  late int edit;
  late int SerialNo;
  late String APPROVED;
  late String FROM_1HALF_FLAGforedit;
  late String FROM_2HALF_FLAGforedit;
  late String To_1HALF_FLAGforedit;
  late String To_2HALF_FLAGforedit;
  late String From_timeFor_edit;
  late String To_timeFor_edit;
  late String TYPE_OF_LEAVE;

  showcasewidgetLeave(
      {required this.reasonforedit,
      required this.edit,
      required this.SerialNo,
      required this.APPROVED,
      required this.FROM_1HALF_FLAGforedit,
      required this.FROM_2HALF_FLAGforedit,
      required this.To_1HALF_FLAGforedit,
      required this.To_2HALF_FLAGforedit,
      required this.fromdateforedit,
      required this.leaveTypeforedit,
      required this.todateforedit,
      required this.totaldaysforedit,
      required this.From_timeFor_edit,
      required this.To_timeFor_edit,
      required this.TYPE_OF_LEAVE});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ShowCaseWidget(
            builder: Builder(
      builder: ((context) => LeaveRequest(
          TYPE_OF_LEAVE: TYPE_OF_LEAVE,
          From_timeFor_edit: From_timeFor_edit,
          To_timeFor_edit: To_timeFor_edit,
          APPROVED: APPROVED,
          FROM_1HALF_FLAGforedit: FROM_1HALF_FLAGforedit,
          FROM_2HALF_FLAGforedit: FROM_2HALF_FLAGforedit,
          SerialNo: SerialNo,
          To_1HALF_FLAGforedit: To_1HALF_FLAGforedit,
          To_2HALF_FLAGforedit: To_2HALF_FLAGforedit,
          edit: edit,
          fromdateforedit: fromdateforedit,
          leaveTypeforedit: leaveTypeforedit,
          reasonforedit: reasonforedit,
          todateforedit: todateforedit,
          totaldaysforedit: totaldaysforedit)),
    )));
  }
}

class LeaveRequest extends StatefulWidget {
//  const LeaveRequest({Key? key}) : super(key: key);

  late double leaveTypeforedit;
  late String reasonforedit;
  final KeyOne = GlobalKey();
  late String fromdateforedit;
  late String todateforedit;
  late double totaldaysforedit;
  late int edit;
  late int SerialNo;
  late String APPROVED;
  late String FROM_1HALF_FLAGforedit;
  late String FROM_2HALF_FLAGforedit;
  late String To_1HALF_FLAGforedit;
  late String To_2HALF_FLAGforedit;
  late String From_timeFor_edit;
  late String To_timeFor_edit;
  late String TYPE_OF_LEAVE;

  LeaveRequest(
      {required this.reasonforedit,
      required this.edit,
      required this.SerialNo,
      required this.APPROVED,
      required this.FROM_1HALF_FLAGforedit,
      required this.FROM_2HALF_FLAGforedit,
      required this.To_1HALF_FLAGforedit,
      required this.To_2HALF_FLAGforedit,
      required this.fromdateforedit,
      required this.leaveTypeforedit,
      required this.todateforedit,
      required this.totaldaysforedit,
      required this.From_timeFor_edit,
      required this.To_timeFor_edit,
      required this.TYPE_OF_LEAVE});

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  var serialno;
  //Only Date And Time
  DateTime? date;
  // TimeOfDay? time;
  bool _showReasonDropDown_Visiblity = false;
  bool _showNormalReasonBox_Visiblity = true;
  List? rhReasonList;
  String _myReason = '1.0';
  bool _myReasonBool = true;
  TimeOfDay? pickedTime2;
  late var TeamLeaveData;

  TimeOfDay? mainTime;
  TimeOfDay? mainTime2;
  DateTime? pickedDate;
  DateTime? pickedDate2;
  // DateTime? mainDate;

  //onlyINDateAndTime
  DateTime? date2;
  // TimeOfDay? time2;
  DateTime? dateTime;
  TimeOfDay? pickedTime;
  var isRhDisable;

  //OnlyOutDateAndTime

  // DateTime? date3;
  // TimeOfDay? time3;
  // DateTime? OutdateTime;
  //!<------------Toggle buttons varibles--------------->
  bool ShortLeaveButton = false;
  bool FromDate1stHalf = false;
  bool FromDate2ndHalf = false;
  bool toDate1stHalf = false;
  bool toDate2ndHalf = false;
  //!<------------Toggle buttons varibles--------------->
  bool isvisiblity = true;
  bool isvisiblity2 = false;
  bool isvisiblity3 = true;
  bool isvisiblity4 = false;
  bool shortLeaveToggleVisiblity = false;
  late Duration difference;
  bool total = false;
  bool leaveSelect = true;
  bool showRhLeave = false;
  var itemmm;
  var no_of_days;
  bool sameDate = false;
  bool _myLeaveBool = true;
  bool _loadingForReasonDropdown = true;

  bool _myRHbool = true;
  bool isRhselected = false;
  bool isRhselected2forReasonBox = false;
  var resonForRh = "Reason here";

  List? leaveList;
  List? rhLeaveList;
  String _myLeave = '2.0';
  String _myRh = '4.0';
  var myRhLeaveDate;
  var REASON_MASTER_SELECT;

  var short_count;
  var leave_Count_FromApi;
  var rowId_FromDropDown;
  var rowId_FromRhDropDown;
  var leaveCode;
  var availed_RH_date;
  //late FromTime fromTimeClass;
  late String valueLeaveFrom;
  late int stastusLeaveFrom;
  late String valueLeaveTo;
  late int stastusLeaveTo;
  late String messageTo;
  //late TimeOfDay _selectedTime;
  var timeFrombackEnd;
  var date_of_joining;
  late DateOfJoiningModel dateOfJoiningModel;
  var chkYearLvBlnce;
  bool rhLeaveCircularbool = true;
  bool saveApiResponse = false;
  bool isAlertboxOpened = false;
  late sessionExpired sessionexpired = new sessionExpired(context);
  late CalendarCarousel _calendarCarouselNoHeader;
  late List<Map<DateTime, String>> HrleavesDates = [];

  List<Map<String, dynamic>> pendingLeaveDates = [];
  List<Map<String, dynamic>> WeeklyOffandHolidayDates = [];
  List<Map<String, dynamic>> approvedLeaveDates = [];
  var Pending_leave_listLength = 0;
  var WeeklyOffandHolidayDates_length = 0;
  var approved_leave_listLength = 0;
  late List<EventCalenderModalForRH> emplist;
  late List<EventCalenderModalForPendingLeaves> EventCalenderPendingLeavemodal;
  late List<EventCalenderModalForPendingLeaves> EventCalenderapprovedLeavemodal;
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  late List<EventCalenderModalForHolidayAndWeeklyOff>
      EventCalenderapprovedWeeklyOffModal;
  bool isapiloding = true;
  var length = 0;

  late double cHeight;
  bool _EventCalenderLoder = true;

//!<------------------function for Date select-------------------------------------->
  String? getDateText() {
    if (date == null) {
      return "Select Date";
    } else {
      toDate.text = DateFormat.yMd().format(date!);
      return DateFormat('MM/dd/yyyy').format(date!);

      // return "${date!.month}/${date!.day}/${date!.year}";
    }
  }

  String? getDateText2() {
    if (date2 == null) {
      return "Select Date";
    } else {
      fromDate.text = DateFormat.yMd().format(date2!);
      return DateFormat('MM/dd/yyyy').format(date2!);
      // return "${date!.month}/${date!.day}/${date!.year}";
    }
  }
  //<------------------function for Date select-------------------------------------->

  // String? getTimeText() {
  //   if (time == null) {
  //     return "In Time And Date";
  //   } else {
  //     final hours = time!.hour.toString().padLeft(2, '0');
  //     final minutes = time!.minute.toString().padLeft(2, '0');
  //     return "$hours:$minutes";
  //     // return "${time!.hour} : ${time!.minute} ${time!.period}";
  //   }
  // }

  // String? getDateAndTimeText() {
  //   if (dateTime == null) {
  //     return "In Date And Time";
  //   } else {
  //     return DateFormat('MM/dd/yyyy - HH:mm').format(dateTime!);
  //   }
  // }

  // String? getOutDateAndTimeText() {
  //   if (OutdateTime == null) {
  //     return "Out Date And Time";
  //   } else {
  //     return DateFormat('MM/dd/yyyy - HH:mm').format(OutdateTime!);
  //   }
  // }

  // final _CreatLeaveFormkey = GlobalKey<FormState>();
  TextEditingController toDate = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController Reason = TextEditingController();
  TextEditingController inTime = TextEditingController();

  TextEditingController outTime = TextEditingController();

  TextEditingController dropDownController = TextEditingController();
  TextEditingController noOfDaysController = TextEditingController();
  TextEditingController FromtimeData = TextEditingController();
  TextEditingController Totimedata = TextEditingController();

  String? restrictedID;
  TextEditingController restricted_holidays = TextEditingController();
  TextEditingController reason_For_Restricted_Holidays =
      TextEditingController();
  List<dynamic> leave = [];
  List<dynamic> restricted_leave = [];
  bool _leaveListCircularBool = true;
  late List<TeamLeavePlan> TeamLeaveList;
  bool _haveTeamLeavePlan = false;

  String? leaveId;

  convertTimeforedit(String time) {
    // var time = "23:43";
    var temp = int.parse(time.split(':')[0]);
    String? t;
    if (temp >= 12 && temp < 24) {
      t = " PM";
    } else {
      t = " AM";
    }
    if (temp > 12) {
      temp = temp - 12;
      if (temp < 10) {
        time = time.replaceRange(0, 2, "0$temp");
        time += t;
      } else {
        time = time.replaceRange(0, 2, "$temp");
        time += t;
      }
    } else if (temp == 00) {
      time = time.replaceRange(0, 2, '12');
      time += t;
    } else {
      time += t;
    }
    print(time);
    //fromHoursController.text = time;
    return time;
  }

  late bool hasInternet;
  final KeyOne = GlobalKey();
  final introShown = GetStorage();
  @override
  void initState() {
    isAlertboxOpened = false;
    // TODO: implement initState
    introShown.writeIfNull("LeaveShowcase", false);

    Future.delayed(Duration.zero, () async {
      final connected = await InternetConnectionChecker().hasConnection;
      if (connected) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   displaySheet();
        // });
        GetTeamLeavePlan();
        // PendingLeaveOfEmployee();
        ApprovedLeavesOFEmployee();

        apiForUserDetails();
        _getRHDropDownList();
        _getLeaveList();
        _getTourLeaveReason();
        if (introShown.read("LeaveShowcase") != true) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ShowCaseWidget.of(context).startShowCase([KeyOne]);
          });
          introShown.write("LeaveShowcase", true);
        }
      }
    });
    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      if (!mounted) return;
      setState(() => this.hasInternet = hasInternet);
      if (!this.hasInternet) {
      } else {
        GetTeamLeavePlan();
        ApprovedLeavesOFEmployee();

        apiForUserDetails();
        _getRHDropDownList();
        _getLeaveList();
        _getTourLeaveReason();
      }
    });

    if (widget.edit == 1) {
      setState(() {
        total = true;
        no_of_days = widget.totaldaysforedit.toString();
      });

      leaveCode = widget.TYPE_OF_LEAVE;
      // if (leaveCode == "D") {
      //   shortLeaveToggleVisiblity = true;
      // }

      if (leaveCode == "X") {
        _myLeave = "-1.0";
        rowId_FromDropDown = "-1.0";
        _myRh = widget.leaveTypeforedit.toString();
        rowId_FromRhDropDown = widget.leaveTypeforedit.toString();
      } else {
        _myLeave = widget.leaveTypeforedit.toString();
        rowId_FromDropDown = widget.leaveTypeforedit.toString();
      }
      _myLeaveBool = false;

      if (leaveCode == "X") {
        setState(() {
          total = false;
          isRhselected = true;
          isRhselected2forReasonBox = true;
          leaveSelect = false;
          showRhLeave = true;
          ShortLeaveButton = false;
          _myRHbool = false;
        });
        fromDate.text = DateFormat('dd-MMM-yyyy')
            .format(DateTime.parse(widget.fromdateforedit));

        resonForRh = widget.reasonforedit;

        toDate.text = DateFormat('dd-MMM-yyyy')
            .format(DateTime.parse(widget.todateforedit));

        // fromDate.clear();
        // toDate.clear();
        // outTime.clear();
        // inTime.clear();
        // FromtimeData.clear();
        // Totimedata.clear();
      } else {
        if (widget.FROM_1HALF_FLAGforedit == "Y") {
          FromDate1stHalf = true;
        }
        if (widget.FROM_2HALF_FLAGforedit == "Y") {
          FromDate2ndHalf = true;
        }
        if (widget.To_1HALF_FLAGforedit == "Y") {
          toDate1stHalf = true;
        }
        if (widget.To_2HALF_FLAGforedit == "Y") {
          toDate2ndHalf = true;
        }

        if (no_of_days == "0.25") {
          setState(() {
            shortLeaveToggleVisiblity = true;
            ShortLeaveButton = true;
            isvisiblity = !isvisiblity;
            isvisiblity2 = !isvisiblity2;
            isvisiblity3 = !isvisiblity3;
            isvisiblity4 = !isvisiblity4;
            inTime.text = convertTimeforedit(widget.From_timeFor_edit);

            outTime.text = convertTimeforedit(widget.To_timeFor_edit);
          });
          pickedTime = TimeOfDay(
              hour: int.parse(widget.To_timeFor_edit.split(":")[0]),
              minute: int.parse(widget.To_timeFor_edit.split(":")[1]));
          pickedTime2 = TimeOfDay(
              hour: int.parse(widget.From_timeFor_edit.split(":")[0]),
              minute: int.parse(widget.From_timeFor_edit.split(":")[1]));
        }
        fromDate.text = DateFormat('dd-MMM-yyyy')
            .format(DateTime.parse(widget.fromdateforedit));

        Reason.text = widget.reasonforedit;

        toDate.text = DateFormat('dd-MMM-yyyy')
            .format(DateTime.parse(widget.todateforedit));
        pickedDate = (DateTime.parse(widget.fromdateforedit));
        print(pickedDate);
        pickedDate2 = (DateTime.parse(widget.todateforedit));
        print(pickedDate2);
      }
    }
  }

  Future<List<TeamLeavePlan>> GetTeamLeavePlan() async {
    final String apiEndpoint =
        "$ServerUrl/api/LeaveAPI/TeamLeavePlan?CPF_NO=$globalInt";

    Response? response =
        await myHttpClient.GetMethod(apiEndpoint, "leaveRequest", true);
    // final Uri url = Uri.parse(apiEndpoint);
    // final response = await get(
    //   url,
    //   headers: {
    //     "MobileURL": "Adjustmentapprovalpage",
    //     "CPF_NO": globalInt.toString(),
    //     "Authorization": "Bearer $JWT_Tokken"
    //   },
    // );

    if (response!.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var returnData = json.decode(response.body);

        TeamLeaveData = returnData["Table"];
        TeamLeaveList = [];
        if (TeamLeaveData.length > 0) {
          setState(() {
            _haveTeamLeavePlan = true;
          });
          var decode = json.decode(response.body);
          var data = decode['Table'];

          var resultsJson = data.cast<Map<String, dynamic>>();
          TeamLeaveList = await resultsJson
              .map<TeamLeavePlan>((json) => TeamLeavePlan.fromJson(json))
              .toList();
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              'Error!',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      displaySheet();
    });
    return TeamLeaveList;
  }

  void displaySheet() {
    showDialog(
      context: context,
      builder: (dialogeeecontext) => Center(
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              scrollDirection: Axis.vertical,
              child: Card(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Column(
                    children: [
                      ExpansionTile(
                        iconColor: Global_User_theme,
                        textColor: Global_User_theme,
                        backgroundColor: Colors.white10,
                        title: Text("Team leave plan"),
                        children: [
                          _haveTeamLeavePlan
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 3.2,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 5,
                                          color: Colors.grey.shade300,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 9,
                                                  top: 5,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text("Name: "),
                                                    Text(TeamLeaveList[index]
                                                        .EMP_NAME)
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 9,
                                                  top: 5,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text("Employee Id: "),
                                                    Text(TeamLeaveList[index]
                                                        .CPF_NO
                                                        .toInt()
                                                        .toString())
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 9,
                                                  top: 5,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text("Leave Type: "),
                                                    Text(TeamLeaveList[index]
                                                        .LEAVE_TYPE)
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 9,
                                                  top: 5,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text("From Date: "),
                                                    Text(TeamLeaveList[index]
                                                        .FROM_DATE)
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 9,
                                                  top: 5,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text("To Date: "),
                                                    Text(TeamLeaveList[index]
                                                        .TO_DATE)
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 9,
                                                  top: 5,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text("Days: "),
                                                    Text(TeamLeaveList[index]
                                                        .NO_OF_DAYS
                                                        .toString())
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 9,
                                                  top: 5,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text("Status: "),
                                                    Text(TeamLeaveList[index]
                                                        .STATUS)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: TeamLeaveList.length,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("No record"),
                                )
                        ],
                      )
                    ],
                  ),
                ),
              ))),
    );
  }

//!<-----------Function for short leave toggle button press---------------------->
  onChangedFunction1(bool newValue1) {
    // if (pickedDate == null) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("Please select from date")));
    //   return;
    // }
    setState(() {
      total = true;
      ShortLeaveButton = newValue1;
      isvisiblity = !isvisiblity;
      isvisiblity2 = !isvisiblity2;
      isvisiblity3 = !isvisiblity3;
      isvisiblity4 = !isvisiblity4;
      inTime.clear();
      outTime.clear();

      if (ShortLeaveButton == true) {
        no_of_days = "0.25";
      } else if (ShortLeaveButton == false) {
        no_of_days = "1";
      }
      if (fromDate.text != toDate.text) {
        toDate.text = fromDate.text;
        pickedDate2 = pickedDate;
      }
      if (FromDate1stHalf == true ||
          FromDate2ndHalf == true ||
          toDate1stHalf == true ||
          toDate2ndHalf == true) {
        FromDate1stHalf = false;
        FromDate2ndHalf = false;
        toDate1stHalf = false;
        toDate2ndHalf = false;
      }
    });
    if (ShortLeaveButton == true) {
      shortLeaveButtonApi();
    }
  }
  //!<-----------Function for short leave toggle button press---------------------->

  onChangedFunction2(bool newValue2) {
    setState(() {
      FromDate1stHalf = newValue2;
      print(FromDate1stHalf);
      calculate_no_of_days();
      FromDate2ndHalf = false;
    });
  }

  onChangedFunction3(bool newValue3) {
    setState(() {
      FromDate2ndHalf = newValue3;
      print(FromDate2ndHalf);
      calculate_no_of_days();
      FromDate1stHalf = false;
    });
  }

  onChangedFunction4(bool newValue4) {
    setState(() {
      toDate1stHalf = newValue4;
      calculate_no_of_days();
      toDate2ndHalf = false;
    });
  }

  onChangedFunction5(bool newValue5) {
    setState(() {
      toDate2ndHalf = newValue5;
      calculate_no_of_days();
      toDate1stHalf = false;
    });
  }

//!<--------------Function for date difference or no of days -------------------->
  void dateDifference() {
    if (pickedDate2 == null) {
      var start = pickedDate;
      var end = pickedDate2;
      difference = pickedDate!.difference(start!);
      noOfDaysController.text = difference.inDays.toString();
      calculate_no_of_days();

      // setState(() {
      //   total = true;
      // });

      print(difference.inDays);
    }
    // else if (pickedDate2 == null || pickedDate == null) {
    //   print("ok");
    // }
    else {
      var start = pickedDate;
      var end = pickedDate2;
      difference = pickedDate2!.difference(start!);
      noOfDaysController.text = difference.inDays.toString();

      setState(() {
        total = true;
      });

      print(difference.inDays);
    }
  }

  //!<--------------Function for date difference or no of days -------------------->

  //late String _myState = 'PAID LEAVE (D) ';

  Future _getTourLeaveReason() async {
    try {
      Map data = {"ID": "1", "Flag": "TOUR_MASTER"};
      String jsonString = json.encode(data);
      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl//api/MasterAPIAttendance/GetQuery"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt,
      //       "Content-Type": "application/json",
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: jsonString);
      String _apiendpoint = "$ServerUrl//api/MasterAPIAttendance/GetQuery";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      var jsonBody = response!.body;

      if (jsonBody.isNotEmpty) {
        var jsonData = json.decode(jsonBody);
        setState(() {
          rhReasonList = jsonData['Table'];
          _loadingForReasonDropdown = false;
        });
      } else {
        if (!isAlertboxOpened) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Error! No response from server',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
        setState(() => isAlertboxOpened = true); //
      }
      // setState(() {
      //   rhReasonList = jsonData['Table'];
      //   _loadingForReasonDropdown = false;
      // });
    } catch (e) {
      if (!isAlertboxOpened) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No response from server',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }

      setState(() => isAlertboxOpened = true); //
    } finally {
      setState(() {
        _loadingForReasonDropdown = false;
      });
    }
  }

//!<--------------API call for drop down list of leave type-------------------->
  Future _getLeaveList() async {
    try {
      Map data = {
        'cpfNo': globalInt.toString(),
        'ouId': ouId.toString(),
        'Flag': 'GET_LEAVE_EMP'
      };
      // String jsonString = json.encode(data);
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);

      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt,
      //       "Authorization": "Bearer $JWT_Tokken",
      //       "Content-Type": "application/json"
      //     },
      //     body: jsonString
      //     //  jsonEncode(<String, String>{
      //     //   "cpfNo": "45061",
      //     //   "ouId": "94",
      //     //   "Flag": "GET_LEAVE_EMP"
      //     // })
      //     );

      // print(headerr());
      var jsonBody = response!.body;
      // print(response.body);

      if (jsonBody.isNotEmpty) {
        var jsonData = json.decode(jsonBody);
        setState(() {
          leaveList = jsonData['Table'];
          _leaveListCircularBool = false;
        });
        print(leaveList);
      } else {
        if (!isAlertboxOpened) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Error! No response from server',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
        setState(() => isAlertboxOpened = true); //
      }
    } catch (e) {
      if (!isAlertboxOpened) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No response from server',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
      setState(() => isAlertboxOpened = true); //
    } finally {
      setState(() {
        _leaveListCircularBool = false;
      });
    }
  }

  //!<--------------API call for drop down list of leave type-------------------->
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  //!<--------------API call for Rh leave drop down list -------------------->
  Future _getRHDropDownList() async {
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouId": ouId.toString(),
        "Flag": "GET_RH_DETAIL_EMP"
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouId": ouId.toString(),
      //       "Flag": "GET_RH_DETAIL_EMP"
      //     });

      var jsonBody = response!.body;
      print(response.body);
      print(jsonBody);

      if (jsonBody.isNotEmpty) {
        var jsonData = json.decode(jsonBody);
        setState(() {
          rhLeaveList = jsonData['Table'];
          // _leaveListCircularBool = false;
          rhLeaveCircularbool = false;
        });
      } else {
        if (!isAlertboxOpened) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Error! No response from server',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
        setState(() => isAlertboxOpened = true); //
      }

      print(rhLeaveList);
    } catch (e) {
      if (!isAlertboxOpened) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No response from server',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
      setState(() => isAlertboxOpened = true); //
    } finally {
      setState(() {
        rhLeaveCircularbool = false;
      });
    }
  }

  //!<--------------API call for Rh leave drop down list -------------------->
  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  //!<--------------API call for  Short time toggle button list of leave type-------------------->

  Future shortLeaveButtonApi() async {
    try {
      Map data = {"cpfNo": globalInt.toString(), "serialNo": "0"};
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/sl_count";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/sl_count"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "serialNo": "0"
      //     }
      // );

      leave_Count_FromApi = json.decode(response!.body);
      print(leave_Count_FromApi);
    } catch (e) {
      print(e);
    }

    if (leave_Count_FromApi >= short_count.toInt()) {
      // SweetAlert.show(context,
      //     title: "Error",
      //     subtitle: "You cannot applly for short leave",
      //     style: SweetAlertStyle.error);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Error',
        desc: "You cannot apply for short leave",
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      )..show();
      setState(() {
        ShortLeaveButton = false;
        isvisiblity = !isvisiblity;
        isvisiblity2 = !isvisiblity2;
        isvisiblity3 = !isvisiblity3;
        isvisiblity4 = !isvisiblity4;
      });
    }
  }
  //!<--------------API call for  Short time toggle button list of leave type-------------------->

  Future fromTimeApi() async {
    try {
      if (fromDate.text.isNotEmpty) {
        if (inTime.text.isNotEmpty) {
          Map data = {
            "cpfNo": globalInt.toString(),
            "ouID": ouId.toString(),
            "fromDate": fromDate.text,
            "toDate": toDate.text,
            "fromTime": inTime.text,
            "toTime": "",
            "leaveId": rowId_FromDropDown.toString(),
            "leaveCode": leaveCode.toString(),
          };
          String _apiendpoint = "$ServerUrl/api/LeaveAPI/validate_sl_from_time";
          Response? response = await myHttpClient.PostMethod(
              _apiendpoint, data, "leaveRequest", true);
          // Response response = await post(
          //     Uri.parse(
          //         "$ServerUrl/api/LeaveAPI/validate_sl_from_time"),
          //     headers: {
          //       "MobileURL": "leaveRequest",
          //       "CPF_NO": globalInt.toString(),
          //       "Authorization": "Bearer $JWT_Tokken"
          //     },
          //     body: {
          //       "cpfNo": globalInt.toString(),
          //       "ouID": ouId.toString(),
          //       "fromDate": fromDate.text,
          //       "toDate": toDate.text,
          //       "fromTime": inTime.text,
          //       "toTime": "",
          //       "leaveId": rowId_FromDropDown.toString(),
          //       "leaveCode": leaveCode.toString(),
          //     });

          if (response!.statusCode == 200) {
            setState(() {
              Map<String, dynamic> map = jsonDecode(response.body);

              valueLeaveFrom = map['value'];
              stastusLeaveFrom = map['status'];
              print(valueLeaveFrom);
            });
          }
          if (stastusLeaveFrom == 0) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error")));
          } else {
            // outTime.text = valueLeaveFrom;
            // pickedTime = valueLeaveFrom as TimeOfDay?;
            // String time = getTime(valueLeaveFrom);
            // TimeOfDay startTime = TimeOfDay(
            //     hour: int.parse(time.split(":")[0]),
            //     minute: int.parse(time.split(":")[1]));

            // final hours = startTime.hour.toString().padLeft(2, '0');
            // final minutes = startTime.minute.toString().padLeft(2, '0');
            // var currentTime = '$hours:$minutes';
            // print(currentTime);

            convertTime(valueLeaveFrom);
            setState(() {
              Totimedata.text = valueLeaveFrom;
              pickedTime = TimeOfDay(
                  hour: int.parse(valueLeaveFrom.split(":")[0]),
                  minute: int.parse(valueLeaveFrom.split(":")[1]));
            });
            print(Totimedata);
            // convertTimeToSecond(valueLeaveFrom);
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("From date cannot be left blank")));
      }
    } catch (e) {
      print(e);
    }
  }

  Future toTimeApi() async {
    try {
      if (toDate.text.isNotEmpty) {
        if (inTime.text == "") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("From time cannot be left blank")));
        } else {
          Map data = {
            "cpfNo": globalInt.toString(),
            "ouID": ouId.toString(),
            "fromDate": fromDate.text,
            "toDate": toDate.text,
            "fromTime": inTime.text,
            "toTime": outTime.text,
            "leaveId": rowId_FromDropDown.toString(),
            "leaveCode": leaveCode.toString(),
          };
          String _apiendpoint = "$ServerUrl/api/LeaveAPI/validate_sl_to_time";
          Response? response = await myHttpClient.PostMethod(
              _apiendpoint, data, "leaveRequest", true);
          // Response response = await post(
          //     Uri.parse(
          //         "$ServerUrl/api/LeaveAPI/validate_sl_to_time"),
          //     headers: {
          //       "MobileURL": "leaveRequest",
          //       "CPF_NO": globalInt.toString(),
          //       "Authorization": "Bearer $JWT_Tokken"
          //     },
          //     body: {
          //       "cpfNo": globalInt.toString(),
          //       "ouID": ouId.toString(),
          //       "fromDate": fromDate.text,
          //       "toDate": toDate.text,
          //       "fromTime": inTime.text,
          //       "toTime": outTime.text,
          //       "leaveId": rowId_FromDropDown.toString(),
          //       "leaveCode": leaveCode.toString(),
          //     });

          if (response!.statusCode == 200) {
            setState(() {
              Map<String, dynamic> mapp = jsonDecode(response.body);

              valueLeaveTo = mapp['value'];
              stastusLeaveTo = mapp['status'];
              messageTo = mapp['message'];
            });
            print(messageTo);
            print(response.body);
          }
          if (stastusLeaveTo == 0) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(messageTo.toString())));
            convertTime2(valueLeaveTo);
            setState(() {
              Totimedata.text = valueLeaveFrom;
              pickedTime = null;
              //pickedTime = Totimedata.text;
              pickedTime = TimeOfDay(
                  hour: int.parse(Totimedata.text.split(":")[0]),
                  minute: int.parse(Totimedata.text.split(":")[1]));
            });
            print(Totimedata);
            // convertTimeToSecond(valueLeaveFrom);
          } else {
            if (valueLeaveFrom.isNotEmpty) {
              outTime.text = outTime.text;
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  convertTime(String time) {
    // var time = "23:43";
    var temp = int.parse(time.split(':')[0]);
    String? t;
    if (temp >= 12 && temp < 24) {
      t = " PM";
    } else {
      t = " AM";
    }
    if (temp > 12) {
      temp = temp - 12;
      if (temp < 10) {
        time = time.replaceRange(0, 2, "0$temp");
        time += t;
      } else {
        time = time.replaceRange(0, 2, "$temp");
        time += t;
      }
    } else if (temp == 00) {
      time = time.replaceRange(0, 2, '12');
      time += t;
    } else {
      time += t;
    }
    print(time);
    outTime.text = time;
  }

  convertTime2(String time) {
    // var time = "23:43";
    var temp = int.parse(time.split(':')[0]);
    String? t;
    if (temp >= 12 && temp < 24) {
      t = "PM";
    } else {
      t = " AM";
    }
    if (temp > 12) {
      temp = temp - 12;
      if (temp < 10) {
        time = time.replaceRange(0, 2, "0$temp");
        time += t;
      } else {
        time = time.replaceRange(0, 2, "$temp");
        time += t;
      }
    } else if (temp == 00) {
      time = time.replaceRange(0, 2, '12');
      time += t;
    } else {
      time += t;
    }
    print(time);
    outTime.text = time;
  }

  convertTimeTo24(String time) {
    var maintime222;
    var date = time.toString().split(":");

    var date2 = date[1].toString().split(" ");
    var minutes = date2[0];
    var timeZone = date2[1];
    if (timeZone == "PM" && date[0] != "12") {
      var intdate = int.parse(date[0]);
      intdate += 12;
      maintime222 = "$intdate:$minutes";
      print(maintime222);
      setState(() {
        FromtimeData.text = maintime222;
      });
    } else if (date[0] == "12" && timeZone == "AM") {
      date[0] = "00";
      var amhours = date[0];
      FromtimeData.text = "$amhours:$minutes";
    } else {
      var hours = date[0];

      FromtimeData.text = "$hours:$minutes";
    }
  }

  convertTimeToSecond(String time) {
    var maintime222;
    var date = time.toString().split(":");

    var date2 = date[1].toString().split(" ");
    var minutes = date2[0];
    var timeZone = date2[1];
    if (timeZone == "PM" && date[0] != "12") {
      var intdate = int.parse(date[0]);
      intdate += 12;
      maintime222 = "$intdate:$minutes";
      print(maintime222);
      setState(() {
        Totimedata.text = maintime222;
      });
    } else if (date[0] == "12" && timeZone == "AM") {
      date[0] = "00";
      var amhours = date[0];
      Totimedata.text = "$amhours:$minutes";
    } else {
      var hours = date[0];

      Totimedata.text = "$hours:$minutes";
    }
  }

//!<-------------------------------FromDAte Validation Funcations---------------------------------------------------------------------------------------------------->
  fromDateValidationsFunction() async {
    if (rowId_FromDropDown == null || rowId_FromDropDown == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select the leave type")));
      fromDate.clear();

      return;
    } else {
      if (toDate.text.isNotEmpty) {
        if (pickedDate!.isAfter(pickedDate2!)) {
          setState(() {
            //pickedDate2 = pickedDate;
            toDate.text = fromDate.text;
          });
        }
      }
      if (fromDate.text.isNotEmpty) {
        var dateres = await isValiddate(fromDate.text);
        if (dateres) {
          if (toDate.text.isNotEmpty && fromDate.text == toDate.text) {}
          if (dateOfJoiningModel.DATE_OF_JOINING != "") {
            var dateFromapi =
                dateOfJoiningModel.DATE_OF_JOINING.toString().split("T");

            var date = dateFromapi[0].toString().split("-");
            print(date);
            var year = int.parse(date[0]);
            var month = int.parse(date[1]);
            var day = int.parse(date[2]);
            var joining_date = new DateTime(year, month, day);
            if (pickedDate!.isBefore(joining_date)) {
              fromDate.clear();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Leave entry from date cannot be before date of joining.")));
              return;
            }
            var restrict_flag = await funRestrict(fromDate.text);
            if (restrict_flag == true) {
              fromDate.clear();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "You are not allowed to enter leave for previous month")));
              return;
            }
            if (toDate.text.isNotEmpty) {
              if (pickedDate!.isAfter(pickedDate2!)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("From date must be before To date")));
                return;
              }
              if (ShortLeaveButton == true &&
                  fromDate.text != "" &&
                  toDate.text != "") {
                toDate.text = fromDate.text;
              }
            } else if (toDate.text == "") {
              toDate.text = fromDate.text;
            }
            // var chk_bal_flag = await check_balance();
            // if (chk_bal_flag) {

            // }
            if (leaveCode == "X") {
              if (await calculate_no_of_days() > 1) {
                toDate.text = fromDate.text;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Restricted holiday can be applied for 1 day only.")));
                return;
              }
              var RH_exist = await isRhExist();
              if (RH_exist != "X") {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("No such RH in list this year.")));
                return;
              } else {
                toDate.text = fromDate.text;
              }
            }
          }
          if (toDate.text != "") {
            var result = await proc_days();
            if (result == false) {
              fromDate.clear();
              toDate.clear();
              return false;
            }
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Invalid date format!")));
          fromDate.clear();
        }
      }
    }
  }

  proc_days() async {
    var val_from_flag = false;
    var val_to_flag = false;
    if (FromDate1stHalf == true || FromDate2ndHalf == true) {
      val_from_flag = true;
    }
    if (toDate1stHalf == true || toDate2ndHalf == true) {
      val_to_flag = true;
    }
    if (leaveCode == "E" || leaveCode == "C") {
      var result = await isLeaveType();
      if (result != null && result != leaveCode) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "You cannot apply $leaveCode in association with other Leave")));
        fromDate.clear();
        return;
      }
    }
    if (ShortLeaveButton == true) {
      var count = await chk_sl_onHoliday();
      if (count > 0) {
        return false;
      }
    } else {
      //!<-------------------------------Look after ------------------------------------------->
      if (fromDate.text.isNotEmpty) {
        var val_no_days = await calculate_no_of_days();
        setState(() {
          no_of_days = val_no_days.toString();
        });
      }
      //!<-------------------------------Look after ------------------------------------------->
      if (leaveCode == "E" ||
          leaveCode == "D" ||
          leaveCode == "K" ||
          leaveCode == "C") {
        var leaveonholidaycount = await check_leave_onHoliday();
        if (leaveonholidaycount == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("You are applying leave on holiday.")));
          return;
        }
      }
      if (leaveCode == "E" ||
          leaveCode == "D" ||
          leaveCode == "I" ||
          leaveCode == "C") {
        var leav = await year_leave_bal();
        var noofdayss;
        if (no_of_days.toString().contains(".")) {
          noofdayss = double.parse(no_of_days);
        } else {
          noofdayss = int.parse(no_of_days);
        }

        if (noofdayss > leav) {
          if (leav == 0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Your selected leave balance is empty.")));
            return false;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "You can avail maximum of $chkYearLvBlnce selected leave")));
            return false;
          }
        }
      }
      if (leaveCode == "C") {
        var max_cl = await v_max_cleav();
        if (max_cl == 1) {
          return false;
        }
      }
      if (leaveCode == "X") {
        print(no_of_days);
        var noofdays = int.parse(no_of_days);
        if (noofdays != 1) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text("Restricted holiday can be applied for 1 day only")));
          return false;
        }
        var RH_exist = await isRhExist();
        if (RH_exist != "X") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("No such RH in list this year")));
          return false;
        }
      }
      if (leaveCode == "E" || leaveCode == "D") {
        var lvCnt = await chkLeaveCount();
      }
    }
    return true;
  }

  chkLeaveCount() async {
    var lvcount = 0;
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/chkleaveOnHoliday";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/chkleaveOnHoliday"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //     });

      var responsefromapi = json.decode(response!.body);
      if (responsefromapi != null) {
        lvcount = responsefromapi;
      } else {
        return false;
      }
      return lvcount;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  v_max_cleav() async {
    var max_val = 0;
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/chkleaveOnHoliday";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/chkleaveOnHoliday"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //     });

      var responsefromapi = json.decode((response!.body));
      if (responsefromapi != null) {
        var noofdays = int.parse(no_of_days);
        if (noofdays > responsefromapi) {
          max_val = 1;
        }
      } else {
        return false;
      }
      return max_val;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  year_leave_bal() async {
    var leav = 0.0;
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "leaveCode": leaveCode.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/CheckLeavBalance";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/CheckLeavBalance"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "leaveCode": leaveCode.toString(),
      //     });

      var responsefromapi = json.decode(response!.body);
      if (responsefromapi != null) {
        leav = responsefromapi;
      }

      return leav;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  check_leave_onHoliday() async {
    var mcout = 0;
    var daycount = 0;
    Map data = {
      "cpfNo": globalInt.toString(),
      "ouID": ouId.toString(),
      "fromDate": fromDate.text,
      "toDate": toDate.text,
      "leaveId": rowId_FromDropDown.toString(),
      "leaveCode": leaveCode.toString(),
    };
    try {
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/chkleaveOnHoliday";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/chkleaveOnHoliday"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "fromDate": fromDate.text,
      //       "toDate": toDate.text,
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //     });

      var responsefromapi = json.decode(response!.body);
      if (responsefromapi != null) {
        mcout = responsefromapi;
        bool yes = no_of_days.toString().contains(".");

        if (yes) {
          var doubleconvertgap = double.parse(no_of_days);
          doubleconvertgap = doubleconvertgap - mcout;
          setState(() {
            no_of_days = doubleconvertgap.toString();
          });
        } else {
          var intconvertgap = int.parse(no_of_days);
          intconvertgap = intconvertgap - mcout;
          setState(() {
            no_of_days = intconvertgap.toString();
          });
          if (intconvertgap <= 0) {
            daycount = 1;
          }
        }
      }
      return daycount;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  chk_sl_onHoliday() async {
    var mcont = 1;
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "fromDate": fromDate.text,
        "toDate": toDate.text,
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/chkleaveOnHoliday";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/chkleaveOnHoliday"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "fromDate": fromDate.text,
      //       "toDate": toDate.text,
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //     });

      var responseFromApi = json.decode(response!.body);
      if (responseFromApi != null) {
        mcont = responseFromApi;
        if (responseFromApi > 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("You are applying Short Leave on Holiday")));
          fromDate.clear();
          toDate.clear();
        } else {
          setState(() {
            no_of_days = "0.25";
          });
        }
      }
      return mcont;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      fromDate.clear();
      toDate.clear();
    }
  }

  isLeaveType() async {
    var val_exist;
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "fromDate": fromDate.text,
        "toDate": toDate.text,
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/LeaveCurChk";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/LeaveCurChk"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "fromDate": fromDate.text,
      //       "toDate": toDate.text,
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //     });

      var responseFromApi = json.decode(response!.body);
      if (responseFromApi != null && responseFromApi != "") {
        val_exist = responseFromApi;
      }
      return val_exist;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  isRhExist() async {
    var val_exist;
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "fromDate": fromDate.text,
        "toDate": toDate.text,
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/CheckRHExist";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/CheckRHExist"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "fromDate": fromDate.text,
      //       "toDate": toDate.text,
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //     });

      var responsefromapi = json.decode(response!.body);
      print(responsefromapi);
      if (responsefromapi != null) {
        val_exist = responsefromapi;
      }
      return val_exist;
    } catch (e) {
      print(e);
    }
  }

  check_balance() async {
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "fromDate": fromDate.text,
        "toDate": toDate.text,
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/CheckLeavBalance";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);

      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/CheckLeavBalance"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "fromDate": fromDate.text,
      //       "toDate": toDate.text,
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //     });

      var responnsfromapi = json.decode(response!.body);
      print(responnsfromapi);
      var responsefromapi = json.decode(response.body);
      if (responsefromapi != null) {
        if ((toDate.text == "" || toDate.text == null) &&
            (leaveCode == "C" ||
                leaveCode == "D" ||
                leaveCode == "E" ||
                leaveCode == "K")) {
          if (responnsfromapi > 0.5 && leaveCode == "C")
            toDate.text = fromDate.text;
        }
      }
      if (responnsfromapi > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  funRestrict(frmDAte) async {
    var return_flag_val = false;
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "fromDate": fromDate.text,
        "toDate": toDate.text,
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/RestrictInsertUpdateLeave";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl/api/LeaveAPI/RestrictInsertUpdateLeave"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "fromDate": fromDate.text,
      //       "toDate": toDate.text,
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //     });

      var responsefromapi = json.decode(response!.body);
      if (responsefromapi != null) {
        if (response.body == "true") {
          return_flag_val = true;
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      return_flag_val = true;
    }
    return return_flag_val;
  }

  isValiddate(testdate) {
    var splt = testdate.toString().split("-");
    var year = int.parse(splt[2]);
    var month = getMonthNumber(splt[1]);
    var day = int.parse(splt[0]);

    var d = new DateTime(year, month, day);
    if (d.year == year && d.month == month && d.day == day) {
      return true;
    }
    return false;
  }

  getMonthNumber(month) {
    if (month == "jan" || month == "Jan") {
      return 1;
    } else if (month == "feb" || month == "Feb") {
      return 2;
    } else if (month == "Mar" || month == "mar") {
      return 3;
    } else if (month == "Apr" || month == "apr") {
      return 4;
    } else if (month == "May" || month == "may") {
      return 5;
    } else if (month == "jun" || month == "Jun") {
      return 6;
    } else if (month == "Jul" || month == "jul") {
      return 7;
    } else if (month == "Aug" || month == "aug") {
      return 8;
    } else if (month == "Sep" || month == "sep") {
      return 9;
    } else if (month == "Oct" || month == "oct") {
      return 10;
    } else if (month == "Nov" || month == "nov") {
      return 11;
    } else if (month == "Dec" || month == "dec") {
      return 12;
    }
  }

  //!<-------------------------------FromDAte Validation Functions---------------------------------------------------------------------------------------------------->
  toDateChangeValiditions() async {
    if (rowId_FromDropDown == null || rowId_FromDropDown == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select the leave type")));
      toDate.clear();
      return;
    } else {
      if (toDate.text.isNotEmpty) {
        var dateres = await isValiddate(fromDate.text);
        if (dateres) {
          if (fromDate.text.isNotEmpty && fromDate == toDate) {}
          if (toDate.text.isNotEmpty) {
            if (pickedDate!.isAfter(pickedDate2!)) {
              toDate.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("To date must be after From date")));
              return false;
            }
            var dateFromapi =
                dateOfJoiningModel.DATE_OF_JOINING.toString().split("T");

            var date = dateFromapi[0].toString().split("-");
            print(date);
            var year = int.parse(date[0]);
            var month = int.parse(date[1]);
            var day = int.parse(date[2]);
            var joining_date = new DateTime(year, month, day);
            if (pickedDate2!.isBefore(joining_date)) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Leave entry to date cannot be before date of joining")));
              return false;
            }
            if (ShortLeaveButton == true && fromDate.text.isNotEmpty) {
              final difference = pickedDate2!.difference(pickedDate!).inDays;
              if (difference != 0) {
                setState(() {
                  toDate.text = fromDate.text;
                  pickedDate2 = pickedDate;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "From date and To date must be same for short leave")));
                no_of_days = "0.25";
                return false;
              }
            }
            var result = await proc_days();
            if (result == false) {
              toDate.clear();
              setState(() {
                no_of_days = "0";
              });

              return false;
            } else {}
          }
        } else {
          no_of_days = null;
        }
      }
    }
  }

  Future _GetweekellyOFFAndHolidayList() async {
    Map data = {
      "cpfNo": globalInt.toString(),
      "ouId": ouId,
      "Flag": "GET_REST_HOLIDAY_DETAIL_EMP",
    };
    String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery";
    Response? response = await myHttpClient.PostMethod(
        _apiendpoint, data, "Leave_Balance", true);
    // Response response;
    // response = await post(
    //     Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery"),
    //     headers: {
    //       "MobileURL": "Leave_Balance",
    //       "CPF_NO": globalInt.toString(),
    //       "Authorization": "Bearer $JWT_Tokken"
    //     },
    //     body: {
    //       "cpfNo": globalInt.toString(),
    //       "ouId": ouId,
    //       "Flag": "GET_REST_HOLIDAY_DETAIL_EMP",
    //     });

    try {
      if (response!.statusCode == 200) {
        var decode = json.decode(response.body);
        var data = decode['Table'];
        var resultsJson = data.cast<Map<String, dynamic>>();
        EventCalenderapprovedWeeklyOffModal = await resultsJson
            .map<EventCalenderModalForHolidayAndWeeklyOff>((json) =>
                EventCalenderModalForHolidayAndWeeklyOff.fromJson(json))
            .toList();
        var i = 0;
        for (var leaveData in EventCalenderapprovedWeeklyOffModal) {
          String Reason = EventCalenderapprovedWeeklyOffModal[i].REASON;
          DateTime Dates = EventCalenderapprovedWeeklyOffModal[i].DATES;
          String RestHolidayFlag =
              EventCalenderapprovedWeeklyOffModal[i].REST_HOLIDAY;
          Map<String, dynamic> Holidays = {
            'Dates': Dates,
            'reason': Reason,
            'RestHolidayFlag': RestHolidayFlag
          };
          i++;
          WeeklyOffandHolidayDates.add(Holidays);
        }
        WeeklyOffandHolidayDates_length = WeeklyOffandHolidayDates.length;
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              '_GetweekellyOFFAndHolidayList $e',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  Future GetRhListOfEmployee() async {
    Map data = {
      "cpfNo": globalInt.toString(),
      "Flag": "GET_RH_DETAIL_EMP",
    };
    String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery";
    Response? response = await myHttpClient.PostMethod(
        _apiendpoint, data, "Leave_Balance", true);
    // Response response;
    // response = await post(
    //     Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery"),
    //     headers: {
    //       "MobileURL": "Leave_Balance",
    //       "CPF_NO": globalInt.toString(),
    //       "Authorization": "Bearer $JWT_Tokken"
    //     },
    //     body: {
    //       "cpfNo": globalInt.toString(),
    //       "Flag": "GET_RH_DETAIL_EMP",
    //     });

    try {
      _eventCalenderLoderclose(true, true, true);
      var decode = json.decode(response!.body);
      var data = decode['Table'];
      var resultsJson = data.cast<Map<String, dynamic>>();
      emplist = await resultsJson
          .map<EventCalenderModalForRH>(
              (json) => EventCalenderModalForRH.fromJson(json))
          .toList();
      HrleavesDates = emplist
          .map((event) => {
                event.RH_DATE: event.RH_NAME,
              })
          .toList();
      //  HrleavesDates = emplist.map((data) => data.RH_DATE).toList();

      length = HrleavesDates.length;
      setState(() {
        isapiloding = false;
      });
    } catch (e) {
      print(e);
      Navigator.pop(context);
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              'GetRhListOfEmployee $e',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  void _eventCalenderLoderclose(
      bool PendingLeaveApi, bool RHLeaveApi, bool approvedLeaveApi) {
    if (PendingLeaveApi && RHLeaveApi && approvedLeaveApi) {
      setState(() {
        _EventCalenderLoder = false;
      });
    }
  }

  Future PendingLeaveOfEmployee() async {
    //!-- errro in this api in mobile test
    Map data = {
      "cpfNo": globalInt.toString(),
      "Flag": "PENDING_LEAVES",
      "ouId": ouId
    };
    String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery";
    Response? response = await myHttpClient.PostMethod(
        _apiendpoint, data, "Leave_Balance", true);
    // Response response;
    // response = await post(
    //     Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery"),
    //     headers: {
    //       "MobileURL": "Leave_Balance",
    //       "CPF_NO": globalInt.toString(),
    //       "Authorization": "Bearer $JWT_Tokken"
    //     },
    //     body: {
    //       "cpfNo": globalInt.toString(),
    //       "Flag": "PENDING_LEAVES",
    //       "ouId": ouId
    //     });

    _eventCalenderLoderclose(true, true, true);
    GetRhListOfEmployee();
    try {
      var decode = json.decode(response!.body);
      var data = decode['Table'];
      var resultsJson = data.cast<Map<String, dynamic>>();
      EventCalenderPendingLeavemodal = await resultsJson
          .map<EventCalenderModalForPendingLeaves>(
              (json) => EventCalenderModalForPendingLeaves.fromJson(json))
          .toList();
      // PendingLevaesDates = EventCalenderPendingLeavemodal.map(
      //     (event) => {event.FROM_DATE: "from_date"}).toList();
      var i = 0;
      for (var leaveData in EventCalenderPendingLeavemodal) {
        String? Reason = EventCalenderPendingLeavemodal[i].REASON;
        DateTime? todatepending = EventCalenderPendingLeavemodal[i].TO_DATE;
        DateTime? fromDate = EventCalenderPendingLeavemodal[i].FROM_DATE;
        double? No_of_days = EventCalenderPendingLeavemodal[i].NO_OF_DAYS;
        String? leaveType = EventCalenderPendingLeavemodal[i].LEAVE;
        Map<String, dynamic> leave = {
          'fromDate': fromDate,
          'toDate': todatepending,
          'numberOfDays': No_of_days,
          'reason': Reason,
          'leaveType': leaveType
        };
        i++;
        pendingLeaveDates.add(leave);
      }

      Pending_leave_listLength = pendingLeaveDates.length;

      // HrleavesDates = emplist
      //     .map((event) => {
      //           event.RH_DATE: event.RH_NAME,
      //         })
      //     .toList();

      //length = HrleavesDates.length;
      // setState(() {
      //   isapiloding = false;
      // });
    } catch (e) {
      print(e);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              "PendingLeaveOfEmployee $e",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  Future ApprovedLeavesOFEmployee() async {
    //!-- errro in this api in mobile test
    Map data = {
      "cpfNo": globalInt,
      "ouID": ouId.toString(),
      "Flag": "LEAVE_HISTORY"
    };
    String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery";
    Response? response = await myHttpClient.PostMethod(
        _apiendpoint, data, "Leave_Balance", true);
    // Response response;
    // response = await post(
    //     Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery"),
    //     headers: {
    //       "MobileURL": "Leave_Balance",
    //       "CPF_NO": globalInt.toString(),
    //       "Authorization": "Bearer $JWT_Tokken"
    //     },
    //     body: {
    //       "cpfNo": globalInt,
    //       "ouID": ouId.toString(),
    //       "Flag": "LEAVE_HISTORY"
    //     });

    _GetweekellyOFFAndHolidayList();
    PendingLeaveOfEmployee();
    _eventCalenderLoderclose(true, false, false);

    try {
      var decode = json.decode(response!.body);
      var data = decode['Table'];
      var resultsJson = data.cast<Map<String, dynamic>>();
      EventCalenderapprovedLeavemodal = await resultsJson
          .map<EventCalenderModalForPendingLeaves>(
              (json) => EventCalenderModalForPendingLeaves.fromJson(json))
          .toList();

      var i = 0;
      for (var leaveData in EventCalenderapprovedLeavemodal) {
        String? Reason = EventCalenderapprovedLeavemodal[i].REASON;
        DateTime? todatepending = EventCalenderapprovedLeavemodal[i].TO_DATE;
        DateTime? fromDate = EventCalenderapprovedLeavemodal[i].FROM_DATE;
        double? No_of_days = EventCalenderapprovedLeavemodal[i].NO_OF_DAYS;
        String? leaveType = EventCalenderapprovedLeavemodal[i].LEAVE_NAME;
        Map<String, dynamic> leave = {
          'fromDate': fromDate,
          'toDate': todatepending,
          'numberOfDays': No_of_days,
          'reason': Reason,
          'leaveType': leaveType
        };
        i++;
        approvedLeaveDates.add(leave);
      }

      approved_leave_listLength = approvedLeaveDates.length;
    } catch (e) {
      print(e);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              'ApprovedLeavesOFEmployee $e',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  DateTime _currentDate2 = DateTime.now();
  static Widget _approvedLeaveIcon(String day) => CircleAvatar(
        backgroundColor: Color.fromRGBO(134, 184, 165, 1),
        child: Text(
          day,
          style: TextStyle(color: Colors.black),
        ),
      );
  static Widget _HolidayandWeeklyoff(String day) => CircleAvatar(
        backgroundColor: Color.fromRGBO(98, 164, 186, 1),
        child: Text(
          day,
          style: TextStyle(color: Colors.black),
        ),
      );
  static Widget _pendingLeaveIcon(String day) => CircleAvatar(
        backgroundColor: Color.fromRGBO(222, 174, 42, 1),
        child: Text(
          day,
          style: TextStyle(color: Colors.black),
        ),
      );
  static Widget _rhLeaveIcon(String day) => CircleAvatar(
        backgroundColor: Color.fromRGBO(235, 121, 33, 1),
        child: Text(
          day,
          style: TextStyle(color: Colors.black),
        ),
      );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    toDate.dispose();
    fromDate.dispose();
    reason_For_Restricted_Holidays.dispose();
    restricted_holidays.dispose();
    Totimedata.dispose();
    Reason.dispose();
    noOfDaysController.dispose();
    dropDownController.dispose();
    inTime.dispose();
    outTime.dispose();
    FromtimeData.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < WeeklyOffandHolidayDates_length; i++) {
      _markedDateMap.add(
        WeeklyOffandHolidayDates[i]["Dates"],
        new Event(
          date: WeeklyOffandHolidayDates[i]["Dates"],
          title: WeeklyOffandHolidayDates[i]["reason"],
          icon: _HolidayandWeeklyoff(
            WeeklyOffandHolidayDates[i]["Dates"].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < approved_leave_listLength; i++) {
      print(approvedLeaveDates[i]['fromDate']);
      print(approvedLeaveDates[i]['toDate']);
      if (approvedLeaveDates[i]['fromDate'] !=
          approvedLeaveDates[i]['toDate']) {
        Duration difference = approvedLeaveDates[i]['toDate']
            .difference(approvedLeaveDates[i]['fromDate']);
        if (difference.inDays == 1) {
          List<DateTime> _AdditionalDates = [];
          _AdditionalDates.add(approvedLeaveDates[i]['fromDate']);
          _AdditionalDates.add(approvedLeaveDates[i]['toDate']);
          for (int j = 0; j < _AdditionalDates.length; j++) {
            _markedDateMap.add(
              _AdditionalDates[j],
              new Event(
                date: _AdditionalDates[j],
                title: 'Event 7',
                icon: _approvedLeaveIcon(
                  _AdditionalDates[j].day.toString(),
                ),
              ),
            );
          }
        } else if (difference.inDays > 1) {
          List<DateTime> _Additional_dates = [];
          for (DateTime date = approvedLeaveDates[i]['fromDate'];
              date.isBefore(approvedLeaveDates[i]['toDate']) ||
                  date.isAtSameMomentAs(approvedLeaveDates[i]['toDate']);
              date = date.add(Duration(days: 1))) {
            _Additional_dates.add(date);
          }
          for (int k = 0; k < _Additional_dates.length; k++) {
            _markedDateMap.add(
              _Additional_dates[k],
              new Event(
                date: _Additional_dates[k],
                title: 'Event 7',
                icon: _approvedLeaveIcon(
                  _Additional_dates[k].day.toString(),
                ),
              ),
            );
          }
        }
      }
      _markedDateMap.add(
        approvedLeaveDates[i]['fromDate'],
        new Event(
          date: approvedLeaveDates[i]['fromDate'],
          title: 'Event 7',
          icon: _approvedLeaveIcon(
            approvedLeaveDates[i]['fromDate'].day.toString(),
          ),
        ),
      );
    }
    for (int i = 0; i < Pending_leave_listLength; i++) {
      print(pendingLeaveDates[i]['fromDate']);
      print(pendingLeaveDates[i]['toDate']);
      if (pendingLeaveDates[i]['fromDate'] != pendingLeaveDates[i]['toDate']) {
        Duration difference = pendingLeaveDates[i]['toDate']
            .difference(pendingLeaveDates[i]['fromDate']);
        if (difference.inDays == 1) {
          List<DateTime> _AdditionalDates = [];
          _AdditionalDates.add(pendingLeaveDates[i]['fromDate']);
          _AdditionalDates.add(pendingLeaveDates[i]['toDate']);
          for (int j = 0; j < _AdditionalDates.length; j++) {
            _markedDateMap.add(
              _AdditionalDates[j],
              new Event(
                date: _AdditionalDates[j],
                title: 'Event 7',
                icon: _pendingLeaveIcon(
                  _AdditionalDates[j].day.toString(),
                ),
              ),
            );
          }
        } else if (difference.inDays > 1) {
          List<DateTime> _Additional_dates = [];
          for (DateTime date = pendingLeaveDates[i]['fromDate'];
              date.isBefore(pendingLeaveDates[i]['toDate']) ||
                  date.isAtSameMomentAs(pendingLeaveDates[i]['toDate']);
              date = date.add(Duration(days: 1))) {
            _Additional_dates.add(date);
          }
          for (int k = 0; k < _Additional_dates.length; k++) {
            _markedDateMap.add(
              _Additional_dates[k],
              new Event(
                date: _Additional_dates[k],
                title: 'Event 7',
                icon: _pendingLeaveIcon(
                  _Additional_dates[k].day.toString(),
                ),
              ),
            );
          }
        }
      }
      _markedDateMap.add(
        pendingLeaveDates[i]['fromDate'],
        new Event(
          date: pendingLeaveDates[i]['fromDate'],
          title: 'Event 7',
          icon: _pendingLeaveIcon(
            pendingLeaveDates[i]['fromDate'].day.toString(),
          ),
        ),
      );
    }
    for (int i = 0; i < length; i++) {
      _markedDateMap.add(
        HrleavesDates[i].keys.first,
        new Event(
          date: HrleavesDates[i].keys.first,
          title: HrleavesDates[0].values.toString(),
          icon: _rhLeaveIcon(
            HrleavesDates[i].keys.first.day.toString(),
          ),
        ),
      );
    }
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      //iconColor: Global_User_theme,
      showOnlyCurrentMonthDate: true,
      headerTextStyle: TextStyle(color: Colors.black),
      iconColor: Colors.black,
      height: cHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Colors.grey,
      ),
      onDayPressed: (p0, p1) async {
        String eventTitle = '';

        for (Map<String, dynamic> leaveDate in approvedLeaveDates) {
          DateTime datefilter = leaveDate["fromDate"];

          if (p0 == datefilter ||
              p0 == leaveDate["toDate"] ||
              (p0.isAfter(datefilter) && p0.isBefore(leaveDate["toDate"]))) {
            if (datefilter != leaveDate["toDate"]) {
              String Leave_from_date =
                  DateFormat('EEEE, MMMM d, y').format(datefilter).toString();
              String Leave_to_date = DateFormat('EEEE, MMMM d, y')
                  .format(leaveDate["toDate"])
                  .toString();
              var leaveType = leaveDate["leaveType"];
              var reason = leaveDate['reason'];
              var no_of_days = leaveDate['numberOfDays'];

              String show_date = "$Leave_from_date to $Leave_to_date";
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    // <-- SEE HERE
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(

                                          // color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  show_date,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text("Availed : $leaveType"),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              FittedBox(
                                                  child:
                                                      Text("Reason : $reason")),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "Days : $no_of_days",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });

              return;
              // }
            }
          }
          if (p0 == datefilter) {
            var leaveType = leaveDate["leaveType"];
            var reason = leaveDate['reason'];
            var no_of_days = leaveDate['numberOfDays'];
            eventTitle = leaveType;
            if (eventTitle.isNotEmpty) {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    // <-- SEE HERE
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(

                                          // color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  DateFormat('EEEE, MMMM d, y')
                                                      .format(p0),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text("Availed : $leaveType"),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              FittedBox(
                                                  child:
                                                      Text("Reason : $reason")),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "Days : $no_of_days",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
              return;
              break;
            }
          }
        }

        for (Map<String, dynamic> leaveDate in pendingLeaveDates) {
          // for pendiong leave
          DateTime datefilter = leaveDate["fromDate"];

          if (p0 == datefilter ||
              p0 == leaveDate["toDate"] ||
              (p0.isAfter(datefilter) && p0.isBefore(leaveDate["toDate"]))) {
            if (datefilter != leaveDate["toDate"]) {
              // bool isDateBetween(
              //     DateTime fromDate, DateTime Clicked_Date, DateTime To_date) {
              //   return Clicked_Date.isAfter(fromDate) &&
              //       Clicked_Date.isBefore(To_date);
              // }

              // if (isDateBetween(datefilter, p0, leaveDate["toDate"])) {
              String Leave_from_date =
                  DateFormat('EEEE, MMMM d, y').format(datefilter).toString();
              String Leave_to_date = DateFormat('EEEE, MMMM d, y')
                  .format(leaveDate["toDate"])
                  .toString();
              var leaveType = leaveDate["leaveType"];
              var reason = leaveDate['reason'];
              var no_of_days = leaveDate['numberOfDays'];

              String show_date = "$Leave_from_date to $Leave_to_date";
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    // <-- SEE HERE
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(

                                          // color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  show_date,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text("Applied : $leaveType"),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              FittedBox(
                                                  child:
                                                      Text("Reason : $reason")),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "Days : $no_of_days",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });

              return;
              // }
            }
          }
          if (p0 == datefilter) {
            var leaveType = leaveDate["leaveType"];
            var reason = leaveDate['reason'];
            var no_of_days = leaveDate['numberOfDays'];
            eventTitle = leaveType;
            if (eventTitle.isNotEmpty) {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    // <-- SEE HERE
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(

                                          // color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  DateFormat('EEEE, MMMM d, y')
                                                      .format(p0),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text("Applied : $leaveType"),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              FittedBox(
                                                  child:
                                                      Text("Reason : $reason")),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "Days : $no_of_days",
                                              ),

                                              // Container(
                                              //   color: Colors.red,
                                              //   child: Text(
                                              //     "Applied : help",
                                              //     style: TextStyle(fontSize: 10),
                                              //   ),
                                              // ),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              // Text(
                                              //   "Reason : $reason",
                                              //   style: TextStyle(fontSize: 18),
                                              // ),
                                              // SizedBox(
                                              //   height: 5.h,
                                              // ),
                                              // Text(
                                              //   "Days : $no_of_days",
                                              //   style: TextStyle(fontSize: 18),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
              return;
              break;
            }
          }
        }
        if (eventTitle.isNotEmpty == false) {
          for (Map<String, dynamic> holidayDate in WeeklyOffandHolidayDates) {
            if (p0 == holidayDate["Dates"] &&
                holidayDate["RestHolidayFlag"] == "H") {
              String _HolidayReason = holidayDate["reason"];
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    // <-- SEE HERE
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        padding: EdgeInsets.all(40),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 9.9,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(

                                          // color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  DateFormat('EEEE, MMMM d, y')
                                                      .format(p0),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                _HolidayReason,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
              return;
            }
          }
          for (Map<DateTime, String> leaveDate in HrleavesDates) {
            leaveDate.forEach((key, value) {
              print('Leave date: $key');

              if (p0 == key) {
                eventTitle = 'RH for $value';
                return;
              }
            });
            if (eventTitle.isNotEmpty) {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    // <-- SEE HERE
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        padding: EdgeInsets.all(40),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 9.9,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(

                                          // color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  DateFormat('EEEE, MMMM d, y')
                                                      .format(p0),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "$eventTitle",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });

              break;
            }
          }
        }
      },
      todayButtonColor: Global_User_theme,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );
    return Scaffold(
      floatingActionButton: CustomshowcaseWidget(
        globalKey: KeyOne,
        description: "Pending/History Leaves & Leave Balance",
        child: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Global_User_theme,
          overlayColor: Colors.black,
          overlayOpacity: 0.6,
          buttonSize: Size(40.0, 45.0),
          spaceBetweenChildren: 1,
          //spacing: 10,
          children: [
            SpeedDialChild(
                child: Icon(
                  Icons.pending,
                  color: Colors.white,
                ),
                label: 'Pending leaves',
                labelBackgroundColor: Global_User_theme,
                labelStyle: TextStyle(color: Colors.white),
                elevation: 0,
                backgroundColor: Global_User_theme,
                onTap: () {
                  Navigator.pushNamed(context, "Pending_leaves");
                }),
            SpeedDialChild(
                child: Icon(
                  Icons.paid,
                  color: Colors.white,
                ),
                label: 'Leave balance',
                labelBackgroundColor: Global_User_theme,
                labelStyle: TextStyle(color: Colors.white),
                backgroundColor: Global_User_theme,
                onTap: () {
                  Navigator.pushNamed(context, "Leave_Balance");
                }),
            SpeedDialChild(
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                label: 'leave History',
                labelBackgroundColor: Global_User_theme,
                labelStyle: TextStyle(color: Colors.white),
                backgroundColor: Global_User_theme,
                onTap: () {
                  Navigator.pushNamed(context, "Leave_history");
                })
          ],
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 1,
        backgroundColor: Global_User_theme,
        title: Text(
          "Leave Request",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Container(
          //   margin: EdgeInsets.all(6.0),
          //   child: Image(
          //     image: AssetImage("images/bird.png"),
          //     alignment: Alignment.centerLeft,
          //   ),
          // ),
          IconButton(
            onPressed: () {
              ShowCalender();
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return Dialog(
              //       child: Container(
              //         height: 400,
              //         width: 300,
              //         child: CalendarPage2(),
              //       ),
              //     );
              //   },
              // );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => CalendarPage2()),
              // );
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //       builder: (BuildContext context) => CalendarPage2()),
              // );
            },
            icon: Icon(Icons.calendar_month_sharp),
          ),
          circularBird()
        ],
      ),
      body: (_loadingForReasonDropdown &&
              _leaveListCircularBool &&
              rhLeaveCircularbool)
          ? Center(
              child: CustomLoader(
                dotColor: Global_User_theme,
              ),
            )
          :

          //  _loadingForReasonDropdown
          //     ? Center(
          //         child: CircularProgressIndicator(color: Global_User_theme),
          //       )
          //     : _leaveListCircularBool
          //         ? Center(
          //             child: CircularProgressIndicator(color: Global_User_theme),
          //           )
          //         : rhLeaveCircularbool
          //             ? Center(
          //                 child:
          //                     CircularProgressIndicator(color: Global_User_theme),
          //               )
          //             :
          SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Form(
                child: Column(
                  children: <Widget>[
                    headerr(),

                    //pressingShortLeave(),
                    SizedBox(
                      height: 20.h,
                    ),

                    Visibility(
                      visible: leaveSelect,
                      child: Column(
                        children: [
                          fromDateLeaveBox(),
                          SizedBox(
                            height: 20.h,
                          ),
                          pressingShortLeave(),
                          fromDateToggleButtons(),
                          SizedBox(
                            height: 20.h,
                          ),
                          // Padding(

                          toDateLeaveBox(),
                          SizedBox(
                            height: 20.h,
                          ),
                          toDateToggleButtons(),
                          pressingShortLeave2box(),
                          SizedBox(
                            height: 0,
                          ),

                          // reasonAndNoOfDays(),

                          // savebutton()
                        ],
                      ),
                    ),

                    RHleave(),
                    reasonAndNoOfDays(),
                    // reasonDropDown(),
                    savebutton(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget pressingShortLeave() {
    return Visibility(
      visible: isvisiblity2,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 0.0, left: 0.0, right: 250.0),
          //   child:
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Short leave from",
              maxLines: 1,
              // textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // ),
          // title: Text(
          //   "Short leave from",
          //   style: TextStyle(fontSize: 16),
          // ),
          // trailing: Container(
          //   width: 220,

          Container(
              height: 40,
              width: 500,
              child: TextFormField(
                controller: inTime,
                decoration: InputDecoration(
                  icon: Icon(Icons.timer),
                  hintText: "Select Time",
                ),
                readOnly: true,
                onTap: () async {
                  pickedTime2 = await showTimePicker(
                    initialTime: pickedTime2 ?? TimeOfDay(hour: 12, minute: 0),
                    context: context,
                  );

                  if (pickedTime2 != null) {
                    print(pickedTime2!.format(context));
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime2!.format(context).toString());

                    print(parsedTime);
                    String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);
                    print(formattedTime); //output 14:59:00
                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                    setState(() {
                      // fromHoursController.text =
                      //     formattedTime;

                      inTime.text = formatDate(
                          DateTime(
                              2019, 08, 1, parsedTime.hour, parsedTime.minute),
                          [hh, ':', nn, " ", am]).toString();
                      fromTimeApi();
                      convertTimeTo24(inTime.text);
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              )

              // TextFormField(
              //   readOnly: true,
              //   controller: inTime,
              //   scrollPhysics: NeverScrollableScrollPhysics(),
              //   textAlign: TextAlign.justify,
              //   keyboardType: TextInputType.multiline,
              //   decoration: InputDecoration(
              //     suffixIcon: IconButton(
              //         onPressed: () {
              //           setState(() {
              //             orignalTime(context);
              //           });
              //         },
              //         icon: Icon(
              //           Icons.lock_clock_outlined,
              //           color: Colors.black,
              //           size: 30,
              //         )),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     hintText: getText(),
              //     hintStyle: mainTime != null
              //         ? TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w600,
              //           )
              //         : TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w300,
              //           ),
              //   ),
              //   validator: (inValue) {
              //     if (inValue.toString().isNotEmpty) {
              //       return "Select In Date And Time";
              //     }
              //   },
              // ),
              ),
        ]),
      ),
    );
  }

//!<------------------function for time select-------------------------------------->
  // Future orignalTime(BuildContext) async {
  //   final initialTime = TimeOfDay(hour: 12, minute: 0);
  //   final newTime = await showTimePicker(
  //       context: context, initialTime: mainTime ?? initialTime);
  //   if (newTime == null) return;
  //   setState(() {
  //     mainTime = newTime;
  //   });
  // }

  // String getText() {
  //   if (mainTime == null) {
  //     return 'Select Time';
  //   } else {
  //     inTime.text = formatDate(
  //         DateTime(2019, 08, 1, mainTime!.hour, mainTime!.minute),
  //         [hh, ':', nn, " ", am]).toString();
  //     final hours = mainTime?.hour.toString().padLeft(2, '0');
  //     final minutes = mainTime?.minute.toString().padLeft(2, '0');

  //     return '$hours : $minutes';
  //   }
  // }
  //<------------------function for time select-------------------------------------->

  Widget pressingShortLeave2box() {
    return Visibility(
      visible: isvisiblity4,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 0.0, left: 0.0, right: 270.0),
          //   child:
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Short leave to",
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // ),
          // title: Text(
          //   "Short leave from",
          //   style: TextStyle(fontSize: 16),
          // ),
          // trailing: Container(
          //   width: 220,

          Container(
              height: 40,
              width: 500,
              child: TextFormField(
                controller: outTime,
                decoration: InputDecoration(
                  icon: Icon(Icons.timer),
                  hintText: "Select Time",
                ),
                readOnly: true,
                onTap: () async {
                  pickedTime = await showTimePicker(
                    initialTime: pickedTime ?? TimeOfDay(hour: 12, minute: 0),
                    context: context,
                  );

                  if (pickedTime != null) {
                    print(pickedTime?.format(context));
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime!.format(context).toString());

                    print(parsedTime);
                    String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);
                    print(formattedTime); //output 14:59:00
                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                    setState(() {
                      // fromHoursController.text =
                      //     formattedTime;

                      outTime.text = formatDate(
                          DateTime(
                              2019, 08, 1, parsedTime.hour, parsedTime.minute),
                          [hh, ':', nn, " ", am]).toString();
                      toTimeApi();
                      convertTimeToSecond(outTime.text);
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              )

              //  TextFormField(
              //   // readOnly: true,

              //   controller: outTime,
              //   // scrollPhysics: NeverScrollableScrollPhysics(),
              //   // textAlign: TextAlign.justify,
              //   // keyboardType: TextInputType.multiline,
              //   decoration: InputDecoration(
              //     suffixIcon: IconButton(
              //         onPressed: () {
              //           setState(() {
              //             orignalTime2(context);
              //           });
              //         },
              //         icon: Icon(
              //           Icons.lock_clock_outlined,
              //           color: Colors.black,
              //           size: 30,
              //         )),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     hintText: getText2(),
              //     hintStyle: dateTime != null
              //         ? TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w600,
              //           )
              //         : TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w300,
              //           ),
              //   ),
              //   validator: (inValue) {
              //     if (inValue.toString().isNotEmpty) {
              //       return "Select In Date And Time";
              //     }
              //   },
              // ),
              ),
        ]),
      ),
    );
  }

//!<------------------function for time select-------------------------------------->
  // Future orignalTime2(BuildContext) async {
  //   final initialTime = TimeOfDay(hour: 9, minute: 0);
  //   final newTime = await showTimePicker(
  //       context: context, initialTime: mainTime2 ?? initialTime);
  //   if (newTime == null) return;
  //   setState(() {
  //     mainTime2 = newTime;
  //   });
  // }

  // String getText2() {
  //   if (mainTime2 == null) {
  //     return 'Select Time';
  //   } else {
  //     outTime.text = formatDate(
  //         DateTime(2022, 08, 1, mainTime2!.hour, mainTime2!.minute),
  //         [hh, ':', nn, " ", am]).toString();
  //     final hours = mainTime2?.hour.toString().padLeft(2, '0');
  //     final minutes = mainTime2?.minute.toString().padLeft(2, '0');

  //     return '$hours : $minutes';
  //   }
  // }

  //<------------------function for time select-------------------------------------->

  Widget headerr() {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 0.0),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Leave type",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Row(
            children: [
              Expanded(
                child: Container(
                  //width: 100.w,

                  // padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: _myLeaveBool
                            ? DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: false,
                                  child: DropdownButton<String>(
                                    hint: Text('Select leave'),

                                    iconSize: 30.h,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.sm,
                                    ),
                                    // hint: Text('Select leave'),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _myLeaveBool = false;
                                        _myLeave = newValue!;
                                        if (itemmm == "1.0") {
                                          shortLeaveToggleVisiblity = true;
                                        } else {
                                          shortLeaveToggleVisiblity = false;
                                        }

                                        // _getCitiesList();
                                        //  print(_myLeave);
                                        //print(short_count);
                                      });
                                    },
                                    items: leaveList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['LEAVETYPE']),
                                        value: item['ROW_ID'].toString(),
                                        onTap: () async {
                                          itemmm =
                                              item['SHORT_FLAG'].toString();
                                          short_count = item['SHORT_COUNT'];
                                          rowId_FromDropDown = item['ROW_ID'];
                                          leaveCode = item['LEAVE_CODE'];
                                          REASON_MASTER_SELECT =
                                              item['REASON_MASTER_SELECT'];
                                          chkYearLvBlnce =
                                              item['ATTEMPT_COUNT'];
                                          if (leaveCode == "T") {
                                            if (REASON_MASTER_SELECT == 1.0) {
                                              setState(() {
                                                _showReasonDropDown_Visiblity =
                                                    true;
                                                _showNormalReasonBox_Visiblity =
                                                    false;
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              _showReasonDropDown_Visiblity =
                                                  false;
                                              _showNormalReasonBox_Visiblity =
                                                  true;
                                              _myReasonBool = true;
                                            });
                                            Reason.clear();
                                          }
                                          if (leaveCode == "X") {
                                            await checkRHTaken();
                                            if (availed_RH_date != "") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "You have already availed RH on $availed_RH_date  this year")));

                                              return;
                                            } else {
                                              isRhselected = true;
                                              isRhselected2forReasonBox = true;
                                              leaveSelect = false;
                                              showRhLeave = true;
                                              fromDate.clear();
                                              toDate.clear();
                                              outTime.clear();
                                              inTime.clear();
                                              FromtimeData.clear();
                                              Totimedata.clear();

                                              setState(() {
                                                no_of_days = "1";
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              isRhselected = false;
                                              isRhselected2forReasonBox = false;
                                              _myRHbool = true;
                                              ShortLeaveButton = false;

                                              isvisiblity2 = false;
                                              isvisiblity4 = false;
                                              inTime.clear();
                                              outTime.clear();
                                              isvisiblity3 = true;
                                              isvisiblity = true;
                                            });

                                            leaveSelect = true;
                                            showRhLeave = false;
                                          }

                                          print(leaveCode);
                                          // print(itemmm);
                                          //  print(short_count);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            : DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: false,
                                  child: DropdownButton<String>(
                                    hint: Text('Select leave'),

                                    value: _myLeave,

                                    iconSize: 30.h,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.sm,
                                    ),
                                    // hint: Text('Select leave'),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _myLeaveBool = false;
                                        _myLeave = newValue!;
                                        if (itemmm == "1.0") {
                                          shortLeaveToggleVisiblity = true;
                                        } else {
                                          shortLeaveToggleVisiblity = false;
                                        }

                                        // _getCitiesList();
                                        //print(_myLeave);
                                      });
                                    },
                                    items: leaveList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['LEAVETYPE']),
                                        value: item['ROW_ID'].toString(),
                                        onTap: () async {
                                          itemmm =
                                              item['SHORT_FLAG'].toString();
                                          // print(itemmm);
                                          short_count =
                                              item['SHORT_COUNT'].toString();
                                          rowId_FromDropDown = item['ROW_ID'];
                                          leaveCode = item['LEAVE_CODE'];
                                          REASON_MASTER_SELECT =
                                              item['REASON_MASTER_SELECT'];
                                          chkYearLvBlnce =
                                              item['ATTEMPT_COUNT'];
                                          if (leaveCode == "T") {
                                            if (REASON_MASTER_SELECT == 1.0) {
                                              setState(() {
                                                _showReasonDropDown_Visiblity =
                                                    true;
                                                _showNormalReasonBox_Visiblity =
                                                    false;
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              _showReasonDropDown_Visiblity =
                                                  false;
                                              _showNormalReasonBox_Visiblity =
                                                  true;
                                              _myReasonBool = true;
                                            });
                                            Reason.clear();
                                          }
                                          if (leaveCode == "X") {
                                            await checkRHTaken();
                                            if (availed_RH_date != "") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "You have already availed RH on $availed_RH_date  this year")));
                                              return;
                                            } else {
                                              isRhselected = true;
                                              isRhselected2forReasonBox = true;
                                              leaveSelect = false;
                                              showRhLeave = true;
                                              ShortLeaveButton = false;

                                              fromDate.clear();
                                              toDate.clear();
                                              outTime.clear();
                                              inTime.clear();
                                              FromtimeData.clear();
                                              Totimedata.clear();
                                              setState(() {
                                                no_of_days = "1";
                                              });
                                            }
                                          } else {
                                            isRhselected = false;
                                            isRhselected2forReasonBox = false;
                                            leaveSelect = true;
                                            showRhLeave = false;
                                            _myRHbool = true;
                                            resonForRh = "Reason here";
                                            ShortLeaveButton = false;
                                            setState(() {
                                              isvisiblity2 = false;
                                              isvisiblity4 = false;
                                              isvisiblity3 = true;
                                              isvisiblity = true;
                                              inTime.clear();
                                              outTime.clear();
                                            });
                                          }
                                          //  print(leaveCode);

                                          // print(short_count);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                // FormHelper.dropDownWidget(
                //   context,
                //   "Select Leave Type",
                //   this.leaveId,
                //   this.leave,
                //   (onChangedval) {
                //     this.leaveId = onChangedval;
                //     dropDownController.text = onChangedval;
                //     if (onChangedval == "3") {
                //       setState(() {
                //         leaveSelect = false;
                //         showRhLeave = true;
                //       });
                //     } else {
                //       setState(() {
                //         leaveSelect = true;
                //         showRhLeave = false;
                //       });
                //     }

                //     print("selected:$onChangedval");
                //     print(leaveSelect);
                //   },
                //   (onValidate) {
                //     if (onValidate == null) {
                //       return "Please select Type of leave";
                //     }
                //     return null;
                //   },
                //   borderColor: Colors.black,
                //   borderFocusColor: Color.fromARGB(255, 235, 231, 231),
                //   borderRadius: 10,
                //   optionValue: "id",
                //   optionLabel: "label",
                //   paddingLeft: 0,
                // ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: shortLeaveToggleButton()),
            ],
          ),
        ],
      ),
    );
  }

  Widget shortLeaveToggleButton() {
    return Visibility(
      visible: shortLeaveToggleVisiblity,
      child: Padding(
        padding: EdgeInsets.only(top: 15.h, left: .0, right: 0.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 0.9,
              child: CupertinoSwitch(
                  trackColor: Colors.grey,
                  activeColor: Global_User_theme,
                  value: ShortLeaveButton,
                  onChanged: (newValuee) {
                    onChangedFunction1(newValuee);
                    // isvisiblity = !isvisiblity;
                    // isvisiblity2 = !isvisiblity2;
                    // isvisiblity3 = !isvisiblity3;
                    // isvisiblity4 = !isvisiblity4;
                  }),
            ),
            Transform.scale(
              scale: 0.9,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Short leave",
                  style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fromDateLeaveBox() {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 16.h, right: 16.0, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "From Date",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Container(
              height: 40.h,
              width: 500.w,
              child: TextField(
                controller: fromDate, //editing controller of this TextField
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Global_User_theme)),
                  icon: Icon(
                    Icons.calendar_today,
                    color: Global_User_theme,
                  ), //icon of text field
                  // labelText: "Enter Date" //label text of field
                  hintText: "Select Date",
                ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  pickedDate = await showDatePicker(
                      builder: ((context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Global_User_theme,
                            ),
                          ),
                          child: child!,
                        );
                      }),
                      context: context,
                      initialDate: pickedDate ?? DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd-MMM-yyyy').format(pickedDate!);
                    print(formattedDate);

                    setState(() {
                      fromDate.text = formattedDate;

                      dateDifference();
                      if (ShortLeaveButton) {
                        no_of_days = "0.25";
                      }

                      //print("ok");
                      // pickedDate2 = pickedDate;
                      sameDate = true;
                      // calculate_no_of_days();
                      print("ok");
                      if (toDate.text.isNotEmpty) {
                        // fromDateValidationsFunction();
                        return;
                      } else {
                        toDate.text = formattedDate;
                        pickedDate2 = pickedDate;
                        //  fromDateValidationsFunction();
                      }
                    });

                    //  fromDateValidationsFunction();
                  } else {
                    print("Date is not selected");
                  }
                  if (pickedDate2 != null) {
                    toDateChangeValiditions();
                  }
                },
              )

              //  TextFormField(
              //   readOnly: true,
              //   controller: fromDate,
              //   scrollPhysics: NeverScrollableScrollPhysics(),
              //   textAlign: TextAlign.justify,
              //   keyboardType: TextInputType.multiline,
              //   decoration: InputDecoration(
              //     suffixIcon: IconButton(
              //         onPressed: () {
              //           setState(() {
              //             pickDate2(context);
              //           });
              //         },
              //         icon: Icon(
              //           Icons.date_range_outlined,
              //           color: Colors.black,
              //           size: 30,
              //         )),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     hintText: getDateText2(),
              //     hintStyle: date2 != null
              //         ? TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w600,
              //           )
              //         : TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w300,
              //           ),
              //   ),
              //   validator: (attendValue) {
              //     if (attendValue.toString().isNotEmpty) {
              //       return "Select Attendance Date";
              //     }
              //   },
              // ),
              ),
        ],
      ),
    );
  }

  Widget toDateLeaveBox() {
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: 16.h, right: 16.w, bottom: 5.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "To Date",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Container(
              height: 40.h,
              width: 500.w,
              child: TextField(
                controller: toDate,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Global_User_theme)),
                    icon: Icon(
                      Icons.calendar_today,
                      color: Global_User_theme,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: null,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ), //icon of text field
                    // labelText: "Enter Date" //label text of field
                    hintText: //sameDate ? fromDate.text :
                        "Select Date"),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  pickedDate2 = await showDatePicker(
                      builder: ((context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Global_User_theme,
                            ),
                          ),
                          child: child!,
                        );
                      }),
                      context: context,
                      initialDate: pickedDate2 ?? DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate2 != null) {
                    print(
                        pickedDate2); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd-MMM-yyyy').format(pickedDate2!);
                    print(formattedDate);

                    setState(() {
                      toDate.text = formattedDate;

                      dateDifference();

                      //calculate_no_of_days(); //uncomment it if no of days calulation goes wrong
                      toDateChangeValiditions();
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              )

              //  TextFormField(
              //   readOnly: true,
              //   controller: toDate,
              //   scrollPhysics: NeverScrollableScrollPhysics(),
              //   textAlign: TextAlign.justify,
              //   keyboardType: TextInputType.multiline,
              //   decoration: InputDecoration(
              //     suffixIcon: IconButton(
              //         onPressed: () {
              //           setState(() {
              //             pickDate(context);
              //           });
              //         },
              //         icon: Icon(
              //           Icons.date_range_outlined,
              //           color: Colors.black,
              //           size: 30,
              //         )),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     hintText: getDateText(),
              //     hintStyle: date != null
              //         ? TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w600,
              //           )
              //         : TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w300,
              //           ),
              //   ),
              //   validator: (attendValue) {
              //     if (attendValue.toString().isNotEmpty) {
              //       return "Select Attendance Date";
              //     }
              //   },
              // ),
              ),
        ],
      ),
    );
  }

  Widget fromDateToggleButtons() {
    return Visibility(
      visible: isvisiblity,
      child: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
        child: Container(
          height: 20.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "1st half",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sm),
                ),
              ),
              CupertinoSwitch(
                  trackColor: Colors.grey,
                  activeColor: Global_User_theme,
                  value: FromDate1stHalf,
                  onChanged: (newValue) {
                    onChangedFunction2(newValue);
                  }),
              //Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "2st half",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sm),
                ),
              ),
              CupertinoSwitch(
                  trackColor: Colors.grey,
                  activeColor: Global_User_theme,
                  value: FromDate2ndHalf,
                  onChanged: (newValue) {
                    onChangedFunction3(newValue);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget toDateToggleButtons() {
    return Visibility(
      visible: isvisiblity3,
      child: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
        child: Container(
          height: 15.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "1st half",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CupertinoSwitch(
                  trackColor: Colors.grey,
                  activeColor: Global_User_theme,
                  value: toDate1stHalf,
                  onChanged: (newValue) {
                    onChangedFunction4(newValue);
                  }),
              // Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "2st half",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CupertinoSwitch(
                  trackColor: Colors.grey,
                  activeColor: Global_User_theme,
                  value: toDate2ndHalf,
                  onChanged: (newValue) {
                    onChangedFunction5(newValue);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget reasonAndNoOfDays() {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, left: 10.w, right: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Visibility(
            visible: _showReasonDropDown_Visiblity,
            child: _myReasonBool
                ? DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: false,
                      child: DropdownButton<String>(
                        hint: Text('Select Reason'),

                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        // hint: Text('Select leave'),
                        onChanged: (newValue) {
                          setState(() {
                            _myReasonBool = false;
                            _myReason = newValue!;
                          });
                        },
                        items: rhReasonList?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['REASON_DESC']),
                            value: item['REASON_CODE'].toString(),
                            onTap: () {
                              Reason.text = item['REASON_DESC'];
                              print(Reason.text);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: false,
                      child: DropdownButton<String>(
                        hint: Text('Select Reason'),

                        value: _myReason,

                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        // hint: Text('Select leave'),
                        onChanged: (newValue) {
                          setState(() {
                            // _myRHbool = false;
                            _myReason = newValue!;
                          });
                        },
                        items: rhReasonList?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['REASON_DESC']),
                            value: item['REASON_CODE'].toString(),
                            onTap: () {
                              setState(() {
                                _myReasonBool = false;
                              });
                              Reason.text = item['REASON_DESC'];
                              print(Reason.text);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ),
          Visibility(
            visible: _showNormalReasonBox_Visiblity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(right: 160.0),
                //   child:
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    child: Text(
                      "Enter reason",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  width: 220.w,
                  height: 40.h,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      //color: Color.fromARGB(255, 255, 248, 248),
                      ),
                  child: isRhselected2forReasonBox
                      ? Container(
                          width: 100.w,
                          height: 40.h,
                          padding: EdgeInsets.only(left: 20.w),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)

                              //color: Color.fromARGB(255, 255, 248, 248),
                              ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                resonForRh.toString(),
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      : TextFormField(
                          controller: Reason,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Global_User_theme)),
                              hintText: "Enter Reason",
                              labelText: "Reason Here",
                              labelStyle: TextStyle(color: Global_User_theme),
                              // hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                ),
              ],
            ),
          ),
          // Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 0.0, right: 20),
              //   child:
              Align(
                // alignment: Alignment.centerRight,
                child: Text(
                  "No of Days",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: 100.w,
                height: 40.h,
                padding: EdgeInsets.only(right: 20.w),
                decoration: BoxDecoration(

                    //color: Color.fromARGB(255, 255, 248, 248),
                    ),
                child: isRhselected
                    ? Container(
                        width: 80.w,
                        height: 40.h,

                        // padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.w,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.r)

                            //color: Color.fromARGB(255, 255, 248, 248),
                            ),

                        child: Center(
                            child: Text(
                          "1",
                          style: TextStyle(fontSize: 16.sm),
                        )),
                      )
                    : Container(
                        width: 80.w,
                        height: 40.h,

                        // padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.r)

                            //color: Color.fromARGB(255, 255, 248, 248),
                            ),

                        child: total
                            ? Center(
                                child: Text(
                                no_of_days,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ))
                            : Center(
                                child: Text(
                                "Days",
                                style: TextStyle(fontSize: 16),
                              )),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? noofdays() {
    if (mainTime == null && mainTime2 == null)
      return "days";
    else {
      return difference.inDays.toString();
    }
  }

  Widget savebutton() {
    return InkWell(
      // onTap: saveApiResponse
      //     ? null
      //     : () {
      //         saveLeave();
      //       },
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        // padding: EdgeInsets.only(top: 30.0, left: 150, right: 1),
        child: InkWell(
          onTap: saveApiResponse
              ? null
              : () {
                  saveLeave();
                },
          child: Container(
            height: 50,
            //  margin: EdgeInsets.symmetric(horizontal: 100.w),
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              color: Global_User_theme,
              borderRadius: BorderRadius.circular(10),
            ),
            child: saveApiResponse
                ? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget RHleave() {
    return Visibility(
      visible: showRhLeave,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Restricted Holidays",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 100,

                    // padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: _myRHbool
                              ? DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    disabledColor: Colors.white,
                                    alignedDropdown: false,
                                    child: DropdownButton<String>(
                                      hint: Text('Select leave'),
                                      iconDisabledColor: Colors.white,

                                      iconSize: 30,
                                      icon: (null),
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                      // hint: Text('Select leave'),
                                      onChanged: (newValue) {
                                        setState(() {
                                          // _myRHbool = false;
                                          _myRh = newValue!;
                                        });
                                      },
                                      items: rhLeaveList?.map((item) {
                                        return new DropdownMenuItem(
                                          enabled:
                                              item['IS_DATE_DISABLE'] == 1.0
                                                  ? false
                                                  : true,
                                          child: new Text(
                                              item['RH_NAME_WITH_DATE']),
                                          value: item['ROW_ID'].toString(),
                                          onTap: () {
                                            rowId_FromRhDropDown =
                                                item['ROW_ID'];
                                            resonForRh = item['RH_DESC'];
                                            Reason.text = resonForRh;

                                            isRhDisable =
                                                item['IS_DATE_DISABLE'];
                                            if (isRhDisable == 1.0) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "You Cannot Apply Leave On Previous Dates")));

                                              return;
                                            }

                                            setState(() {
                                              _myRHbool = false;
                                              toDate.text = item['RH_DATE'];
                                              fromDate.text = item['RH_DATE'];
                                              no_of_days = "1";
                                            });

                                            print(myRhLeaveDate);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              : DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    disabledColor: Colors.white,
                                    alignedDropdown: false,
                                    child: DropdownButton<String>(
                                      hint: Text('Select leave'),

                                      value: _myRh,

                                      iconSize: 30,
                                      icon: (null),
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                      // hint: Text('Select leave'),
                                      onChanged: (newValue) {
                                        setState(() {
                                          // _myRHbool = false;
                                          _myRh = newValue!;
                                        });
                                      },
                                      items: rhLeaveList?.map((item) {
                                        return new DropdownMenuItem(
                                          enabled:
                                              item['IS_DATE_DISABLE'] == 1.0
                                                  ? false
                                                  : true,
                                          child: new Text(
                                              item['RH_NAME_WITH_DATE']),
                                          value: item['ROW_ID'].toString(),
                                          onTap: () {
                                            rowId_FromRhDropDown =
                                                item['ROW_ID'];
                                            resonForRh = item['RH_DESC'];
                                            Reason.text = resonForRh;
                                            isRhDisable =
                                                item['IS_DATE_DISABLE'];
                                            if (isRhDisable == 1.0) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "You Cannot Apply Leave On Previous Dates")));
                                              setState(() {
                                                _myRHbool = true;
                                              });

                                              return;
                                            }

                                            setState(() {
                                              _myRHbool = false;
                                              toDate.text = item['RH_DATE'];
                                              fromDate.text = item['RH_DATE'];
                                              no_of_days = "1";
                                            });

                                            print(myRhLeaveDate);
                                            print(rowId_FromRhDropDown);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: shortLeaveToggleButton()),
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
    );
  }

  // Widget reasonDropDown() {
  //   return Visibility(
  //     visible: _showReasonDropDown_Visiblity,
  //     child: _myReasonBool
  //         ? DropdownButtonHideUnderline(
  //             child: ButtonTheme(
  //               alignedDropdown: false,
  //               child: DropdownButton<String>(
  //                 hint: Text('Select Reason'),

  //                 iconSize: 30,
  //                 icon: (null),
  //                 style: TextStyle(
  //                   color: Colors.black54,
  //                   fontSize: 16,
  //                 ),
  //                 // hint: Text('Select leave'),
  //                 onChanged: (newValue) {
  //                   setState(() {
  //                     _myReasonBool = false;
  //                     _myReason = newValue!;
  //                   });
  //                 },
  //                 items: rhReasonList.map((item) {
  //                   return new DropdownMenuItem(
  //                     child: new Text(item['REASON_DESC']),
  //                     value: item['REASON_CODE'].toString(),
  //                     onTap: () {},
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //           )
  //         : DropdownButtonHideUnderline(
  //             child: ButtonTheme(
  //               alignedDropdown: false,
  //               child: DropdownButton<String>(
  //                 hint: Text('Select Reason'),

  //                 value: _myReason,

  //                 iconSize: 30,
  //                 icon: (null),
  //                 style: TextStyle(
  //                   color: Colors.black54,
  //                   fontSize: 16,
  //                 ),
  //                 // hint: Text('Select leave'),
  //                 onChanged: (newValue) {
  //                   setState(() {
  //                     // _myRHbool = false;
  //                     _myReason = newValue!;
  //                   });
  //                 },
  //                 items: rhReasonList.map((item) {
  //                   return new DropdownMenuItem(
  //                     child: new Text(item['REASON_DESC']),
  //                     value: item['REASON_CODE'].toString(),
  //                     onTap: () {
  //                       setState(() {
  //                         _myReasonBool = false;
  //                       });
  //                     },
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //           ),
  //   );
  // }

  // Future pickDate(BuildContext context) async {
  //   final initialDate = DateTime.now();
  //   final newDate = await showDatePicker(
  //       context: context,
  //       initialDate: date ?? initialDate,
  //       firstDate: DateTime(DateTime.now().year - 5),
  //       lastDate: DateTime(DateTime.now().year + 5));
  //   if (newDate == null) return;
  //   setState(() {
  //     date = newDate;
  //   });
  // }

  // Future pickDate2(BuildContext context) async {
  //   final initialDate = DateTime.now();
  //   final newDate = await showDatePicker(
  //       context: context,
  //       initialDate: date2 ?? initialDate,
  //       firstDate: DateTime(DateTime.now().year - 5),
  //       lastDate: DateTime(DateTime.now().year + 5));
  //   if (newDate == null) return;
  //   setState(() {
  //     date2 = newDate;
  //   });
  // }

  // Future pickTime(BuildContext context) async {
  //   final initialTime = TimeOfDay(hour: 9, minute: 0);
  //   final newTime = await showTimePicker(
  //     context: context,
  //     initialTime: time ?? initialTime,
  //   );
  //   if (newTime == null) return;
  //   setState(() {
  //     time = newTime;
  //   });
  // }

  //-----------------------------------------------------------------------------

  //inDateAndTime Only
//   Future pickInDate(BuildContext context) async {
//     final initialDate2 = DateTime.now();
//     final newDate = await showDatePicker(
//         context: context,
//         initialDate: date2 ?? initialDate2,
//         firstDate: DateTime(DateTime.now().year - 5),
//         lastDate: DateTime(DateTime.now().year + 5));
//     if (newDate == null) return;

//     return date2 = newDate;
//   }

//   Future pickInTime(BuildContext context) async {
//     final initialTime2 = TimeOfDay(hour: 12, minute: 0);
//     final newTime = await showTimePicker(
//       context: context,
//       initialTime: initialTime2,
//     );
//     if (newTime == null) return;

//     return time2 = newTime;
//   }

//   Future pickDateAndTime(BuildContext context) async {
//     final inDate = await pickInDate(context);
//     if (inDate == null) return;

//     final inTime = await pickInTime(context);
//     if (inTime == null) return;

//     setState(() {
//       dateTime = DateTime(
//         inDate.year,
//         inDate.month,
//         inDate.day,
//         inTime.hour,
//         inTime.minute,
//       );
//     });
//   }

// //-----------------------------------------------------------------------------

// // outDateAndTime Only
//   Future pickOutDate(BuildContext context) async {
//     final initialDate3 = DateTime.now();
//     final newDate3 = await showDatePicker(
//         context: context,
//         initialDate: date3 ?? initialDate3,
//         firstDate: DateTime(DateTime.now().year - 5),
//         lastDate: DateTime(DateTime.now().year + 5));
//     if (newDate3 == null) return;

//     return date3 = newDate3;
//   }

//   Future pickOutTime(BuildContext context) async {
//     final initialTime3 = TimeOfDay(hour: 10, minute: 0);
//     final newTime3 = await showTimePicker(
//       context: context,
//       initialTime: initialTime3,
//     );
//     if (newTime3 == null) return;

//     return time3 = newTime3;
//   }

//   Future pickOutDateAndTime(BuildContext context) async {
//     final outDate = await pickInDate(context);
//     if (outDate == null) return;

//     final outTime = await pickInTime(context);
//     if (outTime == null) return;

//     setState(() {
//       OutdateTime = DateTime(
//         outDate.year,
//         outDate.month,
//         outDate.day,
//         outTime.hour,
//         outTime.minute,
//       );
//     });
//   }

  // void Login() async {
  //   try {
  //     Response response = await post(
  //         Uri.parse("http://172.16.15.129:8073/api/LeaveAPI/GetLeaveEmpQuery"),
  //         body: {"cpfNo": "42914", "ouId": "94", "Flag": "GET_LEAVE_EMP"});

  //     if (response.statusCode == 200) {
  //       print("api hit success");
  //       print(response.body);
  //       setState(() {});
  //     } else {
  //       print("faild");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  calculate_no_of_days() {
    var ret_no_of_days;
    if (leaveCode == "X") {
      ret_no_of_days = 1;
      return ret_no_of_days;
    }
    if (widget.edit == 1) {
      dateDifference();
    }

    var val_from_flag = false;
    var val_to_flag = false;
    if (FromDate1stHalf == true || FromDate2ndHalf == true) {
      val_from_flag = true;
    }
    if (toDate1stHalf == true || toDate2ndHalf == true) {
      val_to_flag = true;
    }
    var fromsplt = fromDate.text.split("-");
    print(fromsplt);
    var fromyear = fromsplt[0];
    print(fromyear);
    var frommonth = (fromsplt[1]); //(fromsplt[1] - 1);
    print(frommonth);
    var fromday = fromsplt[2];
    print(fromday);

    var tosplt = toDate.text.split("-");
    // var toyear = tosplt[0];
    // var tomonth = (tosplt[1]); //(tosplt[1] - 1);
    // var to_day = tosplt[2];
    // DateTime dateToday = DateTime(fromyear, DateTime.now().month, DateTime.now().day) ;
    print(toDate.text);

    if (difference.inDays != 0) {
      if (val_from_flag == true && val_to_flag == true) {
        var d1 = difference.inDays;
        ret_no_of_days = d1;
      } else if (val_from_flag == false && val_to_flag == false) {
        var d1 = difference.inDays + 1;
        ret_no_of_days = d1;
      } else if (val_from_flag == false && val_to_flag == true) {
        var d1 = difference.inDays + .5;
        ret_no_of_days = d1;
      } else if (val_from_flag == true && val_to_flag == false) {
        var d1 = difference.inDays + .5;
        ret_no_of_days = d1;
      }
    } else {
      if (val_from_flag == true) {
        if (val_to_flag == true) {
          ret_no_of_days = 1;
        } else {
          ret_no_of_days = 0.5;
        }
      } else {
        if (val_to_flag == true) {
          ret_no_of_days = 0.5;
        } else {
          ret_no_of_days = 1;
        }
      }
    }
    no_of_days = ret_no_of_days.toString();

    setState(() {
      total = true;
    });

    return ret_no_of_days;
  }

//!<--------------------api call for user details for date of joining to be changed on profile api-------------------------->
  Future apiForUserDetails() async {
    try {
      Map data = {"ID": globalInt.toString(), "Flag": "test"};
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetEmployeeDetail";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/GetEmployeeDetail"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "ID": globalInt.toString(),
      //       "Flag": "test"
      //     });

      if (response!.statusCode == 200) {
        setState(() {
          var jsondata = response.body;

          // var jsonmaindata = map['Table'];

          if (jsondata.isNotEmpty) {
            Map<String, dynamic> map = jsonDecode(response.body);
            var data = map['Table'];
            List<DateOfJoiningModel> list = List.from(data)
                .map<DateOfJoiningModel>(
                  (item) => DateOfJoiningModel.fromJson(item),
                )
                .toList();
            dateOfJoiningModel = list.first;
            date_of_joining = dateOfJoiningModel.DATE_OF_JOINING;
          } else {
            if (!isAlertboxOpened) {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text(
                      'Error! No response from server',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              );
            }
            setState(() => isAlertboxOpened = true); //
          }
        });
        print(date_of_joining);
      } else {
        if (!isAlertboxOpened) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Error! No response from server',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
        setState(() => isAlertboxOpened = true); //
      }
    } catch (e) {
      if (!isAlertboxOpened) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No response from server',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
      setState(() => isAlertboxOpened = true); //
      print(e);
    }
  }

  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            width: 30,
            height: 110,
            child: Center(
              child: CustomLoader(
                dotColor: Global_User_theme,
              ),
            ),
          ),
        );
      },
    );
  }

  Future saveLeave() async {
    if (leaveCode == "X") {
      no_of_days = "1";
    }
    var flag = widget.edit == 1 ? "EDIT" : "INSERT";
    serialno = widget.edit == 1 ? widget.SerialNo : 0;

    var vresult = await keycommit();

    if (vresult == true) {
      _openLoadingDialog(context);
      // setState(() {
      //   saveApiResponse = true;
      //   _loadingForReasonDropdown = true;
      // });

      Map data = {
        // body
        "flag": flag,
        "cpfNo": globalInt.toString(),
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode,
        "ShowshortLeave": false.toString(),
        "shortLeaveFlag": ShortLeaveButton.toString(),
        "shortLeaveCount": 0.toString(),
        "fromTime": FromtimeData.text.toString(),
        "toTime": Totimedata.text.toString(),
        "fromDate": fromDate.text,
        "from1HalfDay": FromDate1stHalf.toString(),
        "from2HalfDay": FromDate2ndHalf.toString(),
        "toDate": toDate.text,
        "to1HalfDay": toDate1stHalf.toString(),
        "to2HalfDay": toDate2ndHalf.toString(),
        "reason": Reason.text,
        "resonCode": 0.toString(),
        "noOfDay": no_of_days,
        "ltaFlag": false.toString(),
        "leaveYear": '',
        "approved": 'N',
        "fromFlagshow": false.toString(),
        "toFlagshow": false.toString(),
        "RhId": rowId_FromRhDropDown.toString(),
        "RhDate": fromDate.text,
        "RhReason": resonForRh.toString(),
        "Updatedflag": 'E',
        "serialNo": serialno.toString()
      };
      var jsondata = json.encode(data);
      try {
        String _apiendpoint = "$ServerUrl/api/LeaveAPI/SaveLeave";
        Response? response = await myHttpClient.PostMethod(
            _apiendpoint, data, "leaveRequest", true);
        // Response response = await post(
        //     Uri.parse("$ServerUrl/api/LeaveAPI/SaveLeave"),
        //     headers: {
        //       "MobileURL": "leaveRequest",
        //       "CPF_NO": globalInt.toString(),
        //       "Content-Type": "application/json",
        //       "Authorization": "Bearer $JWT_Tokken"
        //     },
        //     body: jsondata);

        if (response!.statusCode == 200) {
          var responsefrombody = json.decode(response.body);

          // print(responsefrombody["MSG"]);
          var dataresponse = responsefrombody["Output"];
          var MSG = responsefrombody["MSG"];
          if (dataresponse == "ERROR") {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error $MSG")));
          } else if (dataresponse == "SUCCESS") {
            Navigator.pop(context);
            // SweetAlert.show(context,
            //     title: "SUCCESS",
            //     subtitle: "New leave has been added",
            //     style: SweetAlertStyle.success);
            AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Sucess',
              desc: "New Leave has been added",
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
            ApprovedLeavesOFEmployee();
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error $MSG")));
          }
        } else {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Error',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
      } catch (e) {
        Navigator.pop(context);
        print(e);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error")));
      } finally {
        setState(() {
          saveApiResponse = false;
          _loadingForReasonDropdown = false;
          total = false;
          _myLeaveBool = true;
          shortLeaveToggleVisiblity = false;
          FromDate1stHalf = false;
          FromDate2ndHalf = false;
          toDate1stHalf = false;
          toDate2ndHalf = false;
        });
        fromDate.clear();
        toDate.clear();
        outTime.clear();
        inTime.clear();
        FromtimeData.clear();
        Totimedata.clear();
        Reason.clear();
        dropDownController.clear();
        pickedDate = null;
        pickedDate2 = null;
      }
    }
  }

  Future editLeaveSaveButton() async {}

  keycommit() async {
    if (rowId_FromDropDown == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Pelase select the leave type")));
      return false;
    }
    if (fromDate.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("From date cannot be left blank")));
      return false;
    }
    if (toDate.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("to date cannot be left blank")));
      return false;
    }
    if (ShortLeaveButton == true && no_of_days == "0.25") {
      if (inTime.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("From time cannot be left blank for short leave")));
        return false;
      }
      if (outTime.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("To time cannot be left blank for short leave.")));
        return false;
      }
    }
    if (leaveCode == "T" && Reason.text == "") {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text("Tour reason is mandatory. Please select it.")));
      // return false;
    }
    if (leaveCode == "J" && Reason.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Reason is mandatory for Work from home. Please enter it.")));
      return false;
    }
    if (ShortLeaveButton == true && no_of_days == "0.25") {
      var vardup_sl = await dup_short_leave();
      if (vardup_sl != 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Short Leave period overlapping. Check the leave status/history before applying this leave.")));
        return false;
      }
    } else {
      var strval = await dup_leave();
      if (strval != "success") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Leave period overlapping. Check the leave status/history before applying this leave.")));
        return false;
      }
    }
    var result = await proc_days();
    if (result == false) {
      return false;
    }
    if (no_of_days == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No of days cannot be left blank.")));
      return false;
    }
    return true;
  }

  dup_leave() async {
    var strval = "";

    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "fromDate": fromDate.text,
        "toDate": toDate.text,
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode.toString(),
        "fromTime": inTime.text.toString(),
        "toTime": outTime.text.toString(),
        "serialNo": serialno.toString(),
        "from1HalfDay": FromDate1stHalf.toString(),
        "from2HalfDay": FromDate2ndHalf.toString(),
        "to1HalfDay": toDate1stHalf.toString(),
        "to2HalfDay": toDate2ndHalf.toString(),
        "noOfDay": no_of_days.toString()
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/CheckDupLeave";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/CheckDupLeave"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "fromDate": fromDate.text,
      //       "toDate": toDate.text,
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //       "fromTime": inTime.text.toString(),
      //       "toTime": outTime.text.toString(),
      //       "serialNo": serialno.toString(),
      //       "from1HalfDay": FromDate1stHalf.toString(),
      //       "from2HalfDay": FromDate2ndHalf.toString(),
      //       "to1HalfDay": toDate1stHalf.toString(),
      //       "to2HalfDay": toDate2ndHalf.toString(),
      //       "noOfDay": no_of_days.toString()
      //     });

      var responsefromapi = json.decode(response!.body);
      if (responsefromapi != null) {
        strval = responsefromapi;
      }
      return strval;
    } catch (e) {
      print(e);
    }
  }

  dup_short_leave() async {
    var ct1 = 0;
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "fromDate": fromDate.text,
        "toDate": toDate.text,
        "leaveId": rowId_FromDropDown.toString(),
        "leaveCode": leaveCode.toString(),
        "fromTime": inTime.text.toString(),
        "toTime": outTime.text.toString(),
        "serialNo": 0.toString()
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/CheckShortLeave";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/CheckShortLeave"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "fromDate": fromDate.text,
      //       "toDate": toDate.text,
      //       "leaveId": rowId_FromDropDown.toString(),
      //       "leaveCode": leaveCode.toString(),
      //       "fromTime": inTime.text.toString(),
      //       "toTime": outTime.text.toString(),
      //       "serialNo": 0.toString()
      //     });

      var responsefromapi = json.decode(response!.body);
      ct1 = responsefromapi;
      return ct1;
    } catch (e) {
      print(e);
    }
  }

  checkRHTaken() async {
    try {
      Map data = {"cpfNo": globalInt.toString(), "ouID": ouId.toString()};
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/CheckRHTaken";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "leaveRequest", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/CheckRHTaken"),
      //     headers: {
      //       "MobileURL": "leaveRequest",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString()
      //     });

      var responsefromapi = json.decode(response!.body);
      availed_RH_date = responsefromapi;
    } catch (e) {
      print(e);
    }
  }

  ShowCalender() {
    showDialog(
      context: context,
      builder: (dialogeeecontext) => Center(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(1.0),
              ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Container(
              //  height: MediaQuery.of(context).size.height / 2,
              color: Colors.grey.shade200,

              child: _EventCalenderLoder
                  ? Center(
                      child:
                          CircularProgressIndicator(color: Global_User_theme),
                    )
                  : Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        _calendarCarouselNoHeader,
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(209, 25, 32, 1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Absent"),
                            SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(134, 184, 165, 1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Approved"),
                            SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(235, 121, 33, 1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Restricted holiday"),
                            SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(98, 164, 186, 1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Holiday"),
                            SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(222, 174, 42, 1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Applied"),
                          ],
                        )
                        // Center(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text(
                        //       "Reconciliation history",
                        //       style: TextStyle(
                        //           color: Colors.black, fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
    return Container();
  }
}
