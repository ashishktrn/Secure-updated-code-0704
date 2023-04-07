// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:geolocator/geolocator.dart' as geolocator;
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart' as geo;
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:http/http.dart' as http;
// import 'package:secure_apk/globals.dart';
// import 'package:async/async.dart';
// import 'package:secure_apk/models/attenanceResponse_Model.dart';
// import 'package:secure_apk/models/preferences_services.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'reuseablewidgets.dart/colors.dart';
// // ignore: import_of_legacy_library_into_null_safe
// //import 'package:sweetalert/sweetalert.dart';

// class AttandencePage extends StatefulWidget {
//   const AttandencePage({Key? key}) : super(key: key);

//   @override
//   State<AttandencePage> createState() => _AttandencePageState();
// }

// class _AttandencePageState extends State<AttandencePage> {
//   File? imageOut;
//   File? imageIn;
//   late XFile _image;
//   late XFile _imageOut;
//   bool isApiCallProcess = false;
//   bool isApiCallProcess2 = false;
//   late AttendanceResponse attendanceResponse;
//   final _preferencesService = PreferencesService();
//   bool attendanceSuccess = true;
//   bool attendanceSuccess2 = true;

//   late geolocator.Position currentposition;
//   late geolocator.Position currentpositionOut;
//   var locationMessage = "";
//   String address = "";
//   String adressPunchOut = "";
//   bool circular = false;
//   bool circular2 = false;
//   var dt;
//   var now;
//   late String currentTime;
//   late String currentDate;
//   var flag = ['I', 'O'];
//   late int MAF = 1;
//   late String img64;
//   late String img64_2;
//   bool isButtonActive = false;
//   bool isButtonActive2 = false;

//   void _populateFields() async {
//     final Settings = await _preferencesService.getSettings();
//     setState(() {
//       attendanceSuccess = Settings.attendanceSuccess;
//       attendanceSuccess2 = Settings.attendanceSuccess2;
//     });
//   }

//   String currentDateFunction() {
//     //function for getting the current date
//     now = new DateTime.now();
//     var formatter = new DateFormat('yyyy-MM-dd');
//     currentDate = formatter.format(now);
//     print(currentDate);
//     return currentDate;
//   }

//   String currentTimeFunction() {
//     //function for getting the current time
//     dt = DateTime.now();
//     final hours = dt.hour.toString().padLeft(2, '0');
//     final minutes = dt.minute.toString().padLeft(2, '0');
//     currentTime = '$hours:$minutes';
//     // print(timee);
//     return currentTime;
//   }

// //!-----------puch in location---------------------------------->

//   void getCurrentLocation() async {
//     var cameraStatus = await Permission.location.status;
//     if (!cameraStatus.isGranted) await Permission.location.request();
//     var position = await geolocator.Geolocator.getCurrentPosition(
//         desiredAccuracy: geolocator.LocationAccuracy.high);
//     var lastPosition = await geolocator.Geolocator.getLastKnownPosition();
//     print(lastPosition);
//     var lat = position.latitude;
//     var long = position.longitude;
//     print("$lat , $long");

//     setState(() {
//       currentposition = position;
//       locationMessage = "Latitude :$lat , Longitude : $long ";

//       getadress();
//     });
//   }

//   getadress() async {
//     List<geo.Placemark> placemark = await geo.placemarkFromCoordinates(
//         currentposition.latitude, currentposition.longitude);

//     geo.Placemark place = placemark[0];

//     setState(() {
//       circular = false;
//       address = '${place.locality}, ${place.country}, ${place.postalCode}';
//       //isButtonActive = true;
//     });
//     print(address);
//     print(e);
//   }

// //-----------puch in location---------------------------------->

// //!-----------puch out location---------------------------------->
//   void getCurrentLocationPunchOut() async {
//     var cameraStatus = await Permission.location.status;
//     if (!cameraStatus.isGranted) await Permission.location.request();
//     var position = await geolocator.Geolocator.getCurrentPosition(
//         desiredAccuracy: geolocator.LocationAccuracy.high);
//     var lastPosition = await geolocator.Geolocator.getLastKnownPosition();
//     print(lastPosition);
//     var lat = position.latitude;
//     var long = position.longitude;
//     print("$lat , $long");

//     setState(() {
//       currentpositionOut = position;
//       locationMessage = "Latitude :$lat , Longitude : $long ";
//       getadressPuchOut();
//     });
//   }

//   getadressPuchOut() async {
//     List<geo.Placemark> placemark = await geo.placemarkFromCoordinates(
//         currentpositionOut.latitude, currentpositionOut.longitude);

//     geo.Placemark place = placemark[0];

//     setState(() {
//       circular2 = false;
//       adressPunchOut =
//           '${place.locality}, ${place.country}, ${place.postalCode}';
//       // isButtonActive2 = true;
//     });
//     print("adress" + adressPunchOut);
//     print(e);
//   }

// //-----------puch out location---------------------------------->

//   permission() async {
//     var locationstatus = await Permission.location.status;
//     var camerastatus = await Permission.camera.status;

//     if (!locationstatus.isGranted) await Permission.location.request();
//     if (!locationstatus.isGranted) await Permission.location.request();

//     if (!camerastatus.isGranted) await Permission.camera.request();

//     if (locationstatus.isDenied) {
//       await Permission.location.request();
//     }
//   }

//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error("Location services are disabled.");
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           "Location permissions are permantly denied. we cannot request permissions.");
//     }

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         return Future.error(
//             "Location permissions are denied (actual value: $permission).");
//       }
//     }
//     // var position =
//     //     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     // var lat = position;

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     permission();
//     _populateFields();
//     _determinePosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // extendBodyBehindAppBar: true,
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       backgroundColor: Colors.grey.shade50,
//       floatingActionButton: SpeedDial(
//         foregroundColor: securePurpleColor,
//         // animatedIcon: AnimatedIcons.view_list,
//         icon: (Icons.info_outline),
//         backgroundColor: Colors.grey.shade200,
//         overlayColor: Colors.black,
//         // overlayOpacity: 0.4,
//         buttonSize: Size(40.0, 45.0),
//         // spaceBetweenChildren: 10,
//         onPress: () {
//           Navigator.pushNamed(context, "AttendanceInformationDetails");
//         },
//       ),
//       appBar: AppBar(
//         elevation: 1,
//         shadowColor: Colors.white,
//         backgroundColor: securePurpleColor,
//         actions: [circularBird()],
//       ),
//       body: Column(
//         children: <Widget>[
//           punchIn(),
//           Expanded(
//             child: Divider(
//               height: 0.3,
//             ),
//           ),
//           punchOut(),
//         ],
//       ),
//     );
//   }

//   Widget punchIn() {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

// // Height (without SafeArea)
//     var padding = MediaQuery.of(context).viewPadding;
//     double height1 = height - padding.top - padding.bottom;

// // Height (without status bar)
//     double height2 = height - padding.top;

// // Height (without status and toolbar)
//     double height3 = height - padding.top - kToolbarHeight;
//     return SingleChildScrollView(
//       child: Container(
//         height: height3 / 2,
//         width: MediaQuery.of(context).size.width,
//         // color: Color.fromRGBO(123, 34, 83, 1),
//         child: Column(
//           children: [
//             // Padding(
//             //  Expanded(child: Divider()),
//             SizedBox(
//               height: 10.h,
//             ),
//             //   padding: const EdgeInsets.only(left: 350),
//             //   child: Container(
//             //       //height: 25,
//             //       // child: IconButton(
//             //       //     color: Color.fromRGBO(123, 34, 83, 1),
//             //       //     onPressed: () {
//             //       //       Navigator.pushNamed(
//             //       //           context, "AttendanceInformationDetails");
//             //       //     },
//             //       //     icon: Icon(Icons.info_outline)),
//             //       ),
//             // ),

//             InkWell(
//               onTap: attendanceSuccess2
//                   ? () {
//                       circular = true;
//                       getCurrentLocation();
//                       getImage();

//                       // pickImagein(ImageSource.camera);
//                       // imagelast();
//                       // getProfileImage();
//                     }
//                   : () {
//                       // SweetAlert.show(context,
//                       //     title: "Please punch out first",
//                       //     subtitle: "",
//                       //     style: SweetAlertStyle.error);
//                       AwesomeDialog(
//                         context: context,
//                         dialogType: DialogType.INFO,
//                         animType: AnimType.BOTTOMSLIDE,
//                         title: 'Error',
//                         desc: "Please punch out first",
//                         btnCancelOnPress: () {},
//                         btnOkOnPress: () {},
//                       )..show();
//                     },
//               child: ClipOval(
//                 child: imageIn != null
//                     ? Image.file(
//                         imageIn!,
//                         width: 130.w,
//                         height: 130.h,
//                         fit: BoxFit.cover,
//                       )
//                     : Image.asset(
//                         "images/lens.png",
//                         fit: BoxFit.cover,
//                         width: 130.w,
//                         height: 130.h,
//                       ),
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Text(
//               " $address",
//             ),
//             SizedBox(
//               height: 10.h,
//             ),

//             //!<-----------------Main Punch IN button------------------------------------------>
//             isApiCallProcess
//                 ? CircularProgressIndicator(
//                     color: securePurpleColor,
//                     strokeWidth: 2,
//                     backgroundColor: Colors.green.shade50,
//                   )
//                 : InkWell(
//                     onTap: isButtonActive
//                         ? () {
//                             currentDateFunction();
//                             currentTimeFunction();
//                             sendImageToServer();
//                           }
//                         : null,
//                     // () {
//                     // print("hello");
//                     // circular = true;
//                     // getCurrentLocation();
//                     // pickImagein(ImageSource.camera);
//                     // currentDateFunction();
//                     // currentTimeFunction();

//                     // print(img64);
//                     // print(currentDate);
//                     // print(currentTime);
//                     // },
//                     //!<------------------Main Punch IN button------------------------------------------>
//                     child: isButtonActive
//                         ? Container(
//                             height: 50.h,
//                             width: MediaQuery.of(context).size.width / 2.6,

//                             //  margin: EdgeInsets.symmetric(horizontal: 130),

//                             decoration: BoxDecoration(
//                               color: securePurpleColor,
//                               borderRadius: BorderRadius.circular(10),
//                             ),

//                             // color: Color.fromRGBO(123, 34, 83, 1),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 4.w, vertical: 4.h),
//                               child: Center(
//                                 child: circular
//                                     ? CircularProgressIndicator(
//                                         color: Colors.white)
//                                     : AutoSizeText(
//                                         "Punch In",
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18.sp,
//                                             color: Colors.white),
//                                       ),
//                               ),
//                             ),
//                           )
//                         : attendanceSuccess2
//                             ? Container(
//                                 height: 50.h,
//                                 width: MediaQuery.of(context).size.width / 2.6,

//                                 decoration: BoxDecoration(
//                                   color: Color.fromRGBO(123, 34, 83, 0.3),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),

//                                 // color: Color.fromRGBO(123, 34, 83, 1),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 4.w, vertical: 4.h),
//                                   child: Center(
//                                     child: circular
//                                         ? CircularProgressIndicator(
//                                             color: Colors.white)
//                                         : AutoSizeText(
//                                             "Punch In",
//                                             maxLines: 1,
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18.sp,
//                                                 color: Colors.white),
//                                           ),
//                                   ),
//                                 ),
//                               )
//                             : Container(
//                                 height: 50.h,
//                                 width: MediaQuery.of(context).size.width / 5,

//                                 decoration: BoxDecoration(
//                                   color: Colors.green.shade200,
//                                   borderRadius: BorderRadius.circular(50.r),
//                                 ),

//                                 // color: Color.fromRGBO(123, 34, 83, 1),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 4.w, vertical: 4.h),
//                                   child: Center(
//                                       child: Icon(
//                                     Icons.check,
//                                     color: Color.fromARGB(255, 239, 241, 239),
//                                     size: 50.sm,
//                                   )),
//                                 ),
//                               ),
//                   )

//             //Image.asset("images/attandence.png"),
//           ],
//         ),
//       ),
//     );
//   }

//   // Future<bool> isLocationAvailable() async {
//   //   // get current permission status of location
//   //   var permissionStatus = await Permission.locationWhenInUse.status;

//   //   // if restricted, it can't be used
//   //   if (permissionStatus == PermissionStatus.restricted) {
//   //     return Future.value(false);
//   //   }

//   //   // it can be switched off, so it can't be used
//   //   if (!await Permission.locationWhenInUse.serviceStatus.isEnabled) {
//   //     return Future.value(false);
//   //   }

//   //   // if user permanently denied access, it can't be used
//   //   if (permissionStatus == PermissionStatus.permanentlyDenied) {
//   //     return Future.value(false);
//   //   }

//   //   // get permission and return result
//   //   return await Permission.locationWhenInUse.request().isGranted;
//   // }

//   Widget punchOut() {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

// // Height (without SafeArea)
//     var padding = MediaQuery.of(context).viewPadding;
//     double height1 = height - padding.top - padding.bottom;

// // Height (without status bar)
//     double height2 = height - padding.top;

// // Height (without status and toolbar)
//     double height3 = height - padding.top - kToolbarHeight;
//     return SingleChildScrollView(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: height3 / 2.1,
//         //color: Colors.black,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10.h,
//             ),
//             // Expanded(child: Divider()),
//             //color: Colors.grey.shade100,

//             InkWell(
//               onTap: attendanceSuccess
//                   ? () {
//                       circular2 = true;
//                       getCurrentLocationPunchOut();
//                       getImageOut();
//                       //pickImageout(ImageSource.camera);
//                     }
//                   : () {
//                       // SweetAlert.show(context,
//                       //     title: "Please punch in first",
//                       //     subtitle: "",
//                       //     style: SweetAlertStyle.error);
//                       AwesomeDialog(
//                         context: context,
//                         dialogType: DialogType.INFO,
//                         animType: AnimType.BOTTOMSLIDE,
//                         title: 'Error',
//                         desc: "Please punch in first",
//                         btnCancelOnPress: () {},
//                         btnOkOnPress: () {},
//                       )..show();
//                     },
//               child: ClipOval(
//                 child: imageOut != null
//                     ? Image.file(
//                         imageOut!,
//                         width: 130.w,
//                         height: 130.h,
//                         fit: BoxFit.cover,
//                       )
//                     : Image.asset(
//                         "images/lens.png",
//                         fit: BoxFit.cover,
//                         width: 130.w,
//                         height: 130.h,
//                       ),
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Text(
//               " $adressPunchOut",
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             isApiCallProcess2
//                 ? CircularProgressIndicator(
//                     color: securePurpleColor,
//                     strokeWidth: 2,
//                     backgroundColor: Colors.green.shade50,
//                   )
//                 :
//                 //!------------------------Buttton For Punch Out--------------------------------->
//                 InkWell(
//                     onTap: isButtonActive2
//                         ? () {
//                             currentDateFunction();
//                             currentTimeFunction();
//                             sendImageToServer2();
//                           }
//                         : null,
//                     // () {
//                     //   print("o");
//                     //   circular2 = true;
//                     //   getCurrentLocationPunchOut();
//                     //   pickImageout(ImageSource.camera);
//                     //   currentDateFunction();
//                     //   currentTimeFunction();
//                     //   print(img64_2);

//                     //   print(currentDate);
//                     //   print(currentTime);
//                     // },
//                     //!------------------------Buttton For Punch Out--------------------------------->
//                     child: isButtonActive2
//                         ? Container(
//                             width: MediaQuery.of(context).size.width / 2.6,
//                             height: 50,
//                             //margin: EdgeInsets.symmetric(horizontal: 130),
//                             decoration: BoxDecoration(
//                               color: securePurpleColor,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Container(
//                               // margin: EdgeInsets.all(1),

//                               padding: const EdgeInsets.all(0.0),
//                               child: Center(
//                                 child: circular2
//                                     ? CircularProgressIndicator(
//                                         color: Colors.white)
//                                     : Text(
//                                         "Punch Out",
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         softWrap: false,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18.sm,
//                                             color: Colors.white),
//                                       ),
//                               ),
//                             ),
//                           )
//                         : attendanceSuccess
//                             ? Container(
//                                 width: MediaQuery.of(context).size.width / 2.6,
//                                 height: 50.h,
//                                 //margin: EdgeInsets.symmetric(horizontal: 130),
//                                 decoration: BoxDecoration(
//                                   color: Color.fromRGBO(123, 34, 83, 0.3),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Container(
//                                   // margin: EdgeInsets.all(1),

//                                   padding: const EdgeInsets.all(0.0),
//                                   child: Center(
//                                     child: circular2
//                                         ? CircularProgressIndicator(
//                                             color: Colors.white)
//                                         : Text(
//                                             "Punch Out",
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             softWrap: false,
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18.sm,
//                                                 color: Colors.white),
//                                           ),
//                                   ),
//                                 ),
//                               )
//                             : Container(
//                                 height: 50.h,
//                                 width: MediaQuery.of(context).size.width / 5,

//                                 decoration: BoxDecoration(
//                                   color: Colors.green.shade200,
//                                   borderRadius: BorderRadius.circular(50.r),
//                                 ),

//                                 // color: Color.fromRGBO(123, 34, 83, 1),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 4.w, vertical: 4.h),
//                                   child: Center(
//                                       child: Icon(
//                                     Icons.check,
//                                     color: Color.fromARGB(255, 239, 241, 239),
//                                     size: 50.sm,
//                                   )),
//                                 ),
//                               ),
//                   ),

//             //Image.asset("images/attandence.png"),
//           ],
//         ),
//       ),
//     );
//   }

//   // pickImagein(ImageSource imageType) async {
//   //   try {
//   //     final photo = await ImagePicker().pickImage(source: imageType);
//   //     if (photo == null) return;
//   //     final tempImage = File(photo.path);
//   //     setState(() {
//   //       imageIn = tempImage;
//   //       // print("Path: ${imageIn!.path}");

//   //       final bytes = File(imageIn!.path).readAsBytesSync();
//   //       img64 = base64Encode(bytes);
//   //       // isButtonActive = true;
//   //       print("After decode: $img64");
//   //     });
//   //   } catch (error) {
//   //     debugPrint(error.toString());
//   //   }
//   // }

//   Future getImage() async {
//     await Permission.camera.request();

//     await Permission.location.request();

//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.microphone,
//       Permission.calendar,
//     ].request();

//     final ImagePicker _picker = ImagePicker();

//     var imagee = await _picker.pickImage(
//         source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

//     //  ImagePicker.pickImage(
//     //     source: ImageSource.camera,
//     //     imageQuality: 60,
//     //     preferredCameraDevice: CameraDevice.rear);
//     if (imagee == null) {
//       return;
//     }
//     final tempImage = File(imagee.path);

//     setState(() {
//       imageIn = tempImage;
//       _image = imagee;
//       isButtonActive = true;
//     });
//   }

//   Future getImageOut() async {
//     await Permission.camera.request();

//     await Permission.location.request();
//     final ImagePicker _picker = ImagePicker();
//     var imagee = await _picker.pickImage(
//         source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
//     if (imagee == null) {
//       return;
//     }
//     final tempImage = File(imagee.path);

//     setState(() {
//       imageOut = tempImage;
//       _imageOut = imagee;
//       isButtonActive2 = true;
//     });
//   }

//   void _saveSettings() {
//     final newSettings = Settings(
//         attendanceSuccess: attendanceSuccess,
//         attendanceSuccess2: attendanceSuccess2);
//     print(newSettings);
//     _preferencesService.saveSettings(newSettings);
//   }

//   // pickImageout(ImageSource imageType) async {
//   //   try {
//   //     final photo = await ImagePicker().pickImage(source: imageType);
//   //     if (photo == null) return;
//   //     final tempImage = File(photo.path);
//   //     setState(() {
//   //       imageOut = tempImage;
//   //       final bytes = File(imageOut!.path).readAsBytesSync();
//   //       img64_2 = base64Encode(bytes);
//   //       isButtonActive2 = true;
//   //     });
//   //   } catch (error) {
//   //     debugPrint(error.toString());
//   //   }
//   // }

//   // Future<StreamedResponse> patchImage() async {
//   //   var url =
//   //       "http://localhost:57891/api//MarkAttendance/MarkAttandanceUploadImage";
//   //   var request = MultipartRequest("PATCH", Uri.parse(url));
//   //   request.files.add(await MultipartFile.fromPath("img", imageIn!.path));

//   //   request.headers.addAll({
//   //     "content-type": "multipart/form-data",
//   //   });
//   //   var response = request.send();
//   //   return response;
//   // }

//   // void apiCall() async {
//   //   Map<String, dynamic> requestPayload = {
//   //     "CPF_NO": 4468,
//   //     "ENTRY_DATE": currentDate.toString(),
//   //     "ENTRY_TIME": currentTime.toString(),
//   //     "IO_CODE": flag[0].toString(),
//   //     "IMAGE": img64,
//   //     "LONGITUDE": currentposition.longitude.toString(),
//   //     "LATITUDE": currentposition.latitude.toString(),
//   //     "ADDRESS": adress.toString(),
//   //     "MAF": MAF
//   //   };

//   //   try {
//   //     Response response = await post(
//   //       Uri.parse(
//   //           "http://172.16.15.129:8026/api/MarkAttendance/MarkAttendanceSave"),
//   //       body: jsonEncode(requestPayload),

//   //       // body: {
//   //       //   "CPF_NO": 4468,
//   //       //   "ENTRY_DATE": currentDate,
//   //       //   "ENTRY_TIME": currentTime,
//   //       //   "IO_CODE": flag[0].toString(),
//   //       //   "IMAGE": img64,
//   //       //   "LONGITUDE": currentposition.longitude.toString(),
//   //       //   "LATITUDE": currentposition.latitude.toString(),
//   //       //   "ADDRESS": adress.toString(),
//   //       //   "MAF": MAF.toString()
//   //       // },

//   //       // headers: {
//   //       //   "Accept": "application/json",
//   //       //   // "content-type": "application/json"
//   //       // }
//   //     );

//   //     if (response.statusCode == 200) {
//   //       print("api hit success");
//   //       print(response.body);
//   //     } else {
//   //       print("faild");
//   //     }
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
//   final String AspEndPoint =
//       'http://172.16.15.129:8026/api/MarkAttendance/MarkAttandanceUploadImage';
//   Future sendImageToServer() async {
//     if (globalInt.isNotEmpty) {
//       setState(() {
//         isApiCallProcess = true;
//       });
//       var stream =
//           new http.ByteStream(DelegatingStream.typed(_image.openRead()));
//       print(stream);
//       final int length = await _image.length();

//       final request = new http.MultipartRequest('POST', Uri.parse(AspEndPoint))
//         ..files.add(
//             new http.MultipartFile('IMAGE', stream, length, filename: 'test'));
//       request.fields["ADDRESS_LOCATION"] = address.toString();
//       request.fields["CPF_NO"] = globalInt.toString();
//       request.fields["ENTRY_DATE"] = currentDate.toString();
//       request.fields["ENTRY_TIME"] = currentTime.toString();
//       request.fields["IO_CODE"] = flag[0].toString();
//       request.fields["LONGITUDE"] = currentposition.longitude.toString();
//       request.fields["LATITUDE"] = currentposition.latitude.toString();
//       request.fields["MAF"] = MAF.toString();
//       request.fields["location_id"] = location_id.toString();
//       request.fields["flag"] = "0";
//       request.fields["emp_name"] = emp_name.toString();

//       http.Response response =
//           await http.Response.fromStream(await request.send());
//       // print(response.body);
//       if (response.statusCode == 200) {
//         setState(() {
//           final decodedData = jsonDecode(response.body);
//           List<AttendanceResponse> list = List.from(decodedData)
//               .map<AttendanceResponse>(
//                 (item) => AttendanceResponse.fromJson(item),
//               )
//               .toList();
//           attendanceResponse = list.first;
//           print(attendanceResponse.RET_MESSAGE);
//           attendanceSuccess = true;
//           attendanceSuccess2 = false;
//           isButtonActive = false;
//           _saveSettings();
//         });
//       } else {
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.ERROR,
//           animType: AnimType.BOTTOMSLIDE,
//           title: 'Error',
//           desc: "Something Went Wrong",
//           btnCancelOnPress: () {},
//           btnOkOnPress: () {},
//         )..show();
//         setState(() {
//           isApiCallProcess = false;
//         });
//         return;
//       }

//       setState(() {
//         isApiCallProcess = false;
//       });
//       if (attendanceResponse.RET_VALUE == 1) {
//         // SweetAlert.show(context,
//         //     title: attendanceResponse.RET_MESSAGE,
//         //     subtitle: "Thank you",
//         //     style: SweetAlertStyle.success);
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.SUCCES,
//           animType: AnimType.BOTTOMSLIDE,
//           title: 'Thank you',
//           desc: attendanceResponse.RET_MESSAGE,
//           btnCancelOnPress: () {},
//           btnOkOnPress: () {},
//         )..show();
//       } else {
//         // SweetAlert.show(context,
//         //     title: "Error",
//         //     subtitle: "Something went wrong",
//         //     style: SweetAlertStyle.error);
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.ERROR,
//           animType: AnimType.BOTTOMSLIDE,
//           title: 'Error',
//           desc: "Something went wrong",
//           btnCancelOnPress: () {},
//           btnOkOnPress: () {},
//         )..show();
//       }
//     } else {
//       // SweetAlert.show(context,
//       //     title: "Error",
//       //     subtitle: "Something went wrong",
//       //     style: SweetAlertStyle.error);
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: 'Error',
//         desc: "Something Went Wrong",
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//     }
//   }

//   Future sendImageToServer2() async {
//     setState(() {
//       isApiCallProcess2 = true;
//     });
//     var stream =
//         new http.ByteStream(DelegatingStream.typed(_imageOut.openRead()));
//     final int length = await _imageOut.length();

//     final request = new http.MultipartRequest('POST', Uri.parse(AspEndPoint))
//       ..files.add(
//           new http.MultipartFile('IMAGE', stream, length, filename: 'test'));
//     request.fields["ADDRESS_LOCATION"] = adressPunchOut.toString();
//     request.fields["CPF_NO"] = globalInt.toString();
//     request.fields["ENTRY_DATE"] = currentDate.toString();
//     request.fields["ENTRY_TIME"] = currentTime.toString();
//     request.fields["IO_CODE"] = flag[1].toString();
//     request.fields["LONGITUDE"] = currentpositionOut.longitude.toString();
//     request.fields["LATITUDE"] = currentpositionOut.latitude.toString();
//     request.fields["MAF"] = MAF.toString();
//     request.fields["location_id"] = location_id.toString();
//     request.fields["flag"] = "0";
//     request.fields["emp_name"] = emp_name.toString();

//     http.Response response =
//         await http.Response.fromStream(await request.send());
//     if (response.statusCode == 200) {
//       print("api hit success");
//       print(response.body);
//     } else {
//       print("faild");
//     }
//     setState(() {
//       isApiCallProcess2 = false;
//     });
//     if (response.statusCode == 200) {
//       setState(() {
//         final decodedData = jsonDecode(response.body);
//         List<AttendanceResponse> list = List.from(decodedData)
//             .map<AttendanceResponse>(
//               (item) => AttendanceResponse.fromJson(item),
//             )
//             .toList();
//         attendanceResponse = list.first;
//         print(attendanceResponse.RET_MESSAGE);
//         attendanceSuccess = false;
//         attendanceSuccess2 = true;
//         isButtonActive2 = false;
//         _saveSettings();
//       });
//     } else {
//       print("no data");
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.ERROR,
//         animType: AnimType.BOTTOMSLIDE,
//         title: 'Error',
//         desc: "Something Went Wrong",
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//       setState(() {
//         isApiCallProcess = false;
//       });
//       return;
//     }

//     setState(() {
//       isApiCallProcess = false;
//     });
//     if (attendanceResponse.RET_VALUE == 1) {
//       // SweetAlert.show(context,
//       //     title: attendanceResponse.RET_MESSAGE,
//       //     subtitle: "Thank you",
//       //     style: SweetAlertStyle.success);
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.SUCCES,
//         animType: AnimType.BOTTOMSLIDE,
//         title: 'Thank you',
//         desc: attendanceResponse.RET_MESSAGE,
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//     } else {
//       // SweetAlert.show(context,
//       //     title: "Error",
//       //     subtitle: "Something went wrong",
//       //     style: SweetAlertStyle.success);
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.SUCCES,
//         animType: AnimType.BOTTOMSLIDE,
//         title: 'error',
//         desc: "Something went wrong",
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       )..show();
//     }
//   }
// }
