import 'package:double_date/controllers/notification_controller.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/notification_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final nc = Get.put(NotificationController());

  @override
  void initState() {
    nc.getNotificationList(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: 'Notifications',
      ),
      body: GetBuilder<NotificationController>(
        builder: (nc) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(heartBg),
                fit: BoxFit.cover,
              ),
            ),
            child: nc.isLoading
                ? spinkit
                : nc.notificationList.isEmpty
                    ? Center(
                        child: Text(
                          'No Notifications Available',
                          style: interFont(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: nc.notificationList.length,
                        itemBuilder: (context, index) {
                          final data = nc.notificationList[index];
                          return NotificationCard(
                            onTap: () async {
                              await nc.onRoute(
                                title: data.title!,
                                id: data.route!,
                                context: context,
                              );
                            },
                            onDelete: () async {
                              nc.deleteNotification(
                                context: context,
                                id: data.sId!,
                              );
                            },
                            title: data.title!,
                            bodyTitle: data.description!,
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
