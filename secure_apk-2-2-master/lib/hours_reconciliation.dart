import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:secure_apk/reuseablewidgets.dart/showcase.dart';
import 'package:showcaseview/showcaseview.dart';

//import 'package:sweetalert/sweetalert.dart';

import 'globals.dart';
import 'models/PipoEntryDetails.dart';
import 'models/dateofjoiningdetailModel.dart';
import 'reuseablewidgets.dart/Common.dart';
import 'reuseablewidgets.dart/colors.dart';
import 'reuseablewidgets.dart/loder.dart';
import 'reuseablewidgets.dart/sessionexpire.dart';

class showcasewidgetAdjustment extends StatelessWidget {
  late String dateforedit;
  late int adjusttmentforedit;
  late String reasonforedit;
  late String fromhourforedit;
  late String tohourforedit;
  late String totalhourforedit;
  late int edit;
  late int SerialNo;
  late String APPROVED;

  showcasewidgetAdjustment(
      {required this.dateforedit,
      required this.adjusttmentforedit,
      required this.reasonforedit,
      required this.fromhourforedit,
      required this.tohourforedit,
      required this.totalhourforedit,
      required this.edit,
      required this.SerialNo,
      required this.APPROVED});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ShowCaseWidget(
            builder: Builder(
      builder: ((context) => Hours_Reconciliation(
          adjusttmentforedit: adjusttmentforedit,
          dateforedit: dateforedit,
          fromhourforedit: fromhourforedit,
          reasonforedit: reasonforedit,
          tohourforedit: tohourforedit,
          APPROVED: APPROVED,
          totalhourforedit: totalhourforedit,
          edit: edit,
          SerialNo: SerialNo)),
    )));
  }
}

class Hours_Reconciliation extends StatefulWidget {
  // const Hours_Reconciliation({Key? key}) : super(key: key);

  late String dateforedit;
  late int adjusttmentforedit;
  late String reasonforedit;
  late String fromhourforedit;
  late String tohourforedit;
  late String totalhourforedit;
  late int edit;
  late int SerialNo;
  late String APPROVED;

  Hours_Reconciliation(
      {required this.dateforedit,
      required this.adjusttmentforedit,
      required this.reasonforedit,
      required this.fromhourforedit,
      required this.tohourforedit,
      required this.totalhourforedit,
      required this.edit,
      required this.SerialNo,
      required this.APPROVED});

  @override
  State<Hours_Reconciliation> createState() => _Hours_ReconciliationState();
}

class _Hours_ReconciliationState extends State<Hours_Reconciliation> {
  DateTime? date;
  final KeyOne = GlobalKey();
  bool ShowpipoData = false;
  TimeOfDay? mainTime;
  TimeOfDay? mainTime2;
  DateTime? pickedDate;
  TimeOfDay? pickedFromTime;
  TimeOfDay? pickedTOtime;
  //late List PipoDataList;
  late List<PipoEntryDetails> PipoDataList;
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  TextEditingController dateController = TextEditingController();

  TextEditingController dropDownController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  TextEditingController FromtimeData = TextEditingController();

  TextEditingController Totimedata = TextEditingController();

  TextEditingController fromHoursController = TextEditingController();
  TextEditingController toHoursController = TextEditingController();
  TextEditingController totalHoursController = TextEditingController();

  List? adjustmentList;
  late String adjustmentId = "2";
  var adjustmentType;
  bool myAdjustmentBool = true;
  bool dropDownApiLoading = true;
  late DateOfJoiningModel dateOfJoiningModel;
  var date_of_joining;
  bool isAlertboxOpened = false;
  late bool hasInternet;
  late sessionExpired sessionexpired = new sessionExpired(context);
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  final introShown = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    introShown.writeIfNull("AdjustmentShowcase", false);

    Future.delayed(Duration.zero, () async {
      final connected = await InternetConnectionChecker().hasConnection;
      if (connected) {
        apiForUserDetails();
        isAlertboxOpened = false;
        if (introShown.read("AdjustmentShowcase") != true) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ShowCaseWidget.of(context).startShowCase([KeyOne]);
          });
          introShown.write("AdjustmentShowcase", true);
        }
        dropDownApiBind();
      }
    });

    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      if (!mounted) return;
      setState(() => this.hasInternet = hasInternet);
      if (!this.hasInternet) {
      } else {
        apiForUserDetails();
        isAlertboxOpened = false;

        dropDownApiBind();
      }
    });

    if (widget.edit == 1) {
      myAdjustmentBool = false;
      toHoursController.text = widget.tohourforedit;
      fromHoursController.text = widget.fromhourforedit;
      fromHoursController.text = convertTime(widget.fromhourforedit);
      toHoursController.text = convertTime(widget.tohourforedit);
      pickedFromTime = TimeOfDay(
          hour: int.parse(widget.fromhourforedit.split(":")[0]),
          minute: int.parse(widget.fromhourforedit.split(":")[1]));
      pickedTOtime = TimeOfDay(
          hour: int.parse(widget.tohourforedit.split(":")[0]),
          minute: int.parse(widget.tohourforedit.split(":")[1]));

      adjustmentId = widget.adjusttmentforedit.toString();
      reasonController.text = widget.reasonforedit;
      totalHoursController.text = widget.totalhourforedit;
      dateController.text = widget.dateforedit;
      adjustmentType = adjustmentId;

      dateController.text =
          DateFormat('dd-MMM-yyyy').format(DateTime.parse(widget.dateforedit));
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
    //fromHoursController.text = time;
    return time;
  }

  Future<List<PipoEntryDetails>> GetPipoOftheDay(
      var empno, var selectedDay) async {
    final String apiEndpoint =
        "$ServerUrl/api/MobileAPI/GetPipo_entry?CPF_NO=$empno&Selected_Date=$selectedDay";

    Response? response = await myHttpClient.GetMethod(
        apiEndpoint, "Adjustmentapprovalpage", true);

    if (response!.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var returnData = json.decode(response.body);

        var PipoData = returnData["Table"];
        if (PipoData == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error In Getting  PIPO Entry")));
        }
        PipoDataList = [];
        if (PipoData != null) {
          if (PipoData.length > 0) {
            var decode = json.decode(response.body);
            var data = decode['Table'];

            var resultsJson = data.cast<Map<String, dynamic>>();
            PipoDataList = await resultsJson
                .map<PipoEntryDetails>(
                    (json) => PipoEntryDetails.fromJson(json))
                .toList();
          }
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
    return PipoDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomshowcaseWidget(
        globalKey: KeyOne,
        description: "Pending/History Adjustment",
        child: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Global_User_theme,
          overlayColor: Colors.black,
          overlayOpacity: 0.8,
          buttonSize: Size(40.0, 45.0),
          // spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
                child: Icon(
                  Icons.pending,
                  color: Colors.white,
                ),
                label: 'Pending reconciliation requests',
                labelBackgroundColor: Global_User_theme,
                labelStyle: TextStyle(color: Colors.white),
                backgroundColor: Global_User_theme,
                onTap: () {
                  Navigator.pushNamed(context, "hoursReconciliationPending");
                }),
            SpeedDialChild(
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                label: 'Hours reconciliation history',
                labelBackgroundColor: Global_User_theme,
                labelStyle: TextStyle(color: Colors.white),
                backgroundColor: Global_User_theme,
                onTap: () {
                  Navigator.pushNamed(context, "hoursReconciliationHistory");
                })
          ],
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 1,
        backgroundColor: Global_User_theme,
        title: Text(
          "Hours Reconciliation",
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
          circularBird()
        ],
      ),
      body: dropDownApiLoading
          ? Center(
              child: CustomLoader(
                dotColor: Global_User_theme,
              ),
            )
          :
          // dropDownApiLoading
          //     ? Center(
          //         child: CircularProgressIndicator(color: Global_User_theme),
          //       )
          //     :
          Form(
              child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(children: <Widget>[
                header(),
                PipoEntryDetailsCard(),
                adjustmentTypeAndReason(),
                hours(),
                totalHours(),
                buttons(),
              ]),
            )),
    );
  }

  Widget PipoEntryDetailsCard() {
    return new SingleChildScrollView(
      child: Visibility(
        visible: ShowpipoData,
        child: Column(
          children: [
            FutureBuilder<List<PipoEntryDetails>>(
              initialData: const <PipoEntryDetails>[],
              future: GetPipoOftheDay(globalInt, dateController.text),
              builder: (context, snapshot) {
                if (snapshot.hasError ||
                    snapshot.data == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }

                return Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Card(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          headingRowHeight: 22,
                          // columnSpacing: 6,
                          horizontalMargin: 20,
                          dividerThickness: 0.4,
                          dataRowHeight: 28,
                          columns: const [
                            DataColumn(label: Text('Shift')),
                            DataColumn(label: Text('In/Out')),
                            DataColumn(label: Text('Entry time')),
                          ],
                          rows: List.generate(
                            snapshot.data!.length,
                            (index) {
                              var emp = snapshot.data![index];
                              return DataRow(cells: [
                                DataCell(Text(emp.SHIFT_CD)),
                                DataCell(Text(emp.IN_OUT)),
                                DataCell(Text(emp.DATETIME)),
                              ]);
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: 20.h, left: 16.w, right: 0.0, bottom: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(
                    "Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextField(
                    controller:
                        dateController, //editing controller of this TextField
                    decoration: InputDecoration(
                      focusColor: Global_User_theme,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Global_User_theme)),
                      hintText: "Select Date",
                      icon: Icon(
                        Icons.calendar_today,
                        color: Global_User_theme,
                      ), //icon of text field
                      // labelText: "Enter Date" //label text of field
                      suffixIcon: ShowpipoData
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  ShowpipoData = false;
                                });

                                dateController.clear();
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Global_User_theme,
                              ))
                          : Icon(
                              Icons.ice_skating,
                              color: Colors.white10,
                            ),
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
                        // print(
                        //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('dd-MMM-yyyy').format(pickedDate!);
                        print(formattedDate);

                        setState(() {
                          dateController.text = formattedDate;
                          ShowpipoData = true;
                        });
                        fromDateChange();
                        GetPipoOftheDay(globalInt, dateController.text);
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ))
              //  TextFormField(
              //   readOnly: true,
              //   controller: dateController,
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
              // ),
            ],
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     print("pressed");
        //   },
        //   child: Container(
        //     height: 40,
        //     width: MediaQuery.of(context).size.width / 5,
        //     // margin: EdgeInsets.only(top: 4),
        //     // padding: EdgeInsets.only(top: 30.0, left: 150, right: 1),
        //     child: Container(
        //       // height: 4000,
        //       // margin: EdgeInsets.symmetric(horizontal: 100),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(8),
        //         color: Color.fromRGBO(123, 34, 83, 1),
        //         // borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: Center(
        //         child: Text(
        //           "PIPO",
        //           style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget adjustmentTypeAndReason() {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 16.w, right: 16.0, bottom: 35.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: Text(
                "Adjustment type",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: myAdjustmentBool
                    ? DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: false,
                          child: DropdownButton<String>(
                            hint: Text('Adjustment type'),

                            iconSize: 30.h,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            // hint: Text('Select leave'),
                            onChanged: (newValue) {
                              setState(() {
                                adjustmentId = newValue!;
                                myAdjustmentBool = false;
                              });
                            },
                            items: adjustmentList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['ADJUSTMENT']),
                                value: item['ADJ_TYPE'].toString(),
                                onTap: () async {
                                  adjustmentType = item['ADJ_TYPE'];
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

                            value: adjustmentId,

                            iconSize: 30.h,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            // hint: Text('Select leave'),
                            onChanged: (newValue) {
                              setState(() {
                                adjustmentId = newValue!;
                                myAdjustmentBool = false;
                              });
                            },
                            items: adjustmentList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['ADJUSTMENT']),
                                value: item['ADJ_TYPE'].toString(),
                                onTap: () async {
                                  adjustmentType = item['ADJ_TYPE'];
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
              )
            ],
          ),
          // FormHelper.dropDownWidget(
          //   context,
          //   "Select Leave Type",
          //   this.adjustmentId,
          //   this.adjustmentList,
          //   (onChangedval) {
          //     this.adjustmentId = onChangedval;
          //     dropDownController.text = onChangedval;

          //     print("selected:$onChangedval");
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
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: Text(
                "Reason",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: 40.h,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                //color: Color.fromARGB(255, 255, 248, 248),
                ),
            child: TextFormField(
              autofillHints: ["hello", "helloooo"],
              controller: reasonController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Global_User_theme)),
                  hintText: "Enter Reason",
                  labelText: "Reason Here",
                  labelStyle: TextStyle(color: Global_User_theme),
                  // hintStyle: TextStyle(color: Colors.grey),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget hours() {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 16.w, right: 16.w, bottom: 35.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(
                    "From hours",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width / 2.4,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.grey.shade50),
                  // ),
                  child: TextFormField(
                    controller: fromHoursController,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Global_User_theme)),
                      icon: Icon(
                        Icons.timer,
                        color: Global_User_theme,
                      ),
                      hintText: "Select Time",
                    ),
                    readOnly: true,
                    onTap: () async {
                      pickedFromTime = await showTimePicker(
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
                        initialTime:
                            pickedFromTime ?? TimeOfDay(hour: 12, minute: 0),
                        context: context,
                      );

                      if (pickedFromTime != null) {
                        print(pickedFromTime!.format(context));
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedFromTime!.format(context).toString());

                        print(parsedTime);
                        String formattedTime =
                            DateFormat('HH:mm').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          // fromHoursController.text =
                          //     formattedTime;

                          fromHoursController.text = formatDate(
                              DateTime(2019, 08, 1, parsedTime.hour,
                                  parsedTime.minute),
                              [hh, ':', nn, " ", am]).toString();
                          fromTime();
                          convertTimeTo24(fromHoursController.text);
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  )
                  //  TextFormField(
                  //   readOnly: true,
                  //   controller: fromHoursController,
                  //   scrollPhysics: NeverScrollableScrollPhysics(),
                  //   textAlign: TextAlign.justify,
                  //   keyboardType: TextInputType.multiline,
                  //   decoration: InputDecoration(
                  //     suffixIcon: IconButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             fromHours(context);
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
                  //     hintText: fromHoursTimeText(),
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
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(
                    "To hours",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: TextField(
                    controller: toHoursController,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Global_User_theme)),
                        icon: Icon(
                          Icons.timer,
                          color: Global_User_theme,
                        ),
                        hintText: "Select Time"),
                    readOnly: true,
                    onTap: () async {
                      pickedTOtime = await showTimePicker(
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
                        initialTime:
                            pickedTOtime ?? TimeOfDay(hour: 12, minute: 0),
                        context: context,
                      );

                      if (pickedTOtime != null) {
                        print(pickedTOtime!.format(context));
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTOtime!.format(context).toString());

                        print(parsedTime);
                        String formattedTime =
                            DateFormat('HH:mm').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          // fromHoursController.text =
                          //     formattedTime;

                          toHoursController.text = formatDate(
                              DateTime(2019, 08, 1, parsedTime.hour,
                                  parsedTime.minute),
                              [hh, ':', nn, " ", am]).toString();
                        });
                        totime();
                        convertTimeToSecond(toHoursController.text);
                      } else {
                        print("Time is not selected");
                      }
                    },
                  )

                  //  TextFormField(
                  //   readOnly: true,
                  //   controller: toHoursController,
                  //   scrollPhysics: NeverScrollableScrollPhysics(),
                  //   textAlign: TextAlign.justify,
                  //   keyboardType: TextInputType.multiline,
                  //   decoration: InputDecoration(
                  //     suffixIcon: IconButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             toHours(context);
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
                  //     hintText: toHoursTimeText(),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget totalHours() {
    return Padding(
      padding: EdgeInsets.only(
        top: 0,
        left: 16.w,
        right: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Total hours",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: 40,
            // padding: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                //color: Color.fromARGB(255, 255, 248, 248),
                ),
            child: Container(
              width: 80.w,
              height: 40.h,
              // padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 255, 248, 248),
                  ),
              child: TextFormField(
                readOnly: true,
                controller: totalHoursController,
                decoration: InputDecoration(
                    hintText: "Total hours",
                    //labelText: "No of days",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttons() {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 16.w, right: 16.w, bottom: 28.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: (() {
              if (widget.edit == 1) {
                hrReconcilationEditBtn();
              }
              saveHourAdjustment();
            }),
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              // padding: EdgeInsets.only(top: 30.0, left: 150, right: 1),
              child: Container(
                width: 100.w,
                height: 40.h,
                // margin: EdgeInsets.symmetric(horizontal: 100),
                decoration: BoxDecoration(
                  color: Global_User_theme,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sm,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              clear();
            },
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              // padding: EdgeInsets.only(top: 30.0, left: 150, right: 1),
              child: Container(
                width: 100.w,
                height: 40.h,
                //margin: EdgeInsets.symmetric(horizontal: 100),
                decoration: BoxDecoration(
                  color: Global_User_theme,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    "Reset",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sm,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void clear() {
    setState(() {
      ShowpipoData = false;
    });

    reasonController.clear();
    dropDownController.clear();
    fromHoursController.clear();
    dateController.clear();
    toHoursController.clear();
    totalHoursController.clear();
    pickedFromTime = null;
    pickedTOtime = null;
    pickedDate = null;
    pickedDate = null;
  }

  fromTime() async {
    if (fromHoursController.text != "") {
      var from_hour_in_minute = await conv_Time_to_Minute(pickedFromTime!);
      if (toHoursController.text != "") {
        var to_hour_in_minute = await conv_Time_to_Minute(pickedTOtime!);
        var total_min = to_hour_in_minute - from_hour_in_minute;
        if (total_min <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("From hours should be less than To hours.")));
        } else {
          setState(() async {
            totalHoursController.text = await conv_minute_to_hour(total_min);
          });
        }
      }
    }
  }

  totime() async {
    if (toHoursController.text != "") {
      var to_hour_in_minute = await conv_Time_to_Minute(pickedTOtime!);
      if (to_hour_in_minute > 0 && fromHoursController.text != "") {
        // var f_hours = fromHoursController.text;
        var from_hour_in_minute = conv_Time_to_Minute(pickedFromTime!);

        var total_min = to_hour_in_minute - from_hour_in_minute;
        if (total_min <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("From hours should be less than To hours.")));
          toHoursController.clear();
        } else {
          totalHoursController.text = await conv_minute_to_hour(total_min);
        }
      }
    }
  }

  conv_minute_to_hour(val_mintues) {
    final int hour = val_mintues ~/ 60;
    final int minutes = val_mintues % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }

  conv_Time_to_Minute(TimeOfDay val_time) {
    var h = val_time.hour;
    var minutes = val_time.minute;
    var hours = h * 60;
    var tim_in_mintues = hours + minutes;
    return tim_in_mintues;
  }

  fromDateChange() async {
    if (dateController.text.isNotEmpty) {
      var dateres = await isValiddate(dateController.text);
      if (dateres) {
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
            dateController.clear();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Leave entry from date cannot be before date of joining.")));
            return false;
          }
          var restrict_flag = await funRestrict(dateController.text);
          if (restrict_flag == true) {
            dateController.clear();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "You are not allowed to enter leave for previous month")));
            return false;
          } else {
            var rsstr = await check3WorkingDay();
            if (rsstr != "success") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Error")));
              return false;
            }
          }
        }

        //getAdjMissing();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid date format!")));
        return;
      }
    }
  }

  check3WorkingDay() async {
    var str = "";
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "toDate": dateController.text,
        "fromDate": dateController.text,
        "leaveCode": "H",
        "noOfDay": 0.toString()
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/check3WorkingDay";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "hoursReconciliation", true);

      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/check3WorkingDay"),
      //     headers: {
      //       "MobileURL": "hoursReconciliation",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "toDate": dateController.text,
      //       "fromDate": dateController.text,
      //       "leaveCode": "H",
      //       "noOfDay": 0.toString()
      //     });
      var responsefromapi = json.decode(response!.body);
      if (responsefromapi != null) {
        if (responsefromapi != "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error")));

          return false;
        }
      }
      str = responsefromapi;
      return str;
    } catch (e) {
      print(e);
    }
  }

  funRestrict(frmDAte) async {
    var return_flag_val = false;
    try {
      Map data = {
        "cpfNo": globalInt.toString(),
        "ouID": ouId.toString(),
        "fromDate": dateController.text,
      };
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/RestrictInsertUpdateLeave";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "hoursReconciliation", true);
      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl/api/LeaveAPI/RestrictInsertUpdateLeave"),
      //     headers: {
      //       "MobileURL": "hoursReconciliation",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": globalInt.toString(),
      //       "ouID": ouId.toString(),
      //       "fromDate": dateController.text,
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

  Future dropDownApiBind() async {
    dropDownApiLoading = true;
    try {
      final String apiEndpoint =
          "$ServerUrl/api/LeaveAPI/GetAdjustmentTypeList?cpfNo=$globalInt";

      Response? response = await myHttpClient.GetMethod(
          apiEndpoint, "hoursReconciliation", true);
      // final Uri url = Uri.parse(apiEndpoint);
      // final response = await get(
      //   url,
      //   headers: {
      //     "MobileURL": "hoursReconciliation",
      //     "CPF_NO": globalInt.toString(),
      //     "Authorization": "Bearer $JWT_Tokken"
      //   },
      // );

      var jsonBody = response!.body;
      if (jsonBody.isNotEmpty) {
        var jsonData = json.decode(jsonBody);
        print(jsonBody);
        setState(() {
          adjustmentList = jsonData['Table'];
          dropDownApiLoading = false;
        });
        print(adjustmentList);
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
    } finally {
      setState(() {
        dropDownApiLoading = false;
      });
    }
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

  saveHourAdjustment() async {
    _openLoadingDialog(context);
    // setState(() {
    //   dropDownApiLoading = true;
    // });
    if (dateController.text == "") {
      Navigator.pop(context);
      // setState(() {
      //   dropDownApiLoading = false;
      // });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please select the date")));
      return false;
    }
    if (reasonController.text == "") {
      Navigator.pop(context);
      // setState(() {
      //   dropDownApiLoading = false;
      // });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter the reason")));
      return false;
    }
    if (fromHoursController.text != "") {
      if (toHoursController.text != "") {
        var from_hour_in_minute = await conv_Time_to_Minute(pickedFromTime!);
        var to_hour_in_minute = await conv_Time_to_Minute(pickedTOtime!);
        var total_min = to_hour_in_minute - from_hour_in_minute;
        if (total_min <= 0) {
          Navigator.pop(context);
          // setState(() {
          //   dropDownApiLoading = false;
          // });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("From hours should be less than To hours")));
          return false;
        }
      } else {
        Navigator.pop(context);
        // setState(() {
        //   dropDownApiLoading = false;
        // });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please enter To Time")));
        return false;
      }
    } else {
      Navigator.pop(context);
      // setState(() {
      //   dropDownApiLoading = false;
      // });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter From Time")));
      return false;
    }
    try {
      // setState(() {
      //   dropDownApiLoading = true;
      // });

      Map data = {
        "serialNo": "0",
        "flag": "INSERT",
        "CpfNo": globalInt.toString(),
        "AdjustmentType": adjustmentType.toString(),
        "fromTime": FromtimeData.text,
        "toTime": Totimedata.text,
        "fromDate": dateController.text,
        "toDate": dateController.text,
        "reason": reasonController.text,
        "leaveYear": "",
        "approved": "N",
        "Updatedflag": "E",
        "TotalHours": totalHoursController.text
      };
      String jsonString = json.encode(data);
      print(jsonString);

      String _apiendpoint = "$ServerUrl/api/LeaveAPI/save_hours_adjustment";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "hoursReconciliation", true);
      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl/api/LeaveAPI/save_hours_adjustment"),
      //     headers: {
      //       "MobileURL": "hoursReconciliation",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken",
      //       "Content-Type": "application/json"
      //     },
      //     body: jsonString
      //     );

      var response_fromapi = json.decode(response!.body);
      var dataresponse = response_fromapi["Output"];
      var MSG = response_fromapi["MSG"];
      if (dataresponse == "ERROR") {
        Navigator.pop(context);
        // setState(() {
        //   dropDownApiLoading = false;
        // });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error $MSG")));
      } else if (dataresponse == "SUCCESS") {
        Navigator.pop(context);
        // setState(() {
        //   dropDownApiLoading = false;
        // });

        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Sucess',
          desc: MSG,
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
    } finally {
      FromtimeData.clear();
      fromHoursController.clear();
      toHoursController.clear();
      Totimedata.clear();
      dateController.clear();

      reasonController.clear();
      totalHoursController.clear();
      pickedFromTime = null;
      pickedTOtime = null;
      dropDownController.clear();
      pickedDate = null;
    }
  }

  hrReconcilationEditBtn() async {
    if (widget.APPROVED == "Y") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You cannot edit approved  record")));
      return false;
    }
    var serialNo = widget.SerialNo;
    convertTimeTo24(fromHoursController.text);
    convertTimeToSecond(toHoursController.text);

    var total_hours = widget.totalhourforedit;

    try {
      _openLoadingDialog(context);
      // setState(() {
      //   dropDownApiLoading = true;
      // });

      Map data = {
        "serialNo": serialNo.toString(),
        "flag": "EDIT",
        "CpfNo": globalInt.toString(),
        "AdjustmentType": adjustmentType.toString(),
        "fromTime": FromtimeData.text,
        "toTime": Totimedata.text,
        "fromDate": dateController.text,
        "toDate": dateController.text,
        "reason": reasonController.text,
        "leaveYear": "",
        "approved": "N",
        "Updatedflag": "E",
        "TotalHours": totalHoursController.text
      };
      String jsonString = json.encode(data);
      print(jsonString);

      String _apiendpoint = "$ServerUrl/api/LeaveAPI/save_hours_adjustment";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "hoursReconciliation", true);

      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl/api/LeaveAPI/save_hours_adjustment"),
      //     headers: {
      //       "MobileURL": "hoursReconciliation",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken",
      //       "Content-Type": "application/json"
      //     },
      //     body: jsonString);

      var response_fromapi = json.decode(response!.body);
      var dataresponse = response_fromapi["Output"];
      var MSG = response_fromapi["MSG"];
      if (dataresponse == "ERROR") {
        Navigator.pop(context);
        // setState(() {
        //   dropDownApiLoading = false;
        // });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error $MSG")));
      } else if (dataresponse == "SUCCESS") {
        Navigator.pop(context);
        // setState(() {
        //   dropDownApiLoading = false;
        // });
        // SweetAlert.show(context,
        //     title: "SUCCESS", subtitle: MSG, style: SweetAlertStyle.success);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Sucess',
          desc: MSG,
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
    } finally {
      FromtimeData.clear();
      fromHoursController.clear();
      toHoursController.clear();
      Totimedata.clear();
      dateController.clear();

      reasonController.clear();
      totalHoursController.clear();
      pickedFromTime = null;
      pickedTOtime = null;
      dropDownController.clear();
      pickedDate = null;
    }
  }

  Future apiForUserDetails() async {
    try {
      Map data = {"ID": globalInt.toString(), "Flag": "test"};
      String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetEmployeeDetail";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "hoursReconciliation", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/LeaveAPI/GetEmployeeDetail"),
      //     headers: {
      //       "MobileURL": "hoursReconciliation",
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
          // var jsonmaindata = map['Table'];
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

  //!<----------funtion for time display in text box field----------------->

  // Future fromHours(BuildContext) async {
  //   final initialTime = TimeOfDay(hour: 12, minute: 0);
  //   final newTime = await showTimePicker(
  //       context: context, initialTime: mainTime ?? initialTime);
  //   if (newTime == null) return;
  //   setState(() {
  //     mainTime = newTime;
  //   });
  // }

  // String fromHoursTimeText() {
  //   if (mainTime == null) {
  //     return 'Select Time';
  //   } else {
  //     fromHoursController.text = formatDate(
  //         DateTime(2019, 08, 1, mainTime!.hour, mainTime!.minute),
  //         [hh, ':', nn, " ", am]).toString();
  //     final hours = mainTime?.hour.toString().padLeft(2, '0');
  //     final minutes = mainTime?.minute.toString().padLeft(2, '0');

  //     return '$hours : $minutes';
  //   }
  // }
  // //<----------funtion for time display in text box field----------------->

  // //!<----------funtion for time display in text box field 2----------------->

  // Future toHours(BuildContext) async {
  //   final initialTime = TimeOfDay(hour: 12, minute: 0);
  //   final newTime = await showTimePicker(
  //       context: context, initialTime: mainTime2 ?? initialTime);
  //   if (newTime == null) return;
  //   setState(() {
  //     mainTime2 = newTime;
  //   });
  // }

  // String toHoursTimeText() {
  //   if (mainTime2 == null) {
  //     return 'Select Time';
  //   } else {
  //     toHoursController.text = formatDate(
  //         DateTime(2022, 08, 1, mainTime2!.hour, mainTime2!.minute),
  //         [hh, ':', nn, " ", am]).toString();
  //     final hours = mainTime2?.hour.toString().padLeft(2, '0');
  //     final minutes = mainTime2?.minute.toString().padLeft(2, '0');

  //     return '$hours : $minutes';
  //   }
  // }
  // //<----------funtion for time display in text box field2----------------->

  // //!<----------funtion for date display in text box field----------------->

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

  // String? getDateText() {
  //   if (date == null) {
  //     return "Select Date";
  //   } else {
  //     dateController.text = DateFormat.yMd().format(date!);
  //     return DateFormat('MM/dd/yyyy').format(date!);
  //     // return "${date!.month}/${date!.day}/${date!.year}";
  //   }
  // }

  //<----------funtion for time display in text box field----------------->
}
