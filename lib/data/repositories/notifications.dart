// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;

// class NotificationServices extends ChangeNotifier {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future initalize() async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings("app_icon");

//     IOSInitializationSettings iosInitializationSettings =
//         IOSInitializationSettings();

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future instantNotification({title, subtitle}) async {
//     var android = AndroidNotificationDetails(
//       'id',
//       'channel',
//       'description',
//       icon: "app_icon",
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     var ios = IOSNotificationDetails();

//     var platform = NotificationDetails(android: android, iOS: ios);

//     await _flutterLocalNotificationsPlugin.show(
//         1, "$title", '$subtitle', platform);
//   }

//   Future scheduleNotification({title, body}) async {
//     var android = AndroidNotificationDetails(
//       'id',
//       'channelName',
//       'channelDescription',
//       channelShowBadge: false,
//       largeIcon: DrawableResourceAndroidBitmap('app_icon'),
//       icon: "app_icon",
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     var ios = IOSNotificationDetails();

//     var platform = NotificationDetails(android: android, iOS: ios);

//     var interval = RepeatInterval.everyMinute;
//     await _flutterLocalNotificationsPlugin.periodicallyShow(
//         2, title, body, interval, platform);
//   }

//   Future schedulePillsNotification() async {
//     var android = AndroidNotificationDetails(
//         'id', 'channelName', 'channelDescription',
//         icon: "app_icon", importance: Importance.high, priority: Priority.high);
//     var ios = IOSNotificationDetails();

//     var platform = NotificationDetails(android: android, iOS: ios);

//     _flutterLocalNotificationsPlugin.zonedSchedule(
//         123,
//         'Scheduled Notification',
//         'Some pill notification',
//         tz.TZDateTime.now(tz.local).add(
//           Duration(seconds: 10),
//         ),
//         platform,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         androidAllowWhileIdle: true);
//   }

//   Future cancelNotifications() async {
//     await _flutterLocalNotificationsPlugin.cancel(2);
//   }
// }
