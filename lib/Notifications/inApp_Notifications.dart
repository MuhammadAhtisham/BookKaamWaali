import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


  @override
  // void initState()
  // {
  //   super.initState();
  //   Notification();
  //
  // }
  void Notification() async {
    String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    String utcTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
      else{
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10,
              // do not change this key
              channelKey: 'basic_channel',
              title: 'Simple Notification',
              body: 'Simple body',
              notificationLayout: NotificationLayout.BigPicture,
              bigPicture: 'asset://assets/images/faceproduct.png'
          ),
            schedule: NotificationCalendar(
                second: 0,
                timeZone: localTimeZone,
                repeats: false)
        );
      }
    });
  }
  @override
  void dispose() {
     Notification();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
            child: Text("Get Notification"),
          ),
        ),
    );
  }
}

/// two types of notification - in-app & push notification
/// in-app notification generates notification after a specified time automatically. eg game app generates come back notification to an individual
/// push notification generates notification as action is performed on app eg food app generates discount offer, instant message
