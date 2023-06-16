import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/push_notification_service.dart';
import 'package:untitled/models/notification_model.dart';
import 'package:untitled/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotiList notiList = Get.find();
    final CustomTheme theme = Get.find();

    TextEditingController title = TextEditingController();
    TextEditingController body = TextEditingController();
    debugPrint("------------------------- build -------------");
    return Scaffold(
      appBar: AppBar(
        leading: Obx(() {
          return IconButton(
            onPressed: () {
              // final ThemeData themeMode =
              //     theme.isDarkMode.value ? theme.darkColorScheme() : ThemeData.light();
              // theme.changeTheme();
              // Get.changeTheme(themeMode);
              theme.changeTheme();
            },
            icon: theme.isDarkMode.value
                ? const Icon(
                    Icons.dark_mode,
                    size: 30,
                  )
                : const Icon(
                    Icons.light_mode,
                    size: 30,
                  ),
          );
        }),
        title: const Text(
          "Test Push Notification",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              notiList.notiList.isEmpty
                  ? Card(
                      // color: Get.theme.colorScheme.primaryContainer,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      // shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "There is no notification in this moment",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: notiList.notiList.length,
                      itemBuilder: (context, index) {
                        debugPrint("item -------> ${notiList.notiList[index]}");
                        return Obx(() {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notiList.notiList[index].title ??
                                        "title fake",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                  Text(
                                    notiList.notiList[index].body ??
                                        "body fake",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    child: TextFormField(
                      controller: title,
                      decoration: const InputDecoration(
                        labelText: "Enter Notification Title",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    child: TextFormField(
                      controller: body,
                      decoration: const InputDecoration(
                        labelText: "Enter Notification Body",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  notiList.error.isTrue
                      ? Text(
                          "Title and Body fields are required",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        )
                      : Container(),
                  notiList.error.isTrue
                      ? const SizedBox(
                          height: 30,
                        )
                      : Container(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Theme.of(context).colorScheme.shadow,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary),
                    onPressed: () async {
                      final String? token =
                          await PushNotificationService().getToken();
                      if (token == null) throw Exception('Token is null');
                      if (title.text.isNotEmpty && body.text.isNotEmpty) {
                        debugPrint("clicked send");
                        notiList.changeError();

                        PushNotificationService().postApi(
                            token: token, title: title.text, body: body.text);
                      } else {
                        notiList.changeError();
                      }
                    },
                    child: const Text("Send"),
                  )
                ],
              ),
            ],
          );
        }),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   print(notiList.notiList.length);
      //   // notiList.addNotiList(
      //   //     notification: NotificationModel(body: "body", title: "title"));
      // }),
    );
  }
}

// @override
  // void initState() {
  //   onError = false;
  //   super.initState();
  //   PushNotificationService().requestPermission();
  //   PushNotificationService().getTokenFromFirebase();
  //   PushNotificationService().init();
  //   PushNotificationService().fetchApi();
  // }