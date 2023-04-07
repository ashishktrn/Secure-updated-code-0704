import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_apk/globals.dart';
import 'package:secure_apk/header.dart';
import 'package:secure_apk/home_page.dart';
import 'package:secure_apk/reuseablewidgets.dart/Common.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

//import 'package:flutter_string_encryption/flutter_string_encryption.dart';
//import 'package:encrypt/encrypt.dart' as encrypt;
import './my_encryption.dart';

import 'package:http/http.dart';

import 'reuseablewidgets.dart/colors.dart';
import 'reuseablewidgets.dart/loder.dart';

class Login_page extends StatefulWidget {
  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  late MyHttpClient myHttpClient = new MyHttpClient(context);

  TextEditingController pass = TextEditingController();

  TextEditingController id = TextEditingController();

  bool loading = false;

  // String passdata() {
  //   return id.toString();
  // }

  void _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  void _startup() async {
    _setLoading(true);

    /// takes the front camera

    // start the services

    _setLoading(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    operating_System = Platform.operatingSystem;
    _startup();

    print(Platform.operatingSystem);
  }

  var encryptionpassword;
  var operating_System;

  var encryptionusername;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  String deviceTokenToSendPushNotification = "";

  final _formKey = GlobalKey<FormState>();

  Future<void> getDeviceTokenToSendNotification() async {
    //FUNCATION FOR GETTING THE DEVICE TOKKEN FOR THE PUSH NOTIFICATION FOR A PARTICULAR DEVICE ONLY
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    id.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.grey.shade300,
              Colors.purple.shade50,
              Colors.grey.shade50,
            ]),
          ),
          child: Column(children: <Widget>[
            SizedBox(
              height: 80.h,
            ),
            Header(),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Container(
                    // height: MediaQuery.of(context).size.height / 1,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80.r),
                        topRight: Radius.circular(80.r),
                      ),
                    ),
                    //! <-----------code for input wrapper------>
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.h),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              //! <---------------code for input field----------------------------->
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 70.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 170, 68, 68)),
                                        ),
                                      ),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.length < 1) {
                                            return 'Empty field';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Enter your Employee ID",
                                            labelText: "Employee ID",
                                            labelStyle:
                                                TextStyle(fontSize: 15.sp),
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        controller: id,
                                      ),
                                    ),
                                    Container(
                                      height: 70.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 189, 73, 73)),
                                        ),
                                      ),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.length < 1) {
                                            return "Empty Field";
                                          } else if (value.length < 2) {
                                            return "Invalid Password Length !";
                                          }
                                          return null;
                                        },
                                        obscureText: hidePassword,
                                        decoration: InputDecoration(
                                            hintText: "Enter your Password",
                                            labelText: "Password",
                                            labelStyle:
                                                TextStyle(fontSize: 15.sp),
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  hidePassword = !hidePassword;
                                                });
                                              },
                                              color: securePurpleColor
                                                  .withOpacity(0.4),
                                              icon: Icon(
                                                hidePassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                size: 25.h,
                                              ),
                                            )),
                                        controller: pass,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              // <---------------code for input field----------------------------->
                              ),
                          SizedBox(height: 20.h),
                          Text(
                            "",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          //! <-----------code for button------------------------------------------------->
                          Column(
                            children: [
                              // isApiCallProcess
                              //     ? CircularProgressIndicator(
                              //         color: securePurpleColor,   // UNCOMMENT FOR LOGIN BUTTON ANIMATION
                              //         strokeWidth: 2,
                              //         backgroundColor: Colors.green.shade50,
                              //       )
                              //     :
                              InkWell(
                                onTap: (() {
                                  // encryptionpassword =
                                  //     MyEncryption.anotherencryption(
                                  //         pass.text);
                                  // encryptionusername =
                                  //     MyEncryption.anotherencryption(
                                  //         id.text);
                                  // validate();

                                  // print(encryptiontext);
                                  //Encrypt();
                                  // Login(encryptionpassword.toString(),
                                  //     encryptionusername.toString());

                                  // postdata(pass.text, id.text);
                                }),
                                child: Container(
                                  height: 50.h,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 100.w),
                                  decoration: BoxDecoration(
                                    color: securePurpleColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: InkWell(
                                    onTap: (() {
                                      print("password==${pass.text}");
                                      encryptionpassword =
                                          MyEncryption.anotherencryption(
                                              pass.text);
                                      encryptionusername =
                                          MyEncryption.anotherencryption(
                                              id.text);
                                      validate();

                                      // print(encryptiontext);
                                      //Encrypt();
                                      // Login(encryptionpassword.toString(),
                                      //     encryptionusername.toString());

                                      // postdata(pass.text, id.text);
                                    }),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     print("reset");
                              //   },
                              //   child: Container(
                              //     height: 50,
                              //     margin: EdgeInsets.symmetric(horizontal: 100),
                              //     decoration: BoxDecoration(
                              //       color: Color.fromRGBO(123, 34, 83, 1),
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         "Reset",
                              //         style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 20,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // TextButton(
                              //   onPressed: () {
                              //     final introShown = GetStorage();
                              //     introShown.erase();
                              //   },
                              //   child: Text(
                              //     "Forgot Password ?",
                              //     style: TextStyle(
                              //         fontSize: 18.sp,
                              //         fontWeight: FontWeight.bold,
                              //         color: securePurpleColor),
                              //   ),
                              // )
                            ],
                          )

                          // <-----------code for button------------------------------------------------->
                        ],
                      ),
                    )
                    // <-------------------------------------code for input wrapper-------------------->
                    ),
              ),
            )
          ]),
        ),
      ),
    );
  }

//!<-----------code for validation for textbox--------------------->
  validate() {
    if (_formKey.currentState!.validate()) {
      print("validate");
      Login(encryptionpassword.toString(), encryptionusername.toString());
    } else {
      print("validate");
    }
  }
  //<-----------code for validation for textbox--------------------->

  //!<-----------code for api hit for login page------------>
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

  void Login(String password, String username) async {
    try {
      if (password.isNotEmpty || username.isNotEmpty) {
        _openLoadingDialog(context);
        setState(() {
          isApiCallProcess = true;
        });
        Map data = {
          "UserName": username,
          "Password": password,
          "cpf_prc": id.text,
          "check_os_prc": operating_System.toString(),
          "token_id_prc": deviceTokenToSendPushNotification.toString(),
          "flag": "1"
        };
        String _apiendpoint = "$ServerUrl/api/MobileLogin/LoginADWithAuth";
        Response? response =
            await myHttpClient.PostMethod(_apiendpoint, data, "null", false);
        // // Response response = await post(
        //     Uri.parse(
        //         "$ServerUrl/api/MobileLogin/LoginADWithAuth"), // "http://172.16.15.129:8026/api/UserAuth/LoginADWithAuth" // old one deployed working
        //     body: {
        //       "UserName": username,
        //       "Password": password,
        //       "cpf_prc": id.text,
        //       "check_os_prc": operating_System.toString(),
        //       "token_id_prc": deviceTokenToSendPushNotification.toString(),
        //       "flag": "1"
        //     });

        if (response!.statusCode == 200) {
          // saving jwt tokken in session
          var jsonBody = response.body;
          var jsonData = json.decode(jsonBody);
          var isvalidate = jsonData["Validate"];
          var JWT_tokken = jsonData["Tokken"];

          if (isvalidate) {
            //var token = {"user_token": JWT_tokken};  // old approch to save tokken

            var any = await SharedPreferences.getInstance();
            //any.setString("userData", json.encode(token)); // old approch to save tokken
            var encrypedTokken =
                MyEncryption.CryptoGraphy("Encryption", JWT_tokken);
            any.setString("userData", encrypedTokken.toString());

            var shareduser = await SharedPreferences.getInstance();
            var encrypedEmployeeId =
                MyEncryption.CryptoGraphy("Encryption", id.text);
            shareduser.setString("shareduser", encrypedEmployeeId.toString());

            globalInt = MyEncryption.CryptoGraphy(
                "Decryption", shareduser.get("shareduser").toString());

            JWT_Tokken = MyEncryption.CryptoGraphy(
                "Decryption", shareduser.get("userData").toString());

            print(globalInt);

            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => SignUp(
            //       cameraDescription: cameraDescription,
            //     ),
            //   ),
            //

            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            );

            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            // );

            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => HomePage2(home: shareduser.toString())));
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Invalid Credentials.")));
          }
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Network Error !")));
        }
        setState(() {
          id.clear();
          pass.clear();
        });
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please provide the Credentials.")));
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something Went Wrong Try Again Later..")));
    } finally {
      // Navigator.pop(context);
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

  // Future<bool> tryAutoLogin() async {
  //   var any = await SharedPreferences.getInstance();
  //   if (!any.containsKey("userData")) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  //   Navigator.pushNamed(context, "loginpage");
  // }

  //<-----------code for api hit for login page------------>
}
