import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:secure_apk/globals.dart';

import 'package:secure_apk/models/profileModel.dart';
import 'package:secure_apk/reuseablewidgets.dart/sessionexpire.dart';

import 'reuseablewidgets.dart/Common.dart';
import 'reuseablewidgets.dart/colors.dart';
import 'reuseablewidgets.dart/loder.dart';

class ViewProfile extends StatefulWidget {
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  var userempno;
  late sessionExpired sessionexpired = new sessionExpired(context);

  bool circular = true;
  late ProfileModel profileModel;
  var pic;

  @override
  late bool hasInternet;
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      final connected = await InternetConnectionChecker().hasConnection;
      if (connected) {
        FetchUserData(globalInt);
      }
    });

    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      if (!mounted) return;
      setState(() => this.hasInternet = hasInternet);
      if (!this.hasInternet) {
      } else {
        FetchUserData(globalInt);
      }
    });
    //  profileData();
  }

  Future<List<ProfileModel>> FetchUserData(var empno) async {
    List<ProfileModel> users = [];

    final String apiEndpoint =
        "$ServerUrl/api/MobileAPI/GETUSERDETAILS?CPF_NO=$empno";

    Response? response = await myHttpClient.GetMethod(
        apiEndpoint, "Adjustmentapprovalpage", true);
    // final String apiEndpoint =
    //     "http://172.16.15.129:8022/Employee/api/MobileAPI/GetUserInfo?CPF_NO=$empno";

    // final Uri url = Uri.parse(apiEndpoint);
    // final response = await http.get(
    //   url,
    //   headers: {
    //     //"MobileURL": "Leaveapprovalpage",
    //     "MobileURL": "Adjustmentapprovalpage",
    //     "CPF_NO": globalInt.toString(),
    //     "Authorization": "Bearer $JWT_Tokken"
    //   },
    // );

    if (response!.statusCode == 200) {
      if (response.body.isNotEmpty && response.body != "[]") {
        setState(() {
          final decodedData = jsonDecode(response.body);
          List<ProfileModel> list = List.from(decodedData)
              .map<ProfileModel>(
                (item) => ProfileModel.fromJson(item),
              )
              .toList();
          profileModel = list.first;

          // var decoded = base64.decode(profileModel.cpf_image);
          // print(decoded);

          // List<dynamic> data = jsonDecode(response.body);
          // users = data.map((data) => ProfileModel.fromJson(data)).toList();
          // profileModel = users.first;
          // print(profileModel.EMP_NAME);

          circular = false;
          profilePhotoGlobal = profileModel.cpf_image.toString();

          // print(users);
          // print(profileModel.designation);
          // print(profileModel.operating);
          // print(profileModel.level);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No data found',
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
          return const AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              'Internal server error !',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "View Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 1,
          shadowColor: Colors.white,
          backgroundColor: Global_User_theme,
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Navigator.pushNamed(context, "Homepage");
          //   },
          //   color: Colors.black,
          // ),
          actions: [circularBird()],
        ),
        body: circular
            ? Center(
                child: CustomLoader(
                  dotColor: Global_User_theme,
                ),
              )
            :
            // circular
            //     ? Center(
            //         child: CircularProgressIndicator(color: Global_User_theme),
            //       )
            //     :
            SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(
                  children: <Widget>[
                    Header(),
                    SizedBox(
                      height: 10,
                    ),
                    BodyDetails()
                  ],
                ),
              )
        // Stack(
        //     children: [
        //       Column(
        //         children: [
        //           SingleChildScrollView(
        //             child: Expanded(
        //               flex: 3,
        //               child: Container(
        //                 width: double.infinity,
        //                 decoration: BoxDecoration(
        //                   gradient: LinearGradient(
        //                     colors: [
        //                       Color.fromRGBO(222, 174, 42, 1),
        //                       Color.fromRGBO(222, 174, 42, 1)
        //                     ],
        //                   ),
        //                 ),
        //                 child: Column(children: [
        //                   CircleAvatar(
        //                     radius: 50.0,
        //                     backgroundImage: MemoryImage(
        //                       base64Decode(profileModel.cpf_image),
        //                     ),
        //                     backgroundColor: Colors.white,
        //                   ),
        //                   SizedBox(
        //                     height: 5.0,
        //                   ),
        //                   Text(profileModel.emp_name,
        //                       style: TextStyle(
        //                         color: Colors.white,
        //                         fontSize: 20.0,
        //                       )),
        //                   SizedBox(
        //                     height: 10.0,
        //                   ),
        //                   Text(
        //                     profileModel.designation_name,
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 15.0,
        //                     ),
        //                   )
        //                 ]),
        //               ),
        //             ),
        //           ),
        //           Expanded(
        //             flex: 7,
        //             child: Container(
        //               color: Color.fromRGBO(222, 174, 42, 1),
        //               child: Center(
        //                   child: Card(
        //                       color: Colors.grey.shade200,

        //                       // margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 2),
        //                       child: Container(
        //                           // width: 310.0,
        //                           // height: 290.0,
        //                           child: Padding(
        //                         padding: EdgeInsets.all(10.0),
        //                         child: Column(
        //                           crossAxisAlignment:
        //                               CrossAxisAlignment.start,
        //                           children: [
        //                             Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.start,
        //                               children: [
        //                                 Icon(
        //                                   Icons.person,
        //                                   color:
        //                                       Color.fromRGBO(123, 34, 83, 1),
        //                                   size: 40,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 20.0,
        //                                 ),
        //                                 Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       profileModel.CPF_NO.toString(),
        //                                       style: TextStyle(
        //                                         fontSize: 15.0,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 )
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: 20.0,
        //                             ),
        //                             Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.start,
        //                               children: [
        //                                 Icon(
        //                                   Icons.title,
        //                                   color:
        //                                       Color.fromRGBO(123, 34, 83, 1),
        //                                   size: 40,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 20.0,
        //                                 ),
        //                                 Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       profileModel.role_title
        //                                           .toString(),
        //                                       style: TextStyle(
        //                                         fontSize: 15.0,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 )
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: 20.0,
        //                             ),
        //                             Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.start,
        //                               children: [
        //                                 Icon(
        //                                   Icons.arrow_upward,
        //                                   color:
        //                                       Color.fromRGBO(123, 34, 83, 1),
        //                                   size: 40,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 20.0,
        //                                 ),
        //                                 Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       profileModel.securelevel
        //                                           .toString(),
        //                                       style: TextStyle(
        //                                         fontSize: 15.0,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 )
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: 20.0,
        //                             ),
        //                             Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.start,
        //                               children: [
        //                                 Icon(
        //                                   Icons.location_city,
        //                                   color:
        //                                       Color.fromRGBO(123, 34, 83, 1),
        //                                   size: 40,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 20.0,
        //                                 ),
        //                                 Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       profileModel.ou_name,
        //                                       style: TextStyle(
        //                                         fontSize: 15.0,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 )
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: 20.0,
        //                             ),
        //                             Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.start,
        //                               children: [
        //                                 Icon(
        //                                   Icons.people_alt_rounded,
        //                                   color:
        //                                       Color.fromRGBO(123, 34, 83, 1),
        //                                   size: 40,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 20.0,
        //                                 ),
        //                                 Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       profileModel.organization_name,
        //                                       style: TextStyle(
        //                                         fontSize: 15.0,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 )
        //                               ],
        //                             ),
        //                             SizedBox(
        //                               height: 20.0,
        //                             ),
        //                             Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.start,
        //                               children: [
        //                                 Icon(
        //                                   Icons.location_history,
        //                                   color:
        //                                       Color.fromRGBO(123, 34, 83, 1),
        //                                   size: 40,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 20.0,
        //                                 ),
        //                                 Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       profileModel.location_code,
        //                                       style: TextStyle(
        //                                         fontSize: 15.0,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 )
        //                               ],
        //                             ),
        //                           ],
        //                         ),
        //                       )))),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        );
  }

  Widget Header() {
    return Container(
      color: Global_User_theme,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShowPhotoFullScreen())),
                      child: Hero(
                        tag: "a",
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              MemoryImage(base64Decode(profileModel.cpf_image)),
                          radius: 45.r,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      profileModel.emp_name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sm,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      profileModel.designation_name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sm,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              // Text(
              //   "Employe No: ",
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Text(profileModel.CPF_NO.toString(),
              //     style: TextStyle(fontSize: 15)),
              // SizedBox(height: 10),
              // Divider(
              //   thickness: 0.8,
              // ),
              // Text(
              //   "Role title: ",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Text(
              //   profileModel.role_title,
              //   style: TextStyle(fontSize: 15),
              // ),
            ]),
      ),
    );
  }

  Widget BodyDetails() {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
          child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Center(
                child: Column(
                  children: [],
                ),
              ),
              Text(
                "Employe No: ",
                style: TextStyle(fontSize: 16.sm, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(profileModel.CPF_NO.toString(),
                  style: TextStyle(fontSize: 15.sm)),
              SizedBox(height: 10.h),
              Divider(
                thickness: 0.8.h,
              ),
              Text(
                "Role title: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sm),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                profileModel.role_title,
                style: TextStyle(fontSize: 15.sm),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 0.8.h,
              ),
              Text(
                "Secure level: ",
                style: TextStyle(fontSize: 16.sm, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(profileModel.securelevel, style: TextStyle(fontSize: 15.sm)),
              SizedBox(height: 10.h),
              Divider(
                thickness: 0.8.h,
              ),
              Text(
                "Organization:  ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sm),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                profileModel.organization_name,
                style: TextStyle(fontSize: 15.sm),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 0.8.h,
              ),
              Text(
                "Operating unit:  ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sm),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                profileModel.ou_name,
                style: TextStyle(fontSize: 15.sm),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 0.8.h,
              ),
              Text(
                "Location:   ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sm),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                profileModel.location_code,
                style: TextStyle(fontSize: 15.sm),
              ),
              Divider(
                thickness: 0.8.h,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // Widget otherDetails(String label, String value) {
  //   return SingleChildScrollView(
  //     child: Container(
  //       margin: EdgeInsets.only(right: 245),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               "$label :",
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             ),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             Text(
  //               value,
  //               style: TextStyle(fontSize: 15),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget fullsizeimage() {
    return Scaffold(
      body: Hero(
        tag: "a",
        child: Image(
          image: MemoryImage(base64Decode(profileModel.cpf_image)),
        ),
      ),
    );
  }
}

class ShowPhotoFullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global_User_theme,
        actions: [circularBird()],
      ),
      body: Hero(
        tag: "a",
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Image(
            fit: BoxFit.contain,
            image: MemoryImage(base64Decode(profilePhotoGlobal)),
            // height: 200,
          ),
        ),
      ),
    );
  }
}
