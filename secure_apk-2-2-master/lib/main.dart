import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:secure_apk/attendanceinformation_details.dart';
import 'package:secure_apk/hours_reconciliation.dart';
import 'package:secure_apk/leave_history.dart';
import 'package:secure_apk/leave_request.dart';
import 'package:secure_apk/pending_leaves.dart';
import 'package:secure_apk/reconciliation_history.dart';
import 'package:secure_apk/reconciliation_pending.dart';
import 'package:secure_apk/view_profile.dart';
import 'package:secure_apk/welcome_page.dart';
import 'NotificitationServices/local_notification_service.dart';
import 'globals.dart' as globals;
import './home_page.dart';
import 'leave_balance.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_encryption.dart';
import 'new_Approval_page.dart';
import 'new_approval_page_TAB2.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

// @dart=2.9
Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // final IOSInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings(
  //   requestSoundPermission: false,
  //   requestBadgePermission: false,
  //   requestAlertPermission: false,
  // );

  LocalNotificationService.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static late bool _hasBioSensor;
  static LocalAuthentication authentication = LocalAuthentication();
  static Future<bool> _checkBiometricAvailability() async {
    try {
      _hasBioSensor = await authentication.canCheckBiometrics;
      return _hasBioSensor;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> _authenticateUser() async {
    bool isAuthencated = false;
    final isAvailable = await _checkBiometricAvailability();
    if (!isAvailable) return false;
    try {
      isAuthencated = await authentication.authenticate(
          localizedReason: "Please Authenticate to use the app",
          options: AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: false, biometricOnly: false));
      //print(isAuthencated);
      return isAuthencated;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  //!<-------------function for auto login without id and password----------->
  Future<bool> tryAutoLogin() async {
    var any = await SharedPreferences.getInstance();
    if (!any.containsKey("userData")) {
      // return to login page in this caSE
      return false;
    } else {
      // RETURN TO HOME PAGE

      // await _authenticateUser();
      final shareduser = await SharedPreferences.getInstance();
      globals.globalInt =
          //"2033";
          MyEncryption.CryptoGraphy(
              "Decryption", shareduser.get("shareduser").toString());
      globals.ouId = MyEncryption.CryptoGraphy(
          "Decryption", shareduser.get("ou_id").toString());
      globals.dateOfJoining = MyEncryption.CryptoGraphy(
          "Decryption", shareduser.get("date_of_joining").toString());
      globals.location_id = MyEncryption.CryptoGraphy(
          "Decryption", shareduser.get("location_id").toString());
      globals.emp_name = MyEncryption.CryptoGraphy(
          "Decryption", shareduser.get("emp_name").toString());
      globals.JWT_Tokken = MyEncryption.CryptoGraphy(
          "Decryption", shareduser.get("userData").toString());

      return true;
    }
  }

  final introShown = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    introShown.writeIfNull("displayed", false);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      builder: (context, child) {
        return // adedd after update before chil:

            OverlaySupport.global(
          child: GetMaterialApp(
            home: FutureBuilder(
              future: tryAutoLogin(),
              builder: (context, authResult) {
                if (authResult.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  );
                } else if (authResult.data == true) {
                  return AnimatedSplashScreen.withScreenFunction(
                    duration: 300,
                    splash: 'images/bird.png',
                    screenFunction: () async {
                      var isauth = await _authenticateUser();
                      if (isauth) {
                        return HomePage();
                      } else {
                        exit(0);
                      }
                    },
                    splashTransition: SplashTransition.rotationTransition,
                    // pageTransitionType: pagetransition,
                  );
                  // AnimatedSplashScreen(
                  //     function: authenticateUser,
                  //     splash: Image.asset("images/bird.png"),
                  //     splashTransition: SplashTransition.scaleTransition,
                  //     duration: 300,
                  //     nextScreen: HomePage());
                }
                // if (_isAuthencated == false) {
                //   exit(0);
                // }

                return AnimatedSplashScreen(
                    splash: Image.asset("images/bird.png"),
                    duration: 300,
                    splashTransition: SplashTransition.scaleTransition,
                    nextScreen: introShown.read("displayed")
                        ? Login_page()
                        : WelcomeScreen());
              },
            ),
            theme: ThemeData(fontFamily: 'Kohinoor'),
            debugShowCheckedModeBanner: false,
            routes: {
              //"/": (context) => Login_page(),
              "loginpage": (context) => Login_page(),
              "showcasewidgetLeave": (context) => showcasewidgetLeave(
                  TYPE_OF_LEAVE: "",
                  From_timeFor_edit: "",
                  To_timeFor_edit: "",
                  APPROVED: "",
                  FROM_1HALF_FLAGforedit: "",
                  FROM_2HALF_FLAGforedit: "",
                  SerialNo: 0,
                  To_1HALF_FLAGforedit: "",
                  To_2HALF_FLAGforedit: "",
                  edit: 0,
                  fromdateforedit: "",
                  leaveTypeforedit: 0,
                  reasonforedit: "",
                  todateforedit: "",
                  totaldaysforedit: 0),
              "showcasewidgetAdjustment": (context) => showcasewidgetAdjustment(
                  adjusttmentforedit: 0,
                  dateforedit: "",
                  fromhourforedit: "",
                  reasonforedit: "",
                  tohourforedit: "",
                  APPROVED: "",
                  totalhourforedit: "",
                  edit: 0,
                  SerialNo: 0),
              "homepage": (context) => HomePage(),
              "Loginpage": (context) => Login_page(),
              "viewprofile": (context) => ViewProfile(),
              //  "Homepage": (context) => HomePage2(),
              //"attendancePage": (context) => AttandencePage(),
              "leaveRequest": (context) => LeaveRequest(
                  TYPE_OF_LEAVE: "",
                  From_timeFor_edit: "",
                  To_timeFor_edit: "",
                  APPROVED: "",
                  FROM_1HALF_FLAGforedit: "",
                  FROM_2HALF_FLAGforedit: "",
                  SerialNo: 0,
                  To_1HALF_FLAGforedit: "",
                  To_2HALF_FLAGforedit: "",
                  edit: 0,
                  fromdateforedit: "",
                  leaveTypeforedit: 0,
                  reasonforedit: "",
                  todateforedit: "",
                  totaldaysforedit: 0),
              "hoursReconciliation": (context) => Hours_Reconciliation(
                  adjusttmentforedit: 0,
                  dateforedit: "",
                  fromhourforedit: "",
                  reasonforedit: "",
                  tohourforedit: "",
                  APPROVED: "",
                  totalhourforedit: "",
                  edit: 0,
                  SerialNo: 0),
              // "approvalpage": (context) => Approval_Page(),
              "AttendanceInformationDetails": (context) =>
                  AttendanceInformationDetails(),
              "Pending_leaves": (context) => PendingLeaves(),
              "Leave_history": (context) => LeaveHistory(),
              "Leave_Balance": (context) => LeaveBalance(),
              "hoursReconciliationPending": (context) =>
                  ReconciliationPending(),
              "hoursReconciliationHistory": (context) =>
                  ReconciliationHistory(),
              // "Tab2ForApproval": (context) => Tab2(),
              //  "DataGridSample": (context) => DataGridSample(),
              "Adjustmentapprovalpage": (context) => NewApproval_TAB2(),
              "Leaveapprovalpage": (context) => New_Approval_Page(0)
            },
          ),
        );
      },
      designSize: const Size(360, 640),
    );
  }
}
