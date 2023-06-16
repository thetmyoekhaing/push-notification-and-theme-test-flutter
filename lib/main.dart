import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/state.dart';
import 'package:untitled/theme/custom_color.g.dart';
import 'package:untitled/theme/theme.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint("handle background messages -> ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  getState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.find();

    return Obx(() {
      // print(theme.isDarkMode.value);

      final ThemeMode themeMode =
          theme.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          extensions: [lightCustomColors],
          useMaterial3: true,
          colorScheme: theme.lightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: theme.darkColorScheme,
          extensions: [darkCustomColors],
        ),
        themeMode: themeMode,
        home: const HomePage(),
      );
    });
  }
}
