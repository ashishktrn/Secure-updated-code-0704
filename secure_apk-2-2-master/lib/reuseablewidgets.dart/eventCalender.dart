import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../globals.dart';
import '../models/eventCalenderModal.dart';
import 'colors.dart';

class CalendarPage2 extends StatefulWidget {
  @override
  _CalendarPage2State createState() => new _CalendarPage2State();
}

List<DateTime> presentDates = [
  DateTime(2023, 3, 1),
  DateTime(2023, 3, 10),
];
List<Map<DateTime, String>> HrleavesDates = [];

class _CalendarPage2State extends State<CalendarPage2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetRhListOfEmployee();
  }

  late List<EventCalenderModalForRH> emplist;
  bool isapiloding = true;
  var length = HrleavesDates.length;
  Future GetRhListOfEmployee() async {
    Response response;
    response = await post(
        Uri.parse("http://172.16.15.129:8024/api/LeaveAPI/GetLeaveEmpQuery"),
        headers: {
          "MobileURL": "Leave_Balance",
          "CPF_NO": globalInt.toString(),
          "Authorization": "Bearer $JWT_Tokken"
        },
        body: {
          "cpfNo": globalInt.toString(),
          "Flag": "GET_RH_DETAIL_EMP",
        });
    print(response.body);
    if (response.statusCode == 401) {
      var isunauth = response.reasonPhrase;
      if (isunauth == "Unauthorized") {
// logic for login the user out
        return;
      }
    }
    try {
      var decode = json.decode(response.body);
      var data = decode['Table'];
      var resultsJson = data.cast<Map<String, dynamic>>();
      emplist = await resultsJson
          .map<EventCalenderModalForRH>(
              (json) => EventCalenderModalForRH.fromJson(json))
          .toList();
      HrleavesDates = emplist
          .map((event) => {
                event.RH_DATE: event.RH_NAME,
              })
          .toList();
      //  HrleavesDates = emplist.map((data) => data.RH_DATE).toList();

      length = HrleavesDates.length;
      setState(() {
        isapiloding = false;
      });
      if (decode.isNotEmpty) {
        print(data);
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No response from server',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      print(e);
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
  }

  DateTime _currentDate2 = DateTime.now();
  static Widget _presentIcon(String day) => CircleAvatar(
        backgroundColor: Colors.green.shade200,
        child: Text(
          day,
          style: TextStyle(color: Colors.black),
        ),
      );
  static Widget _rhLeaveIcon(String day) => CircleAvatar(
        backgroundColor: Colors.yellow,
        child: Text(
          day,
          style: TextStyle(color: Colors.black),
        ),
      );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  late CalendarCarousel _calendarCarouselNoHeader;

  var len = presentDates.length;

  late double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        presentDates[i],
        new Event(
          date: presentDates[i],
          title: 'Event 7',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < length; i++) {
      _markedDateMap.add(
        HrleavesDates[i].keys.first,
        new Event(
          date: HrleavesDates[i].keys.first,
          title: HrleavesDates[0].values.toString(),
          icon: _rhLeaveIcon(
            HrleavesDates[i].keys.first.day.toString(),
          ),
        ),
      );
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      onDayPressed: (p0, p1) async {
        String eventTitle = '';
        for (Map<DateTime, String> leaveDate in HrleavesDates) {
          leaveDate.forEach((key, value) {
            print('Leave date: $key');

            if (p0 == key) {
              eventTitle = value;
              return;
            }
          });
          if (eventTitle.isNotEmpty) {
            break;
          }
        }
        // final RenderBox button = context.findRenderObject() as RenderBox;
        // final Offset offset = button.localToGlobal(Offset.zero);

        // // Show the popup
        // await showMenu(
        //   context: context,
        //   position: RelativeRect.fromLTRB(
        //     offset.dy,
        //     offset.dy,
        //     offset.dx + button.size.width,
        //     offset.dy + button.size.height,
        //   ),
        //   items: [
        //     PopupMenuItem(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text('Event Details'),
        //           SizedBox(height: 8.0),
        //           Text('Date: ${DateFormat('EEEE, MMMM d, y').format(p0)}'),
        //           SizedBox(height: 8.0),
        //           Text('Details: $eventTitle'),
        //         ],
        //       ),
        //     ),
        //   ],
        // );
        if (eventTitle.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(DateFormat('EEEE, MMMM d, y').format(p0)),
                content: Text('RH for $eventTitle'),
              );
            },
          );
        }
      },
      todayButtonColor: Colors.blue,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return new Scaffold(
      body: isapiloding
          ? Center(
              child: CircularProgressIndicator(color: Global_User_theme),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _calendarCarouselNoHeader,
                  Wrap(
                    children: [
                      markerRepresent(Colors.red, "Absent"),
                      markerRepresent(Colors.green, "approved"),
                      markerRepresent(Colors.yellow, "Restricted holiday"),
                      markerRepresent(Colors.blue, "holiday"),
                      markerRepresent(Colors.grey, "applied"),
                    ],
                  )
                  // markerRepresent(Colors.red, "Absent"),
                  // markerRepresent(Colors.green, "approved"),
                  // markerRepresent(Colors.yellow, "Restricted holiday"),
                  // markerRepresent(Colors.blue, "holiday"),
                  // markerRepresent(Colors.grey, "applied"),
                ],
              ),
            ),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        // radius: cHeight * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }
}
