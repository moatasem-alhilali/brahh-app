import 'package:active_ecommerce_flutter/custom/btn.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/screens/order_details.dart';
import 'package:active_ecommerce_flutter/features/auth/presentation/view/pages/login.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/repositories/profile_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:one_context/one_context.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final AndroidNotificationChannel channel = AndroidNotificationChannel(
    '0', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );
  Future initialise() async {
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? fcmToken = await _fcm.getToken();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    if (fcmToken != null) {
      // print("--fcm token--");
      // print(fcmToken);
      if (is_logged_in.$ == true) {
        await ProfileRepository().getDeviceTokenUpdateResponse(fcmToken);
      }
    }

    FirebaseMessaging.onMessage.listen((event) {
      //print("onLaunch: " + event.toString());
      _showMessage(event);
      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      var initializationSettingsAndroid = AndroidInitializationSettings(
          '@mipmap/ic_launcher'); // <- default icon name is @mipmap/ic_launcher

      var initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      flutterLocalNotificationsPlugin.initialize(initializationSettings);

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
                // other properties...
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print("onResume: $message");
        (Map<String, dynamic> message) {
          _serialiseAndNavigate(message);
        };
      },
    );
  }

  static void message() {
    FirebaseMessaging.onMessage.listen((event) {
      print("===============on Message ===============");
      print(event.notification!.body);
      print("===============on Message ===============");
    }).onError((error) {
      print("===============on Message error ===============");

      print(error);
      print("===============on Message error ===============");
    });
  }

  static void messageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("===============on message Opened App ===============");
      print(event.notification!.body);
      print("===============on Message ===============");
    }).onError((error) {
      print("===============on onMessageOpenedApp error ===============");

      print(error);
      print("===============on onMessageOpenedApp error ===============");
    });
  }

//Background Message
  static Future<void> _onBackgroundMessage(RemoteMessage message) async {
    print("===============on message Opened App ===============");
    print(message.notification!.body);
    print("===============on Message ===============");
  }

  //init Background Message
  static void initBackgroundMessage() {
    try {
      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    } catch (e) {
      print("===============on initBackgroundMessage error ===============");

      print(e);
      print("===============on initBackgroundMessage error ===============");
    }
  }

  void _showMessage(RemoteMessage message) {
    //print("onMessage: $message");

    OneContext().showDialog(
      // barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: ListTile(
          title: Text(message.notification!.title!),
          subtitle: Text(message.notification!.body!),
        ),
        actions: <Widget>[
          Btn.basic(
            child: Text('close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Btn.basic(
            child: Text('GO'),
            onPressed: () {
              if (is_logged_in.$ == false) {
                ToastComponent.showDialog("You are not logged in",
                    gravity: Toast.top, duration: Toast.lengthLong);
                return;
              }
              //print(message);
              Navigator.of(context).pop();
              if (message.data['item_type'] == 'order') {
                OneContext().push(MaterialPageRoute(builder: (_) {
                  return OrderDetails(
                      id: int.parse(message.data['item_type_id']),
                      from_notification: true);
                }));
              }
            },
          ),
        ],
      ),
    );
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    print(message.toString());
    if (is_logged_in.$ == false) {
      OneContext().showDialog(
        // barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: new Text("You are not logged in"),
          content: new Text("Please log in"),
          actions: <Widget>[
            Btn.basic(
              child: Text('close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Btn.basic(
              child: Text('Login'),
              onPressed: () {
                Navigator.of(context).pop();
                OneContext().push(
                  MaterialPageRoute(
                    builder: (_) {
                      return Login();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
      return;
    }
    if (message['data']['item_type'] == 'order') {
      OneContext().push(
        MaterialPageRoute(
          builder: (_) {
            return OrderDetails(
              id: int.parse(message['data']['item_type_id']),
              from_notification: true,
            );
          },
        ),
      );
    } // If there's no view it'll just open the app on the first view    }
  }
}
