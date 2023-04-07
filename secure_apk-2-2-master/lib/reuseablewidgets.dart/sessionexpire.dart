import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:secure_apk/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_page.dart';
import 'Common.dart';

class sessionExpired {
  final BuildContext context;
  final TextEditingController _feedbackController =
      TextEditingController(text: '');
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  sessionExpired(this.context);

  LogoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    Map data = {"cpf_prc": globalInt, "flag": "0"};

    try {
      String _apiendpoint = "$ServerUrl/api/MobileLogin/LoginADWithAuth";
      Response? response =
          await myHttpClient.PostMethod(_apiendpoint, data, "null", false);
      // Response response = await post(
      //     Uri.parse(
      //         "http://172.16.15.129:8024/api/MobileLogin/LoginADWithAuth"), //add tokken
      //     body: {"cpf_prc": globalInt, "flag": "0"});

      if (response!.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login_page()),
          (Route<dynamic> route) => false,
        );
        print(response.body);
      } else {
        print("faild");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login_page()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      prefs.clear();
      // setState(() {
      //   _logOutLoading = false;
      // });
    }
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.red,
          content: Text(
            'Session has expired !',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
