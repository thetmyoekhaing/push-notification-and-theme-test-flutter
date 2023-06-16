import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:untitled/models/notification_model.dart';
import 'package:untitled/theme/theme.dart';

void getState() {
  Get.put(NotiList());
  Get.lazyPut(() => CustomTheme());
  // Get.put(NotificationModel());
  debugPrint("state called");
}
