// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';

// class localAuthencation {
//   static late bool _hasBioSensor;
//   static LocalAuthentication authentication = LocalAuthentication();
//   static Future<bool> _checkBiometricAvailability() async {
//     try {
//       _hasBioSensor = await authentication.canCheckBiometrics;
//       return _hasBioSensor;
//     } on PlatformException catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   static Future<bool> _authenticateUser() async {
//     bool isAuthencated = false;
//     final isAvailable = await _checkBiometricAvailability();
//     if (!isAvailable) return false;
//     try {
//       isAuthencated = await authentication.authenticate(
//           localizedReason: "Please Authenticate to use the app",
//           options: AuthenticationOptions(
//               useErrorDialogs: true, stickyAuth: true, biometricOnly: true));
//       //print(isAuthencated);
//       return isAuthencated;
//     } on PlatformException catch (e) {
//       print(e);
//       return false;
//     }
//   }
// }

