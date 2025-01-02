import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission
    await _requestPermission();

    // Setup message handlers
    await _setupMessageHandlers();

    // Get FCM token
    // final token = await _messaging.getToken();
    // print('FCM Token: $token');
  }

  Future<void> _requestPermission() async {
    // ignore: unused_local_variable
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    // android setup
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios setup
    // ignore: prefer_const_constructors
    final initializationSettingsDarwin = DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // flutter notification setup
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
            'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      // open chat screen
    }
  }

  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "robou-b3bce",
      "private_key_id": "393363336a19d1860b207ac3809b6584a9af074c",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDRABEkYdb/IB7f\ncyTRyADqYjRhgNywrMnRJsCGwQozP9bS2ITkovnvzU2a/vnFp7hCV/8hCzk5nDri\n5YFv1agnQH1fiJGEgTYAF25dYp/5bQ+BV4U89KKcoKuVMPOLQl+Zljv71d5I2/68\nQcqXxg9pXRi/qQBA8Hzu/b2j7ZZgZFESsuyDQfIWNd6CIJaLn+9L6HnMJPgbqLiH\nTYrl+3FNoGNm4mu37Uzv0jXR8YaWDu9PYa6Z6bya34lsBx2tnUQTWNj8fhW/nOQv\nV/OyooHMnLVshrqw0WBVyPB4aCSHJn79lfejnkSnbtPv7pt8VUEqhkltYc56zNFB\nyyoBGZXZAgMBAAECggEAEo9q9kwqB6YWl8ll76tPSYFHHZGQB7CQi55hYpYqDbsR\nnM/VnWhLwdv9lFIoZEEsv9eItKqGfnM9V4ECKahTsoirmZxLL/U5knCCQJDNnBzv\nT5EyJ+OhvT8XfbxHJIrUapNI6GhpwRaoXJeLIkdYfwbhd8POXfX9YkvuV2x1+kFF\nSzTfo3+ftKm4qoEqHN6NPnJPGp5gWnMW3uEUmv3R2gR6wYxaCdERjLxYOWeCLgQV\nNgmM8zNu1cojZhKU+0LMiWiP5r+ixa9gJ0rE1puEdxD2tYDqbtt40Y7zUjipq/Ac\nRIYHyhozw1pEoMcWqK9zYJSsw1j86pkgl4tULMHLcQKBgQDq/0mR69goX9DhR8cd\n7/ntfn3fZx0iAVEYvKM/sfVL9lyAtYgNUnqQ/LfxpbtHY018tBKp/i1cYIKo52uw\nBVBhxg0RJt7SwsSVF83CX7mwgQLzisNxqzFs6G51vTe61TNh492DGlp8xvYFZTNm\n343cO6qD8Pmg1C3okgAmrKBEEwKBgQDjrfjMw26SzhWUWtGdSoIyfsnlqIdECD6U\n+PDe0WNcESLzJHXVl3Syi5BIfpDgeQi9SkCikuv3qbF0TXMAqpjmsQItj53JhwsT\ngVSGEZ5B9mFgecu7v4PQXmiELkIDF75SNT4o3737Ain7+kr6NWgHgT4Qyhj9z+C/\nfGupxSsD4wKBgEXCmRVvXNDHeNuXkj2J4rik5zrtglF48JkWTqP28SmmrdkrioLh\n7C6kRvq+RzUu/m65ihzarp6Qq9j2MhqjyTPtNi3USytn1DGqSlOcVSRXeAfSNqjE\nuDxrV3cuP5//8Gvr1/M2XIxUB+6cF0E/tf4d3EWkwIYE1sgGp3LTphPvAoGAdRYX\nt/3dFGQlFtkpqRETKbKoU5G6llMDFAt9m6jkxwkNBys96ezsl5FMTuu/x6CWzPmt\nia2y6fd7icr2lGYnIaPv8cxEocnv+UTuWdAfqd5xr3KTQmc3+2VBrJA5ZGvGdXJq\nGA0QH1C6lJngCxKCADIH4Ax+k7Be7TqoB3OdLm8CgYATMEDIPufBidig7/V+ecrB\nNrAxTxABAJTgyRzxqxBiRR4Oea8gFprFAQnNyERo17LYaV0S7zDVPJs/cN/Sa6mZ\nYhAFnL1bylI/lnRKQcy1pdDci46HIWqWku/IXbcs971RVsnP+x+TpTS0MZerYO5r\ncyDFh3Kfpq6icRZq3yBJ2A==\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-tpnok@robou-b3bce.iam.gserviceaccount.com",
      "client_id": "108507112202630330773",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-tpnok%40robou-b3bce.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
      await auth.obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
          scopes,
          client);

      client.close();
      print(
          "Access Token: ${credentials.accessToken.data}"); // Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }

  Map<String, dynamic> getBody({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) {
    return {
      "message": {
        "token": fcmToken,
        "notification": {"title": title, "body": body},
        "android": {
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default"
          }
        },
        "apns": {
          "payload": {
            "aps": {"content_available": true}
          }
        },
        "data": {
          "type": type,
          "id": userId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      }
    };
  }

  Future<void> sendNotifications({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) async {
    try {
      var serverKeyAuthorization = await getAccessToken();

      // change your project id
      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/robou-b3bce/messages:send";

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

      var response = await dio.post(
        urlEndPoint,
        data: getBody(
          userId: userId,
          fcmToken: fcmToken,
          title: title,
          body: body,
          type: type ?? "message",
        ),
      );

      // Print response status code and body for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}