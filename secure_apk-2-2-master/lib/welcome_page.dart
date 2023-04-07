import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:secure_apk/login_page.dart';

bool welcomeEnd = false;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final introShown = GetStorage();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: 'Mark Your Attendance',
            body:
                'This Application Can Be Used By Secure Employees To Perform Their punch In & Punch Out Task',
            image: buildImage('images/pipo.jpg'),
            decoration: getPageDecoration()),
        PageViewModel(
            title: 'Apply For Your Leaves',
            body:
                'This Application Can Be Used By Secure Employees To Apply For Their Leaves',
            image: buildImage('images/leave.jpeg'),
            decoration: getPageDecoration()),
        PageViewModel(
            title: 'Apply For Your Adjustment',
            body:
                'This Application Can Be Used By Secure Employees To Apply For Their Leaves',
            image: buildImage('images/adjtment.jpg'),
            decoration: getPageDecoration()),
        PageViewModel(
            title: 'Manager Approval',
            body:
                'Managers Can Approve The Attendance,Leave & Adjustment Of Their Employees',
            image: buildImage('images/approval.jpg'),
            decoration: getPageDecoration()),
      ],
      done: Text(
        "Lets go",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(123, 34, 83, 1),
        ),
      ),
      onDone: () => goToHome(context),
      showNextButton: true,
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(123, 34, 83, 1),
        ),
      ),
      next: Icon(
        Icons.arrow_forward_ios_outlined,
        color: Color.fromRGBO(123, 34, 83, 1),
      ),
      dotsDecorator: getDotDecoration(),
      // globalBackgroundColor: Color.fromRGBO(123, 34, 83, 1),
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.grey,
        size: Size(10, 10),
        activeColor: Color.fromRGBO(123, 34, 83, 1),
      );

  void goToHome(context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => Login_page()));
    introShown.write("displayed", true);
  }

  Widget buildImage(String path) => Center(
        child: Image.asset(
          path,
          width: 350,
        ),
      );
  PageDecoration getPageDecoration() => PageDecoration(
          titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          bodyTextStyle: TextStyle(fontSize: 20),
          bodyPadding: EdgeInsets.all(16),
          imagePadding: EdgeInsets.all(50),
          pageColor: Colors.white)
      .copyWith();
}
