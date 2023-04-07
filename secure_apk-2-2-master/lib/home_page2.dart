// import 'dart:async';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// import 'package:overlay_support/overlay_support.dart';

// import 'package:secure_apk/globals.dart';

// import 'package:secure_apk/login_page.dart';
// import 'package:secure_apk/reuseablewidgets.dart/colors.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'AttendancePageUsingMLAuth.dart';
// import 'Face_Recognition_Authentication/widgets/app_button.dart';
// import 'Face_Recognition_Authentication/widgets/app_text_field.dart';
// import 'NotificitationServices/local_notification_service.dart';
// import 'models/profileModel.dart';
// import 'new_Approval_page.dart';

// //GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

// class HomePage2 extends StatefulWidget {
//   // String home;
//   // HomePage2({required this.home});

//   @override
//   State<HomePage2> createState() => _HomePage2State();
// }

// class _HomePage2State extends State<HomePage2> {
//   final TextEditingController _feedbackController =
//       TextEditingController(text: '');

//   bool _isManager = false;
//   bool circular = true;
//   bool _isLoading = true;
//   late ProfileModel profileModel;
//   bool _logOutLoading = false;
//   String deviceTokenToSendPushNotification = "";
//   late bool hasInternet;

//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     InternetConnectionChecker().onStatusChange.listen((event) {
//       final hasInternet = event == InternetConnectionStatus.connected;
//       setState(() => this.hasInternet = hasInternet);
//       if (!this.hasInternet) {
//         showSimpleNotification(
//             Text('No Internet',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                 )),
//             background: Colors.red);
//       } else {
//         checkEmployeeLevel();

//         userDetailApi(globalInt);

//         print(Platform.operatingSystem);
//       }
//     });

//     //  profileData();

// //!<----------------------------------FUNCTION FOR PUSH NOTIFICATION HANDLE---------------------------------------------------------------------------->
// // 1. This method call when app in terminated state and you get a notification
//     // when you click on notification app open from terminated state and you can get notification data in this method

//     FirebaseMessaging.instance.getInitialMessage().then(
//       (message) {
//         print("FirebaseMessaging.instance.getInitialMessage");
//         if (message != null) {
//           print("New Notification");
//           if (message.data['id'] != null) {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) => New_Approval_Page(2)),
//             );
//           }
//         }
//       },
//     );
//     // 2. This method only call when App in forground it mean app must be opened
//     FirebaseMessaging.onMessage.listen(
//       (message) {
//         print(message);
//         print("FirebaseMessaging.onMessage.listen");
//         if (message.notification != null) {
//           print(message.notification!.title);
//           print(message.notification!.body);
//           print("message.data11 ${message.data}");

//           if (message.data['id'] != null) {
//             print("dattttttttttaaa");
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) => New_Approval_Page(2)),
//             );
//           }
//           LocalNotificationService.createanddisplaynotification(message);
//         }
//       },
//     );

//     // 3. This method only call when App in background and not terminated(not closed)
//     FirebaseMessaging.onMessageOpenedApp.listen(
//       (message) {
//         print("FirebaseMessaging.onMessageOpenedApp.listen");
//         if (message.notification != null) {
//           print(message.notification!.title);
//           print(message.notification!.body);
//           print("message.data22 ${message.data['_id']}");
//           if (message.data['id'] != null) {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) => New_Approval_Page(2)),
//             );
//           }
//         }
//       },
//     );
//   }
//   //<--------------------------------------FUNCTION FOR PUSH NOTIFICATION HANDLE----------------------------------------------------------------------------------->

//   Future<void> getDeviceTokenToSendNotification() async {
//     //FUNCATION FOR GETTING THE DEVICE TOKKEN FOR THE PUSH NOTIFICATION FOR A PARTICULAR DEVICE ONLY
//     final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//     final token = await _fcm.getToken();
//     deviceTokenToSendPushNotification = token.toString();
//     print("Token Value $deviceTokenToSendPushNotification");
//   }

//   Future checkEmployeeLevel() async {
//     //function for checking weather the user is manager or not
//     try {
//       Response response = await get(
//         Uri.parse(
//             "http://172.16.15.129:8073/api/TeamLeaveAPI/GETteamDet?cpfNo=$globalInt"),

//         // body: {"cpfNo": "42914"}
//         headers: {
//           "MobileURL": "Leaveapprovalpage",
//           "CPF_NO": globalInt.toString()
//         },
//       );
//       //.timeout(const Duration(seconds: 10));

//       if (response.statusCode == 200) {
//         var jsonBody = response.body;
//         var jsonData = json.decode(jsonBody);
//         var length = jsonData.length;
//         print("Length is=$length");
//         if (length > 1) {
//           setState(() {
//             _isManager = true;
//           });
//         }
//         setState(() {
//           _isLoading = false;
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Error, Please try again later.")));
//         return;
//       }
//     } on SocketException catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("No Internet Connection ")));
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<List<ProfileModel>> userDetailApi(var empno) async {
//     //FUNCATION FOR aPI CALL  FOR USER PROFILE DETAILS
//     List<ProfileModel> users = [];

//     final String apiEndpoint =
//         "http://172.16.15.129:8022/Employee/api/MobileAPI/GetUserInfo?CPF_NO=$empno";

//     final Uri url = Uri.parse(apiEndpoint);
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       var jsondata = response.body;
//       if (jsondata.isNotEmpty) {
//         setState(() {
//           final decodedData = jsonDecode(response.body);
//           if (decodedData.isNotEmpty) {
//             List<ProfileModel> list = List.from(decodedData)
//                 .map<ProfileModel>(
//                   (item) => ProfileModel.fromJson(item),
//                 )
//                 .toList();
//             profileModel = list.first;
//             circular = false;
//           } else {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return const AlertDialog(
//                   backgroundColor: Colors.red,
//                   content: Text(
//                     'Error! No response from server',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 );
//               },
//             );
//             return;
//           }
//         });
//         // print(profileModel.location_id);
//         var data = await SharedPreferences.getInstance();
//         data.setString("ou_id", profileModel.ou_id);
//         data.setString("date_of_joining", profileModel.date_of_joining);
//         data.setString("location_id", profileModel.location_id.toString());
//         data.setString("emp_name", profileModel.emp_name.toString());

//         ouId = data.get("ou_id").toString();
//         dateOfJoining = data.get("date_of_joining").toString();
//         location_id = data.get("location_id").toString();
//         emp_name = data.get("emp_name").toString();

//         print(ouId);
//         print(dateOfJoining);
//         print(globalInt);
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return const AlertDialog(
//               backgroundColor: Colors.red,
//               content: Text(
//                 'Error! No response from server',
//                 style: TextStyle(color: Colors.white),
//               ),
//             );
//           },
//         );
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.red,
//             content: Text(
//               'Error! ${response.statusCode}',
//               style: TextStyle(color: Colors.white),
//             ),
//           );
//         },
//       );
//     }
//     // print(globalInt);
//     return users;
//   }

//   logout() async {
//     Navigator.pop(context, true);
//     setState(() {
//       _logOutLoading = true;
//     });
//     //Logout function
//     final prefs = await SharedPreferences.getInstance();

//     try {
//       Response response = await post(
//           Uri.parse("http://172.16.15.129:8026/api/UserAuth/LoginADWithAuth"),
//           body: {"cpf_prc": globalInt, "flag": "0"});

//       if (response.statusCode == 200) {
//         print("api hit success");

//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => Login_page()),
//           (Route<dynamic> route) => false,
//         );
//         print(response.body);
//       } else {
//         print("faild");

//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => Login_page()),
//           (Route<dynamic> route) => false,
//         );
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       // setState(() {
//       //   _logOutLoading = false;
//       // });
//     }

//     prefs.clear();

//     //Navigator.pushNamed(context, "loginpage");

//     // Navigator.of(context)
//     //     .push(MaterialPageRoute(builder: (context) => Login_page()));
//   }

//   Future LogoutConfirmation() async {
//     //LOGOOUT CONFRIM ALERT BOX FUNCTION

//     return showDialog(
//       context: context,
//       builder: (context) => new AlertDialog(
//         title: Text("Are you  sure"),
//         content: Text("Do you want to log out?"),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 Navigator.pop(context, false);
//               },
//               child: Text("No")),
//           TextButton(
//               onPressed: () {
//                 logout();
//                 //  Navigator.pop(context, true);
//               },
//               child: Text("Yes")),
//         ],
//       ),
//     );
//   }

//   var hour = DateTime.now().hour;
//   String greeting() {
//     if (hour < 12) {
//       return 'Good Morning';
//     }
//     if (hour < 17) {
//       return 'Good Afternoon';
//     }
//     return 'Good Evening';
//   }

//   @override
//   Widget build(BuildContext context) {
//     getDeviceTokenToSendNotification();
//     return Scaffold(
//         // key: globalKey,
//         appBar: AppBar(
//           shadowColor: Colors.white,
//           elevation: 1,
//           backgroundColor: securePurpleColor,
//           title: Text(
//             "Dashboard",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           actions: [circularBird()],
//         ),
//         backgroundColor: securePurpleColor,
//         drawer: _logOutLoading
//             ? Center(
//                 child: CircularProgressIndicator(
//                     color: Color.fromARGB(255, 246, 246, 246)),
//               )
//             :
//             //  circular
//             //     ? Center(
//             //         child: CircularProgressIndicator(
//             //             color: Color.fromRGBO(123, 34, 83, 1)),
//             //       )
//             //     :
//             Drawer(
//                 child: ListView(
//                   children: [
//                     circular
//                         ? Center(
//                             child: CircularProgressIndicator(
//                                 color: securePurpleColor),
//                           )
//                         : DrawerHeader(
//                             padding: EdgeInsets.zero,
//                             child: UserAccountsDrawerHeader(
//                               decoration: BoxDecoration(
//                                 color: securePurpleColor,
//                               ),
//                               accountName: Text(profileModel.emp_name_cpf_no),
//                               accountEmail: Text(profileModel.email),
//                               currentAccountPicture: CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 backgroundImage: MemoryImage(
//                                     base64Decode(profileModel.cpf_image)),
//                               ),
//                             ),
//                           ),
//                     ListTile(
//                       focusColor: Color(0xffFF5C5C),
//                       onTap: () {
//                         // print(location_id);

//                         Navigator.pushNamed(context, "viewprofile");

//                         // Navigator.of(context).push(MaterialPageRoute(
//                         //     builder: (context) => ViewProfile(value: home)));
//                       },
//                       leading: Icon(
//                         CupertinoIcons.person,
//                         size: 30.h,
//                       ),
//                       title: Text(
//                         "View Profile",
//                         textScaleFactor: 1.h,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w300, fontSize: 14.sp),
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => AttandencePageUisngMl(
//                                     image: null,
//                                     isPunchInOrOut: null,
//                                   )),
//                         );
//                       },
//                       leading: Icon(
//                         Icons.event_available,
//                         size: 30.h,
//                       ),
//                       title: Text(
//                         "Mark Attendance",
//                         textScaleFactor: 1.h,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w300, fontSize: 14.sp),
//                       ),
//                     ),
//                     // ListTile(
//                     //   onTap: () {},
//                     //   leading: Icon(
//                     //     CupertinoIcons.search,
//                     //     size: 30.h,
//                     //   ),
//                     //   title: Text(
//                     //     "Track Employee",
//                     //     textScaleFactor: 1.h,
//                     //     style:
//                     //         TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
//                     //   ),
//                     // ),
//                     // ListTile(
//                     //   onTap: () {
//                     //     // Navigator.pushNamed(context, "Adjustmentapprovalpage");
//                     //   },
//                     //   leading: Icon(
//                     //     Icons.inventory_2_outlined,
//                     //     size: 30.h,
//                     //   ),
//                     //   title: Text(
//                     //     "Mark OD / Tour",
//                     //     textScaleFactor: 1.h,
//                     //     style:
//                     //         TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
//                     //   ),
//                     // ),
//                     ListTile(
//                       onTap: () {
//                         Navigator.pushNamed(context, "leaveRequest");

//                         // Navigator.pushReplacement(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //       builder: (context) => LeaveRequest(
//                         //           reasonforedit: "",
//                         //           edit: 0,
//                         //           SerialNo: 0,
//                         //           APPROVED: "",
//                         //           FROM_1HALF_FLAGforedit: "",
//                         //           FROM_2HALF_FLAGforedit: "",
//                         //           To_1HALF_FLAGforedit: "",
//                         //           To_2HALF_FLAGforedit: "",
//                         //           fromdateforedit: "",
//                         //           leaveTypeforedit: 0,
//                         //           todateforedit: "",
//                         //           totaldaysforedit: 0,
//                         //           From_timeFor_edit: "",
//                         //           To_timeFor_edit: "",
//                         //           TYPE_OF_LEAVE: "")),
//                         // );
//                       },
//                       leading: Icon(
//                         Icons.work_off_outlined,
//                         size: 30.h,
//                       ),
//                       title: Text(
//                         "Leave Request",
//                         textScaleFactor: 1.h,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w300, fontSize: 14.sp),
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         Navigator.pushNamed(context, "hoursReconciliation");
//                       },
//                       leading: Icon(
//                         CupertinoIcons.time,
//                         size: 30.h,
//                       ),
//                       title: Text(
//                         "Hours reconciliation",
//                         textScaleFactor: 1.h,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w300, fontSize: 14.sp),
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         Navigator.pop(context, true);
//                         _feedbackController.clear();

//                         showModalBottomSheet(
//                             isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                               // <-- SEE HERE
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(25.0),
//                               ),
//                             ),
//                             context: context,
//                             builder: (context) {
//                               return Padding(
//                                 padding: MediaQuery.of(context).viewInsets,
//                                 child: Container(
//                                   padding: EdgeInsets.all(30),
//                                   child: SizedBox(
//                                     height: 200,
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         Container(
//                                           child: Column(
//                                             children: [
//                                               Container(
//                                                 child: Text(
//                                                   'Hello,  ' + emp_name + '😃',
//                                                   style:
//                                                       TextStyle(fontSize: 20),
//                                                 ),
//                                               ),
//                                               SizedBox(height: 10),
//                                               Container(
//                                                 child: Text(
//                                                   'Share your valuable feedback',
//                                                   style:
//                                                       TextStyle(fontSize: 20),
//                                                 ),
//                                               ),
//                                               SizedBox(height: 20),
//                                               AppTextField(
//                                                 controller: _feedbackController,
//                                                 labelText: "Your feedback...",
//                                                 isPassword: true,
//                                               ),
//                                               SizedBox(height: 10),
//                                               AppButton(
//                                                 color: Color.fromRGBO(
//                                                     123, 34, 83, 1),
//                                                 text: 'Send',
//                                                 onPressed: () async {},
//                                                 icon: Icon(
//                                                   Icons.check,
//                                                   color: Colors.white,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             });
//                       },
//                       leading: Icon(
//                         Icons.feedback,
//                         size: 30.h,
//                       ),
//                       title: Text(
//                         "Feedback",
//                         textScaleFactor: 1.h,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w300, fontSize: 14.sp),
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         Navigator.pushNamed(context, "Leaveapprovalpage");
//                       },
//                       leading: Icon(
//                         CupertinoIcons.phone_arrow_up_right,
//                         size: 30.h,
//                       ),
//                       title: Text(
//                         "Emergency Contact No.",
//                         textScaleFactor: 1.h,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w300, fontSize: 14..sp),
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         // logout();
//                         LogoutConfirmation();
//                       },
//                       leading: Icon(
//                         Icons.exit_to_app,
//                         size: 30.h,
//                       ),
//                       title: Text(
//                         "Logout",
//                         textScaleFactor: 1.h,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w300, fontSize: 14.sp),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           margin: EdgeInsets.zero,
//           child: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Stack(
//                     children: <Widget>[
//                       // Container(
//                       //   height: 300.h,
//                       //   width: double.infinity,
//                       //   color: Color.fromRGBO(123, 34, 83, 1),
//                       // ),
//                       circular
//                           ? Center(
//                               child: CircularProgressIndicator(
//                                   color: securePurpleColor),
//                             )
//                           : Container(
//                               color: Color.fromRGBO(123, 34, 83, 6),
//                               width: MediaQuery.of(context).size.width,
//                               height: 80.h,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 20, right: 20, top: 20),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20.r),
//                                       color: Colors.grey.shade200),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 0.w),
//                                     child: Column(
//                                         // mainAxisAlignment: MainAxisAlignment.center,
//                                         // crossAxisAlignment: CrossAxisAlignment.end,
//                                         children: [
//                                           SizedBox(
//                                             height: 5.h,
//                                           ),
//                                           Text(
//                                             greeting(),
//                                             style: TextStyle(
//                                                 fontSize: 20.sm,
//                                                 color: Color.fromRGBO(
//                                                     123, 34, 83, 1),
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           SizedBox(
//                                             height: 5.h,
//                                           ),
//                                           Text(
//                                             profileModel.emp_name,
//                                             style: TextStyle(
//                                                 fontSize: 20.sm,
//                                                 color: Color.fromRGBO(
//                                                     123, 34, 83, 1),
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         ]),
//                                   ),
//                                 ),
//                               ),

//                               // Card(
//                               //   color: Color.fromRGBO(123, 34, 83, 20),
//                               //   child: Column(
//                               //     children: [
//                               //       Text(
//                               //         greeting(),
//                               //         style: TextStyle(
//                               //             color: Colors.white,
//                               //             fontWeight: FontWeight.bold,
//                               //             fontSize: 20),
//                               //       )
//                               //     ],
//                               //   ),
//                               // ),
//                             ),
//                       // Container(
//                       //   margin: EdgeInsets.only(left: 90, bottom: 20),
//                       //   width: 299,
//                       //   height: 279,
//                       //   decoration: BoxDecoration(
//                       //       color: Color.fromARGB(255, 247, 247, 247),
//                       //       borderRadius: BorderRadius.only(
//                       //           topLeft: Radius.circular(160),
//                       //           bottomLeft: Radius.circular(290),
//                       //           bottomRight: Radius.circular(160),
//                       //           topRight: Radius.circular(10))),
//                       // ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 16.w, vertical: 90.h),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             // Text("Welcome to",
//                             //     style: TextStyle(
//                             //         fontSize: 28,
//                             //         fontWeight: FontWeight.w800,
//                             //         color: Colors.white)),
//                             // Text("Secure",
//                             //     style: TextStyle(
//                             //         fontSize: 28,
//                             //         fontWeight: FontWeight.w800,
//                             //         color: Colors.white)),
//                             // SizedBox(
//                             //   height: 40,
//                             // ),
//                             Container(
//                               width: double.infinity,

//                               // height: 900.h,
//                               height: MediaQuery.of(context).size.height,
//                               // margin: EdgeInsets.only(top: 10),
//                               child: dashBoardGrid(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   Widget dashBoardGrid() {
//     return _isLoading
//         ? Center(
//             child: CircularProgressIndicator(
//                 color: Color.fromARGB(255, 246, 246, 246)),
//           )
//         : Container(
//             width: double.infinity,
//             //height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(),
//             child: GridView(
//               physics: AlwaysScrollableScrollPhysics(),
//               padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 9.w,
//                   mainAxisSpacing: 12.h),
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     // Navigator.pushNamed(context, "attendancePage");
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => AttandencePageUisngMl(
//                                 image: null,
//                                 isPunchInOrOut: null,
//                               )),
//                     );
//                     print("attendance");
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50.r),
//                         color: Colors.grey.shade200),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.calendar_today_sharp,
//                             size: 45.sm,
//                             color: securePurpleColor,
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           Text(
//                             "Mark Attendance",
//                             style: TextStyle(
//                                 fontSize: 15.sm,
//                                 color: securePurpleColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ]),
//                   ),
//                 ),
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     print("mark");
//                 //   },
//                 //   child: Container(
//                 //     decoration: BoxDecoration(
//                 //         borderRadius: BorderRadius.circular(50.r),
//                 //         color: Colors.grey.shade200),
//                 //     child: Column(
//                 //         mainAxisAlignment: MainAxisAlignment.center,
//                 //         crossAxisAlignment: CrossAxisAlignment.center,
//                 //         children: [
//                 //           Icon(
//                 //             Icons.inventory_2_outlined,
//                 //             size: 45.sm,
//                 //             color: securePurpleColor,
//                 //           ),
//                 //           SizedBox(
//                 //             height: 10,
//                 //           ),
//                 //           Text(
//                 //             "Mark OD / Tour",
//                 //             style: TextStyle(
//                 //                 fontSize: 15.sm,
//                 //                 color: securePurpleColor,
//                 //                 fontWeight: FontWeight.bold),
//                 //           ),
//                 //         ]),
//                 //   ),
//                 // ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, "viewprofile");

//                     // Navigator.of(context).push(MaterialPageRoute(
//                     //     builder: (context) => ViewProfile(value: home)));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50.r),
//                         color: Colors.grey.shade200),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.person,
//                             size: 45.sm,
//                             color: securePurpleColor,
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           Text(
//                             "View Profile",
//                             style: TextStyle(
//                                 fontSize: 15.sm,
//                                 color: securePurpleColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ]),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, "leaveRequest");
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50.r),
//                         color: Colors.grey.shade200),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.work_off_outlined,
//                             size: 45.sm,
//                             color: securePurpleColor,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "Leave Request",
//                             style: TextStyle(
//                                 fontSize: 15.sm,
//                                 color: securePurpleColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ]),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, "hoursReconciliation");
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50.r),
//                         color: Colors.grey.shade200),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.timer,
//                             size: 45.sm,
//                             color: securePurpleColor,
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           FittedBox(
//                             child: Text(
//                               "Reconciliation",
//                               style: TextStyle(
//                                   fontSize: 15.sm,
//                                   color: securePurpleColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ]),
//                   ),
//                 ),
//                 Visibility(
//                   visible: _isManager,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, "Leaveapprovalpage");
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50.r),
//                           color: Colors.grey.shade200),
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.check_circle_sharp,
//                               size: 45.sm,
//                               color: securePurpleColor,
//                             ),
//                             SizedBox(
//                               height: 10.h,
//                             ),
//                             Text(
//                               "Approval",
//                               style: TextStyle(
//                                   fontSize: 15.sm,
//                                   color: securePurpleColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ]),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
// }
