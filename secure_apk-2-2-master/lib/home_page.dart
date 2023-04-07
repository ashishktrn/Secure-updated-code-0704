import 'dart:convert';

import 'dart:io';
import 'package:badges/badges.dart' as badges;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secure_apk/AttendancePageUsingMLAuth.dart';
import 'package:secure_apk/login_page.dart';
import 'package:secure_apk/new_Approval_page.dart';
import 'package:secure_apk/reuseablewidgets.dart/colors.dart';
import 'package:secure_apk/reuseablewidgets.dart/sessionexpire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'Face_Recognition_Authentication/widgets/app_button.dart';
import 'NotificitationServices/local_notification_service.dart';
import 'globals.dart';
import 'models/profileModel.dart';
import 'my_encryption.dart';
import 'reuseablewidgets.dart/Common.dart';
import 'reuseablewidgets.dart/loder.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

var hour = DateTime.now().hour;
String greeting() {
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _feedbackController =
      TextEditingController(text: '');
  final GlobalKey<ScaffoldState> _key = GlobalKey(); //
  final _formkey = GlobalKey<FormState>();
  bool _isManager = false;
  bool _MobileAttendancerights = false;
  bool circular = true;
  bool _isLoading = true;
  late ProfileModel profileModel;
  bool _logOutLoading = false;
  bool _sendreportLoading = false;
  String deviceTokenToSendPushNotification = "";
  late bool hasInternet;
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  late sessionExpired sessionexpired = new sessionExpired(context);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrentTheme();
    checkEmployeeLevel();
    _determinePosition();
    // _CheckAttendanceRights();

    userDetailApi(globalInt);
    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      if (!mounted) return;
      setState(() => this.hasInternet = hasInternet);
      if (!this.hasInternet) {
        showSimpleNotification(
            Text('No Internet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            background: Colors.red);
      } else {
        checkEmployeeLevel();

        userDetailApi(globalInt);
        //  _CheckAttendanceRights();

        print(Platform.operatingSystem);
      }
    });

    //  profileData();

//!<----------------------------------FUNCTION FOR PUSH NOTIFICATION HANDLE---------------------------------------------------------------------------->
// 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          setState((() => NotificationCount += 1));
          print("New Notification");
          if (message.data['id'] != null) {
            print(message.data['id']);
            var data = await message.data['page'].toString();
            var id = await message.data['id'].toString();
            // print(data);
            if (data == "To Manager" && id == "1") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        New_Approval_Page(2)), // attendance approval
              );
            } else if (data == "To Manager" && id == "2") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        New_Approval_Page(0)), // leave approval
              );
            } else if (data == "To Manager" && id == "3") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        New_Approval_Page(1)), //adjustment ap[proval]
              );
            }

            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (context) => New_Approval_Page(2)),
            // );
          }
        }
      },
    );
    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) async {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");

          if (message.data['id'] != null) {
            setState((() => NotificationCount += 1));
            var data = await message.data['page'].toString();
            var id = await message.data['id'].toString();
            // print(data);
            if (data == "To Manager" && id == "1") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        New_Approval_Page(2)), // attendance approval
              );
            } else if (data == "To Manager" && id == "2") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        New_Approval_Page(0)), // leave approval
              );
            } else if (data == "To Manager" && id == "3") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        New_Approval_Page(1)), //adjustment ap[proval]
              );
            }
          }
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        setState((() => NotificationCount += 1));
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");

          if (message.data['id'] != null) {
            var data = await message.data['page'].toString();
            var id = await message.data['id'].toString();
            // print(data);
            if (data == "To Manager" && id == "1") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        New_Approval_Page(2)), // attendance approval
              );
            } else if (data == "To Manager" && id == "2") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        New_Approval_Page(0)), // leave approval
              );
            } else if (data == "To Manager" && id == "3") {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        New_Approval_Page(1)), //adjustment ap[proval]
              );
            }
            // print(message.data['id']);
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (context) => New_Approval_Page(2)),
            // );
          }
        }
      },
    );
  }

  Future<void> getDeviceTokenToSendNotification() async {
    //FUNCATION FOR GETTING THE DEVICE TOKKEN FOR THE PUSH NOTIFICATION FOR A PARTICULAR DEVICE ONLY
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  // Future _CheckAttendanceRights() async {
  //   String _apiEndPoint =
  //       "$ServerUrl/api/MobileAPI/CheckAttendanceRights?CPF_NO=$globalInt"; //replace with live end point
  //   try {
  //     Response response = await get(Uri.parse(_apiEndPoint), headers: {
  //       "MobileURL": "Leaveapprovalpage",
  //       "CPF_NO": globalInt.toString(),
  //       "Authorization": "Bearer $JWT_Tokken"
  //     });
  //     if (response.statusCode == 401) {
  //       var isunauth = response.reasonPhrase;
  //       if (isunauth == "Unauthorized") {
  //         sessionexpired.LogoutUser();

  //         return;
  //       }
  //     } else if (response.statusCode == 200) {
  //       print(response.body);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future CurrentTheme() async {
    //function for fetching current theme

    try {
      String _apiendpoint =
          "$ServerUrl/api/MobileAPI/UserTheme?CPF_NO=$globalInt&Flag=1&currentTheme=0";
      Response? response =
          await myHttpClient.GetMethod(_apiendpoint, "Leaveapprovalpage", true);
      // Response response = await get(
      //   Uri.parse(
      //       "$ServerUrl/api/MobileAPI/UserTheme?CPF_NO=$globalInt&Flag=1&currentTheme=0"),
      //   headers: {
      //     "MobileURL": "Leaveapprovalpage",
      //     "CPF_NO": globalInt.toString(),
      //     "Authorization": "Bearer $JWT_Tokken"
      //   },
      // );

      if (response!.statusCode == 200) {
        var jsonBody = response.body;
        var jsonData = json.decode(jsonBody);
        print(jsonData);
        if (jsonData != null) {
          var currentThemeId = jsonData[0]["CURRENTTHEME"].toInt();
          currentThemeId == 0
              ? Global_User_theme = securePurpleColor
              : currentThemeId == 1
                  ? Global_User_theme = DarkBlue
                  : currentThemeId == 2
                      ? Global_User_theme = DarkBrown
                      : currentThemeId == 3
                          ? Global_User_theme = liteGreen
                          : Global_User_theme = securePurpleColor;
          print(currentThemeId);
        } else {
          setState(() {
            Global_User_theme = securePurpleColor;
          });
        }
      } else {
        setState(() {
          Global_User_theme = securePurpleColor;
        });
      }
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No Internet Connection ")));
    } catch (e) {
      print(e);
    } finally {}
  }

  Future ChangeThemeRequest(int Selected_Theme) async {
    //function for changing current theme
    Navigator.pop(context);
    Navigator.pop(context);
    _openLoadingDialog(context);

    try {
      String _apiendpoint =
          "$ServerUrl/api/MobileAPI/UserTheme?CPF_NO=$globalInt&Flag=2&currentTheme=$Selected_Theme";
      Response? response =
          await myHttpClient.GetMethod(_apiendpoint, "Leaveapprovalpage", true);
      // Response response = await get(
      //   Uri.parse(
      //       "$ServerUrl/api/MobileAPI/UserTheme?CPF_NO=$globalInt&Flag=2&currentTheme=$Selected_Theme"),
      //   headers: {
      //     "MobileURL": "Leaveapprovalpage",
      //     "CPF_NO": globalInt.toString(),
      //     "Authorization": "Bearer $JWT_Tokken"
      //   },
      // );

      if (response!.statusCode == 200) {
        var jsonBody = response.body;
        var jsonData = json.decode(jsonBody);

        var message = jsonData[0]["STATUS"];
        if (message == "Succeed") {
          setState(() {
            Selected_Theme == 0
                ? Global_User_theme = securePurpleColor
                : Selected_Theme == 1
                    ? Global_User_theme = DarkBlue
                    : Selected_Theme == 2
                        ? Global_User_theme = DarkBrown
                        : Selected_Theme == 3
                            ? Global_User_theme = liteGreen
                            : Global_User_theme = securePurpleColor;
          });
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Internal server error ")));
        return;
      }
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No Internet Connection ")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Somethingb went wrong !")));
      print(e);
    } finally {
      Navigator.pop(context);
    }
  }

  Future checkEmployeeLevel() async {
    //function for checking weather the user is manager or not
    try {
      String _apiendpoint =
          "$ServerUrl/api/TeamLeaveAPI/GETteamDet?cpfNo=$globalInt";
      Response? response =
          await myHttpClient.GetMethod(_apiendpoint, "Leaveapprovalpage", true);
      // Response response = await get(
      //   Uri.parse(
      //       "$ServerUrl/api/TeamLeaveAPI/GETteamDet?cpfNo=$globalInt"),

      //   // body: {"cpfNo": "42914"}
      //   headers: {
      //     "MobileURL": "Leaveapprovalpage",
      //     "CPF_NO": globalInt.toString(),
      //     "Authorization": "Bearer $JWT_Tokken"
      //   },
      // );
      //.timeout(const Duration(seconds: 10));
      String _apiendpoint2 =
          "$ServerUrl/api/MobileAPI/CheckAttendanceRights?CPF_NO=$globalInt";
      Response? CheckRightsResponse = await myHttpClient.GetMethod(
          _apiendpoint2, "Leaveapprovalpage", true);
      // Response CheckRightsResponse = await get(
      //   Uri.parse(
      //       "$ServerUrl/api/MobileAPI/CheckAttendanceRights?CPF_NO=$globalInt"),
      //   headers: {
      //     "MobileURL": "Leaveapprovalpage",
      //     "CPF_NO": globalInt.toString(),
      //     "Authorization": "Bearer $JWT_Tokken"
      //   },
      // );

      if (response!.statusCode == 200) {
        var jsonBody = response.body;
        var jsonData = json.decode(jsonBody);
        var length = jsonData.length;
        print("Length is=$length");
        if (length > 1) {
          setState(() {
            _isManager = true;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error, Please try again later.")));
        return;
      }
      if (CheckRightsResponse!.statusCode == 200) {
        var jsonBody = CheckRightsResponse.body;
        var jsonData = json.decode(jsonBody);
        print(jsonData);
        if (jsonData == true) {
          setState(() {
            _MobileAttendancerights = true;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error, Please try again later.")));
        return;
      }
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No Internet Connection ")));
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<ProfileModel>> userDetailApi(var empno) async {
    //FUNCATION FOR aPI CALL  FOR USER PROFILE DETAILS
    List<ProfileModel> users = [];

    final String apiEndpoint =
        "$ServerUrl/api/MobileAPI/GETUSERDETAILS?CPF_NO=$empno";

    // final String apiEndpoint =
    //     "http://172.16.15.129:8022/Employee/api/MobileAPI/GetUserInfo?CPF_NO=$empno";

    Response? response = await myHttpClient.GetMethod(
        apiEndpoint, "Adjustmentapprovalpage", true);

    // final Uri url = Uri.parse(apiEndpoint);
    // final response = await get(
    //   url,
    //   headers: {
    //     //"MobileURL": "Leaveapprovalpage",
    //     "MobileURL": "Adjustmentapprovalpage",
    //     "CPF_NO": globalInt.toString(),
    //     "Authorization": "Bearer $JWT_Tokken"
    //   },
    // );

    if (response!.statusCode == 200) {
      var jsondata = response.body;
      if (jsondata.isNotEmpty && jsondata != "" && jsondata != "[]") {
        setState(() {
          final decodedData = jsonDecode(response.body);
          if (decodedData.isNotEmpty) {
            List<ProfileModel> list = List.from(decodedData)
                .map<ProfileModel>(
                  (item) => ProfileModel.fromJson(item),
                )
                .toList();
            profileModel = list.first;
            circular = false;
          } else {
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
            return;
          }
        });

        var data = await SharedPreferences.getInstance();
        var encrpted_Ou_ID =
            MyEncryption.CryptoGraphy("Encryption", profileModel.ou_id);
        data.setString("ou_id", encrpted_Ou_ID);
        var encrypted_DateOfJoining = MyEncryption.CryptoGraphy(
            "Encryption", profileModel.date_of_joining);
        data.setString("date_of_joining", encrypted_DateOfJoining);
        var encrypted_LocationId = MyEncryption.CryptoGraphy(
            "Encryption", profileModel.location_id.toString());
        data.setString("location_id", encrypted_LocationId);
        var encypted_emp_Name = MyEncryption.CryptoGraphy(
            "Encryption", profileModel.emp_name.toString());
        data.setString("emp_name", encypted_emp_Name);

        ouId = MyEncryption.CryptoGraphy(
            "Decryption", data.get("ou_id").toString());

        // data.get("ou_id").toString();
        dateOfJoining = MyEncryption.CryptoGraphy(
            "Decryption", data.get("date_of_joining").toString());
        // data.get("date_of_joining").toString();
        location_id = MyEncryption.CryptoGraphy(
            "Decryption", data.get("location_id").toString());
        //  data.get("location_id").toString();
        emp_name = MyEncryption.CryptoGraphy(
            "Decryption", data.get("emp_name").toString());
        //  data.get("emp_name").toString();

        print(ouId);
        print(dateOfJoining);
        print(globalInt);
      } else {
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
    // print(globalInt);
    return users;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permantly denied. we cannot request permissions.");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            "Location permissions are denied (actual value: $permission).");
      }
    }
    // var position =
    //     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // var lat = position;

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  permissionServiceCall() async {
    if (Platform.isAndroid) {
      await permissionServicesforandoird().then(
        (value) {
          if (value != null) {
            if (value[Permission.location]!.isGranted) {
              /* ========= New Screen Added  ============= */
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => AttandencePageUisngMl(
              //             image: null,
              //             isPunchInOrOut: null,
              //           )),
              // );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => showcasewidget()),
              );
            }
          }
        },
      );
    } else if (Platform.isIOS) {
      await permissionServicesforios().then(
        (value) {
          if (value != null) {
            if (value == LocationPermission.whileInUse ||
                value == LocationPermission.always) {
              /* ========= New Screen Added  ============= */
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => AttandencePageUisngMl(
              //             image: null,
              //             isPunchInOrOut: null,
              //           )),
              // );

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => showcasewidget()));
            }
          }
        },
      );
    }
  }

  Future<LocationPermission> permissionServicesforios() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await LocationPermission.deniedForever == true &&
                await Geolocator.checkPermission() == false) {
              // openAppSettings();
              permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  Future<Map<Permission, PermissionStatus>>
      permissionServicesforandoird() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,

      //add more permission to request here.
    ].request();

    print(await Permission.locationWhenInUse.request());

    if (statuses[Permission.location]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.location.status.isPermanentlyDenied == true &&
                await Permission.location.status.isGranted == false) {
              // openAppSettings();
              permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else {
      if (statuses[Permission.location]!.isDenied) {
        permissionServiceCall();
      }
    }

    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  logout() async {
    Navigator.pop(context, true);
    setState(() {
      _logOutLoading = true;
    });
    //Logout function
    final prefs = await SharedPreferences.getInstance();

    try {
      Map data = {"cpf_prc": globalInt, "flag": "0"};
      String _apiendpoint = "$ServerUrl/api/MobileLogin/LoginADWithAuth";
      Response? response =
          await myHttpClient.PostMethod(_apiendpoint, data, "null", false);
      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl/api/MobileLogin/LoginADWithAuth"), //add tokken
      //     body: {"cpf_prc": globalInt, "flag": "0"});

      if (response!.statusCode == 200) {
        print("api hit success");

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => Login_page()),
        //   (Route<dynamic> route) => false,
        // );
        prefs.clear();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login_page()));
        print(response.body);
      } else {
        print("faild");

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => Login_page()),
        //   (Route<dynamic> route) => false,
        // );
        prefs.clear();
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login_page()));
      }
    } catch (e) {
      print(e);
    } finally {
      // setState(() {
      //   _logOutLoading = false;
      // });
      // prefs.clear();
    }

    // prefs.clear();

    //Navigator.pushNamed(context, "loginpage");

    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => Login_page()));
  }

  Future LogoutConfirmation() async {
    //LOGOOUT CONFRIM ALERT BOX FUNCTION

    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text("Are you  sure"),
        content: Text("Do you want to log out?"),
        actions: [
          TextButton(
              onPressed: () {
                logout();
                //  Navigator.pop(context, true);
              },
              child: Text("Yes")),
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("No")),
        ],
      ),
    );
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

  Future ChangeTheme() async {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text("Choose Your Theme Color"),
        content: Row(
          children: [
            GestureDetector(
              onTap: () async {
                await ChangeThemeRequest(0);
                // setState(() {
                //   Global_User_theme = securePurpleColor;
                // });
              },
              child: Container(
                height: 50,
                width: 50,
                // margin: EdgeInsets.all(100.0),
                decoration: BoxDecoration(
                    color: securePurpleColor, shape: BoxShape.circle),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () async {
                await ChangeThemeRequest(1);
                // setState(() {
                //   Global_User_theme = DarkBlue;
                // });
              },
              child: Container(
                height: 50,
                width: 50,
                // margin: EdgeInsets.all(100.0),
                decoration:
                    BoxDecoration(color: DarkBlue, shape: BoxShape.circle),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () async {
                await ChangeThemeRequest(2);
                // setState(() {
                //   Global_User_theme = DarkBrown;
                // });
              },
              child: Container(
                height: 50,
                width: 50,
                // margin: EdgeInsets.all(100.0),
                decoration:
                    BoxDecoration(color: DarkBrown, shape: BoxShape.circle),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () async {
                await ChangeThemeRequest(3);
                // setState(() {
                //   Global_User_theme = liteGreen;
                // });
              },
              child: Container(
                height: 50,
                width: 50,
                // margin: EdgeInsets.all(100.0),
                decoration:
                    BoxDecoration(color: liteGreen, shape: BoxShape.circle),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();
    return Scaffold(
      key: _key,
      drawer: _logOutLoading
          ? Center(
              child: CustomLoader(
                dotColor: Global_User_theme,
              ),
            )
          :
          // Center(
          //     child: CircularProgressIndicator(
          //         color: Color.fromARGB(255, 246, 246, 246)),
          //   )
          // :
          //  circular
          //     ? Center(
          //         child: CircularProgressIndicator(
          //             color: Color.fromRGBO(123, 34, 83, 1)),
          //       )
          //     :
          Drawer(
              child: ListView(
                children: [
                  circular
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Global_User_theme),
                        )
                      : DrawerHeader(
                          padding: EdgeInsets.zero,
                          child: UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                              color: Global_User_theme,
                            ),
                            accountName: Text(profileModel.emp_name_cpf_no),
                            accountEmail: Text(profileModel.email),
                            currentAccountPicture: GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, "viewprofile"),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: MemoryImage(
                                    base64Decode(profileModel.cpf_image)),
                              ),
                            ),
                            otherAccountsPictures: [
                              GestureDetector(
                                onTap: (() => ChangeTheme()),
                                child: Icon(
                                  Icons.colorize_outlined,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),

                  ListTile(
                    focusColor: Color(0xffFF5C5C),
                    onTap: () {
                      Navigator.pushNamed(context, "viewprofile");

                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => ViewProfile(value: home)));
                    },
                    leading: Icon(
                      CupertinoIcons.person,
                      size: 20.h,
                    ),
                    title: Text(
                      "View Profile",
                      textScaleFactor: 1.h,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 11.sp),
                    ),
                  ),
                  Visibility(
                    visible: _MobileAttendancerights,
                    child: ListTile(
                      onTap: () {
                        permissionServiceCall();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => AttandencePageUisngMl(
                        //             image: null,
                        //             isPunchInOrOut: null,
                        //           )),
                        // );
                      },
                      leading: Icon(
                        Icons.event_available,
                        size: 20.h,
                      ),
                      title: Text(
                        "Mark Attendance",
                        textScaleFactor: 1.h,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 11.sp),
                      ),
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {},
                  //   leading: Icon(
                  //     CupertinoIcons.search,
                  //     size: 30.h,
                  //   ),
                  //   title: Text(
                  //     "Track Employee",
                  //     textScaleFactor: 1.h,
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
                  //   ),
                  // ),
                  // ListTile(
                  //   onTap: () {
                  //     // Navigator.pushNamed(context, "Adjustmentapprovalpage");
                  //   },
                  //   leading: Icon(
                  //     Icons.inventory_2_outlined,
                  //     size: 30.h,
                  //   ),
                  //   title: Text(
                  //     "Mark OD / Tour",
                  //     textScaleFactor: 1.h,
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "showcasewidgetLeave");

                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => LeaveRequest(
                      //           reasonforedit: "",
                      //           edit: 0,
                      //           SerialNo: 0,
                      //           APPROVED: "",
                      //           FROM_1HALF_FLAGforedit: "",
                      //           FROM_2HALF_FLAGforedit: "",
                      //           To_1HALF_FLAGforedit: "",
                      //           To_2HALF_FLAGforedit: "",
                      //           fromdateforedit: "",
                      //           leaveTypeforedit: 0,
                      //           todateforedit: "",
                      //           totaldaysforedit: 0,
                      //           From_timeFor_edit: "",
                      //           To_timeFor_edit: "",
                      //           TYPE_OF_LEAVE: "")),
                      // );
                    },
                    leading: Icon(
                      Icons.work_off_outlined,
                      size: 20.h,
                    ),
                    title: Text(
                      "Leave Request",
                      textScaleFactor: 1.h,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 11.sp),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "showcasewidgetAdjustment");
                    },
                    leading: Icon(
                      CupertinoIcons.time,
                      size: 20.h,
                    ),
                    title: Text(
                      "Hours reconciliation",
                      textScaleFactor: 1.h,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 11.sp),
                    ),
                  ),
                  // ListTile(
                  //   focusColor: Color(0xffFF5C5C),
                  //   onTap: () {
                  //     ChangeTheme();
                  //     // setState(() {
                  //     //   Global_User_theme = liteGreen;
                  //     // });
                  //   },
                  //   leading: Icon(
                  //     Icons.color_lens_outlined,
                  //     size: 20.h,
                  //   ),
                  //   title: Text(
                  //     "Change Theme",
                  //     textScaleFactor: 1.h,
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w300, fontSize: 11.sp),
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context, true);
                      _feedbackController.clear();

                      // showModalBottomSheet(
                      //     isScrollControlled: true,
                      //     shape: RoundedRectangleBorder(
                      //       // <-- SEE HERE
                      //       borderRadius: BorderRadius.vertical(
                      //         top: Radius.circular(25.0),
                      //       ),
                      //     ),
                      //     context: context,
                      //     builder: (context) {
                      //       return Padding(
                      //         padding: MediaQuery.of(context).viewInsets,
                      //         child: Container(
                      //           padding: EdgeInsets.all(30),
                      //           child: SizedBox(
                      //             height:
                      //                 MediaQuery.of(context).size.height / 3,
                      //             child: Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: <Widget>[
                      //                 Container(
                      //                   child: Column(
                      //                     children: [
                      //                       Container(
                      //                         child: Text(
                      //                           'Hello,  ' + emp_name + '😃',
                      //                           style: TextStyle(fontSize: 20),
                      //                         ),
                      //                       ),
                      //                       SizedBox(height: 10),
                      //                       Container(
                      //                         child: Text(
                      //                           'Share your valuable feedback',
                      //                           style: TextStyle(fontSize: 10),
                      //                         ),
                      //                       ),
                      //                       SizedBox(height: 20),
                      //                       AppTextField(
                      //                         controller: _feedbackController,
                      //                         labelText: "Your feedback...",
                      //                         isPassword: true,
                      //                       ),
                      //                       SizedBox(height: 10),
                      //                       AppButton(
                      //                         color: Color.fromRGBO(
                      //                             123, 34, 83, 1),
                      //                         text: 'Send',
                      //                         onPressed: () async {},
                      //                         icon: Icon(
                      //                           Icons.check,
                      //                           color: Colors.white,
                      //                         ),
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     });
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
                                  height:
                                      MediaQuery.of(context).size.height / 3.8,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 46.h,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(

                                                  // color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: FittedBox(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Hello , " +
                                                              emp_name +
                                                              '😃',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    FittedBox(
                                                      child: Text(
                                                        "We can't wait to get your thoughts on our app.",
                                                        style: TextStyle(
                                                            fontSize: 16.sm),
                                                      ),
                                                    ),
                                                    Text(
                                                      "What whould you like to do?",
                                                      style: TextStyle(
                                                          fontSize: 16.sm),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              // child: Text(
                                              //   'Hello,  ' + emp_name + '😃',
                                              //   style: TextStyle(fontSize: 20),
                                              // ),
                                            ),

                                            // Padding(
                                            //   padding: EdgeInsets.symmetric(
                                            //       horizontal: 10.0),
                                            //   child: Container(
                                            //     height: 1.0,
                                            //     width: MediaQuery.of(context)
                                            //         .size
                                            //         .width,
                                            //     color: Colors.black,
                                            //   ),
                                            // ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Wrap(
                                              children: [
                                                Card(
                                                  child: ListTile(
                                                    leading:
                                                        Icon(Icons.feedback),
                                                    title: Text("Feedback"),
                                                    onTap: () {
                                                      showbottomsheet(
                                                          'Thankyour for sharing valuable feedback 😍',
                                                          'FEEDBACK');
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),
                                                Card(
                                                  child: ListTile(
                                                      leading:
                                                          Icon(Icons.report),
                                                      title: Text(
                                                          "Report an issue"),
                                                      onTap: (() {
                                                        showbottomsheet(
                                                            'We are Sorry to here that 😕',
                                                            'BUG');
                                                      })),
                                                ),
                                              ],
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
                    },
                    leading: Icon(
                      Icons.feedback,
                      size: 20.h,
                    ),
                    title: Text(
                      "Feedback/Report a problem",
                      textScaleFactor: 1.h,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 11.sp),
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, "Leaveapprovalpage");
                  //   },
                  //   leading: Icon(
                  //     CupertinoIcons.phone_arrow_up_right,
                  //     size: 30.h,
                  //   ),
                  //   title: Text(
                  //     "Emergency Contact No.",
                  //     textScaleFactor: 1.h,
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w300, fontSize: 14..sp),
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      // logout();
                      LogoutConfirmation();
                    },
                    leading: Icon(
                      Icons.exit_to_app,
                      size: 20.h,
                    ),
                    title: Text(
                      "Logout",
                      textScaleFactor: 1.h,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ),
      body: SafeArea(
        child: UpgradeAlert(
          upgrader: Upgrader(
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material,
              shouldPopScope: () => true,
              canDismissDialog: true,
              durationUntilAlertAgain: const Duration(days: 1)),
          child: RefreshIndicator(
            color: Global_User_theme,
            onRefresh: () => checkEmployeeLevel(),
            child: Stack(
              children: <Widget>[dashBg, content],
            ),
          ),
        ),
      ),
    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(color: Global_User_theme),
            flex: 2,
          ),
          Expanded(
            child: Container(color: Colors.grey.shade200),
            flex: 5,
          ),
        ],
      );

  get content =>
      //  _sendreportLoading
      //     ? Center(
      //         child: CircularProgressIndicator(color: Global_User_theme),
      //       )
      //     :
      _sendreportLoading
          ? Center(
              child: CustomLoader(
                dotColor: Global_User_theme,
              ),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  header,
                  // SizedBox(
                  //   height: 15.h,
                  // ),
                  _MobileAttendancerights ? grid : gridwithoutattendancerights
                ],
              ),
            );

  get header => circular
      ? Center(
          child: CustomLoader(
            dotColor: Global_User_theme,
          ),
        )
      :
      //  Center(
      //     child: CircularProgressIndicator(color: Colors.white),
      //   )
      // :
      ListTile(
          trailing: Container(
              margin: EdgeInsets.only(bottom: 10.h), child: circularBird()),
          leading: CircleAvatar(
            backgroundColor: Global_User_theme,
            backgroundImage: MemoryImage(base64Decode(profileModel.cpf_image)),
          ),
          contentPadding:
              EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 10),
          title: Text(
            greeting(),
            style: TextStyle(
                fontSize: 20.sm,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            profileModel.emp_name,
            style: TextStyle(
              fontSize: 18.sm,
              color: Colors.white,
            ),
          ),
          // trailing: CircleAvatar(
          //   backgroundImage: MemoryImage(base64Decode(profileModel.cpf_image)),
          // ),
          onTap: () {
            _key.currentState?.openDrawer(); // <-- Opens drawer.
          });

  get grid => Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: _isLoading
              ? Center(
                  child: CustomLoader(
                    dotColor: Global_User_theme,
                  ),
                )
              :
              // ?
              //  Center(
              //     child: CircularProgressIndicator(color: Global_User_theme),
              //   )
              // :
              GridView.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                  childAspectRatio: .90,
                  children: [
                      getgridchild(
                          "View Profile",
                          Icon(
                            Icons.calendar_today_sharp,
                            size: 45.sm,
                            color: Global_User_theme,
                          ),
                          "viewprofile"),

                      getgridchild(
                          "Mark Attendance",
                          Icon(
                            Icons.person,
                            size: 45.sm,
                            color: Global_User_theme,
                          ),
                          "markattendance"),
                      getgridchild(
                          "Leave Request",
                          Icon(
                            Icons.work_off_outlined,
                            size: 45.sm,
                            color: Global_User_theme,
                          ),
                          "showcasewidgetLeave"),
                      getgridchild(
                          "Hours reconciliation",
                          Icon(
                            Icons.timer,
                            size: 45.sm,
                            color: Global_User_theme,
                          ),
                          "showcasewidgetAdjustment"),
                      Visibility(
                        visible: _isManager,
                        child: getgridchild(
                            "Approval",
                            Icon(
                              Icons.check_circle_sharp,
                              size: 45.sm,
                              color: Global_User_theme,
                            ),
                            "Leaveapprovalpage"),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushNamed(context, "viewprofile");
                      //   },
                      //   child: Card(
                      //     elevation: 2,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8)),
                      //     child: Center(
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: <Widget>[
                      //           Icon(
                      //             Icons.person,
                      //             size: 45.sm,
                      //             color: Global_User_theme,
                      //           ),
                      //           SizedBox(
                      //             height: 10.h,
                      //           ),
                      //           Text(
                      //             "View Profile",
                      //             style: TextStyle(
                      //                 fontSize: 15.sm,
                      //                 color: Global_User_theme,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Visibility(
                      //   visible: _MobileAttendancerights,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       permissionServiceCall();
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //       builder: (context) => AttandencePageUisngMl(
                      //       //             image: null,
                      //       //             isPunchInOrOut: null,
                      //       //           )),
                      //       // );
                      //       // print("attendance");
                      //     },
                      //     child: Card(
                      //       elevation: 2,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(8)),
                      //       child: Center(
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: <Widget>[
                      //             Icon(
                      //               Icons.calendar_today_sharp,
                      //               size: 45.sm,
                      //               color: Global_User_theme,
                      //             ),
                      //             SizedBox(
                      //               height: 10.h,
                      //             ),
                      //             Text('Mark Attendance',
                      //                 style: TextStyle(
                      //                     fontSize: 15.sm,
                      //                     color: Global_User_theme,
                      //                     fontWeight: FontWeight.bold))
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushNamed(context, "showcasewidgetLeave");
                      //   },
                      //   child: Card(
                      //     elevation: 2,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8)),
                      //     child: Center(
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: <Widget>[
                      //           Icon(
                      //             Icons.work_off_outlined,
                      //             size: 45.sm,
                      //             color: Global_User_theme,
                      //           ),
                      //           SizedBox(
                      //             height: 10,
                      //           ),
                      //           Text(
                      //             "Leave Request",
                      //             style: TextStyle(
                      //                 fontSize: 15.sm,
                      //                 color: Global_User_theme,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // GestureDetector(
                      //   onTap: () => Navigator.pushNamed(
                      //       context, "showcasewidgetAdjustment"),
                      //   child: Card(
                      //     elevation: 2,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8)),
                      //     child: Center(
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: <Widget>[
                      //           Icon(
                      //             Icons.timer,
                      //             size: 45.sm,
                      //             color: Global_User_theme,
                      //           ),
                      //           SizedBox(
                      //             height: 10.h,
                      //           ),
                      //           FittedBox(
                      //             child: Text(
                      //               "Hours reconciliation",
                      //               style: TextStyle(
                      //                   fontSize: 15.sm,
                      //                   color: Global_User_theme,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // Visibility(
                      //   visible: _isManager,
                      //   child: badges.Badge(
                      //     padding: EdgeInsets.all(6),
                      //     badgeColor: Global_User_theme,
                      //     badgeContent: Text(
                      //       '$NotificationCount',
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     child: GestureDetector(
                      //       onTap: () => Navigator.pushNamed(
                      //           context, "Leaveapprovalpage"),
                      //       child: Card(
                      //         elevation: 2,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8)),
                      //         child: Center(
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: <Widget>[
                      //               Icon(
                      //                 Icons.check_circle_sharp,
                      //                 size: 45.sm,
                      //                 color: Global_User_theme,
                      //               ),
                      //               SizedBox(
                      //                 height: 10.h,
                      //               ),
                      //               Text('Approval',
                      //                   style: TextStyle(
                      //                       fontSize: 15.sm,
                      //                       color: Global_User_theme,
                      //                       fontWeight: FontWeight.bold))
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ]),
        ),
      );

  Widget getgridchild(String name, Icon icon, String onclick) {
    return GestureDetector(
      onTap: () {
        onclick == "markattendance"
            ? permissionServiceCall()
            : Navigator.pushNamed(context, onclick);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon,
              SizedBox(
                height: 10.h,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 15.sm,
                    color: Global_User_theme,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  get gridwithoutattendancerights => Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: _isLoading
              ? Center(
                  child: CustomLoader(
                    dotColor: Global_User_theme,
                  ),
                )
              : GridView.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                  childAspectRatio: .90,
                  children: [
                      getgridchild(
                          "View Profile",
                          Icon(
                            Icons.calendar_today_sharp,
                            size: 45.sm,
                            color: Global_User_theme,
                          ),
                          "viewprofile"),
                      getgridchild(
                          "Leave Request",
                          Icon(
                            Icons.work_off_outlined,
                            size: 45.sm,
                            color: Global_User_theme,
                          ),
                          "showcasewidgetLeave"),
                      getgridchild(
                          "Hours reconciliation",
                          Icon(
                            Icons.timer,
                            size: 45.sm,
                            color: Global_User_theme,
                          ),
                          "showcasewidgetAdjustment"),
                      Visibility(
                        visible: _isManager,
                        child: getgridchild(
                            "Approval",
                            Icon(
                              Icons.check_circle_sharp,
                              size: 45.sm,
                              color: Global_User_theme,
                            ),
                            "Leaveapprovalpage"),
                      )
                    ]),
        ),
      );

  Future showbottomsheet(String Message, String TYPE) {
    // for user feedback and report a bug
    return showModalBottomSheet(
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
                height: MediaQuery.of(context).size.height / 3.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: [
                          // Container(
                          //   child: Text(
                          //     'Hello,  ' + emp_name + '😃',
                          //     style: TextStyle(fontSize: 20),
                          //   ),
                          // ),
                          // SizedBox(height: 10),
                          Container(
                            child: Text(
                              Message,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(height: 20),
                          // AppTextField(
                          //   controller: _feedbackController,
                          //   labelText: TYPE == "BUG"
                          //       ? "What was the bug?"
                          //       : "Your feedback...",
                          // ),
                          // SizedBox(height: 20),
                          Form(
                            key: _formkey,
                            child: TextFormField(
                              maxLength: 500,
                              validator: (value) {
                                if (value!.length < 1) {
                                  return "Field Can't Be Empty ";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: TYPE == "BUG"
                                    ? "Describe the issue..."
                                    : "Write your feedback...",
                                labelText: TYPE == "BUG"
                                    ? "What was the bug?"
                                    : "Your feedback...",
                                labelStyle: TextStyle(
                                    fontSize: 15.sp, color: Colors.black),
                                hintStyle: TextStyle(color: Colors.grey),
                                //border: InputBorder.none,
                              ),
                              controller: _feedbackController,
                            ),
                          ),
                          SizedBox(height: 20),
                          AppButton(
                            color: Global_User_theme,
                            text: 'Send',
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                SendUserReport(TYPE);
                              }
                            },
                            // icon: Icon(
                            //   Icons.check,
                            //   color: Colors.white,
                            // ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future SendUserReport(String TYPE) async {
    try {
      Navigator.pop(context);
      Navigator.pop(context);
      setState(() {
        _sendreportLoading = true;
      });

      final operating_system = Platform.operatingSystem;
      Map data = {};
      String _apiendpoint =
          "$ServerUrl/api/MobileAPI/UserFeedback?CPF_NO=$globalInt&Feedback=${_feedbackController.text}&Mobile_os=$operating_system&TYPE=$TYPE";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "Leaveapprovalpage", true);

      if (response!.statusCode == 200) {
        var returndata = json.decode(response.body);
        var Message = returndata['Table'][0]['RETMESSAGE'];

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green,
              content: Text(
                "Done ✓, $Message",
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.grey,
              content: Text(
                'Someting went wrong ! !',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.grey,
            content: Text(
              'Someting went wrong ! !',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    } finally {
      setState(() {
        _sendreportLoading = false;
      });
    }
  }
}
