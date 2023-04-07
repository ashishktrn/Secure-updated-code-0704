import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true,
            ));

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? id) {
        print("onSelectNotification");
        print("okkkkkkk selected");
        if (id!.isNotEmpty) {
          // logic for  redirecting on another screen on notificition tab

          print("okkkkkkk selected");
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => HomePage(),
          //   ),
          // );
        }
      },
    );
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "SECURE_PROJECT", "SECURE_PROJECTchannel",
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              channelShowBadge: true,
              enableVibration: true,
              sound: RawResourceAndroidNotificationSound('notification')),
          iOS: IOSNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            //badgeNumber: 1,
            // subtitle: "hello",
          ));

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
