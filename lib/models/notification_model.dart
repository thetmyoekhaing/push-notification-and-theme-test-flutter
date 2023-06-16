import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/push_notification_service.dart';

class NotificationModel extends GetxController {
  String? title;
  String? body;
  NotificationModel({this.body, this.title});

  void saveNoti({NotificationModel? notificationModel}) {
    if (notificationModel != null) {
      title = notificationModel.title;
      body = notificationModel.body;
      debugPrint("saved noti ----------> ${notificationModel.title})");
    }
  }

  NotificationModel? getNoti() {
    debugPrint("get noti data $title");

    return NotificationModel(title: title, body: body);
  }
}

class NotiList extends GetxController {
  RxBool error = false.obs;
  final notiList = <NotificationModel>[].obs;

  void addNotiList({required NotificationModel notification}) {
    debugPrint("add list is called");
    notiList.value.add(notification);
    debugPrint("-------");
    for (var noti in notiList) {
      debugPrint("added noti ${noti.title} ${noti.body}");
    }
    debugPrint("${notiList.length}");
    notiList.refresh();
  }

  @override
  void onInit() {
    PushNotificationService().requestPermission();
    PushNotificationService().getTokenFromFirebase();
    PushNotificationService().init();
    PushNotificationService().fetchApi();
    debugPrint("init successful");
    super.onInit();
  }

  void changeError() {
    error.value = !error.value;
    refresh();
  }

  // RxList<NotificationModel> get notiList => _notiList;
}
