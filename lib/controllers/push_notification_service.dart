import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/env.dart';
import 'package:untitled/models/notification_model.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final Dio _dio = Dio();
  final NotificationModel notiState = Get.put(NotificationModel());
  // NotificationModel _notificationModel = NotificationModel();
  void init() {
    const androidInitialize =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: androidInitialize);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        try {
          if (details.payload != null && details.payload!.isNotEmpty) {
            debugPrint("clicked");

            final NotificationModel? noti = notiState.getNoti();
            debugPrint("added noti ${noti?.title}");
            Get.find<NotiList>().addNotiList(notification: noti!);
          } else {
            debugPrint("payload is  null");
          }
        } catch (e) {
          throw Exception(e);
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      debugPrint("listened by opened app ****************");
      debugPrint("on message opened app");
      debugPrint(event.notification?.title ?? "title null");
      debugPrint(event.notification?.body ?? "body null");
    });

    // foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint(
          "---------------------------------- on message ----------------------------------");
      debugPrint(
          "TITLE : ${message.notification?.title} BODY : ${message.notification?.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContent: true);
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('test', 'high_importance_channel',
              importance: Importance.defaultImportance,
              styleInformation: bigTextStyleInformation,
              priority: Priority.max,
              playSound: true);
      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await _flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          notificationDetails,
          payload: message.data['body']);
    });
  }

  Future<void> getTokenFromFirebase() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      debugPrint("token -----------> $token");

      saveToken(token: token!);
    });
  }

  Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  Future<void> saveToken({required String token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
  }

  Future<void> requestPermission() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission();

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      debugPrint("User accepted permission");
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User accepted provisional permission");
    } else {
      debugPrint("User declined permission");
    }
  }

  Future<dynamic> postApi(
      {required String token,
      required String title,
      required String body}) async {
    final Map<String, String> headers = {
      'content-type': "application/json",
      'Authorization': "key=$serverKey"
    };

    final Map<String, dynamic> postData = {
      'priority': 2,
      'data': <String, String>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'body': body,
        'title': title
      },
      'notification': <String, String>{
        'title': title,
        'body': body,
        'android_channel_id': 'test'
      },
      'to': token
    };

    notiState.saveNoti(
        notificationModel: NotificationModel(title: title, body: body));
    // print("post data ${postData.toString()}");
    try {
      final res = await _dio.post(postApiUrl,
          options: Options(
            headers: headers,
          ),
          data: jsonEncode(postData));

      debugPrint("respond from firebase -------------> ${res.data.toString()}");
      return res.data;
    } catch (e) {
      if (e is DioException) {
        debugPrint('Dio Error: ${e.message}');
        debugPrint('Dio Error Details: ${e.response}');
      }
      throw Exception("Post Error $e");
    }
  }

  void fetchApi() async {
    final String? token = await getToken();
    if (token == null) throw Exception('Need token to fetch');
    final String baseUrl = '$fetchApiUrl/$token';
    debugPrint("fetching to ------------- $baseUrl ------------- ");
    final Map<String, String> headers = {
      'content-type': "application/json",
      'Authorization': "key=$serverKey"
    };
    final res = await _dio.get(baseUrl, options: Options(headers: headers));
    debugPrint("fetched data ---------------> ${res.data.toString()}");
  }
}
