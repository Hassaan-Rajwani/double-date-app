import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/pages/settingScreens/screenWidgets/report_post_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PostReportedList extends StatefulWidget {
  const PostReportedList({super.key});

  @override
  State<PostReportedList> createState() => _PostReportedListState();
}

class _PostReportedListState extends State<PostReportedList> {
  final sc = Get.put(SettingController());

  @override
  void initState() {
    sc.getReportPosts(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Post Reported List'),
      body: GetBuilder<SettingController>(
        builder: (sc) {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  20.verticalSpace,
                  sc.reportUserLoader
                      ? Container(
                          height: 0.8.sh,
                          alignment: Alignment.center,
                          child: spinkit,
                        )
                      : sc.reportedPostsList.isEmpty
                          ? Container(
                              height: 0.8.sh,
                              alignment: Alignment.center,
                              child: Text(
                                'No Posts Available',
                                style: interFont(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: sc.reportedPostsList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = sc.reportedPostsList[index];
                                return ReportedPostCard(
                                  dp: data.post!.user!.profilePicture!,
                                  nameAge: '${data.post!.user!.name!} ${calculateAge(
                                    data.post!.user!.dateofbirth!,
                                  )}',
                                  postMedia: data.post!.media!,
                                  postTime: timeAgo(time: data.createdAt!),
                                  caption: data.post!.title!,
                                  description: data.post!.description!,
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return BasicDialog(
                                          heading: 'Reason',
                                          bodyText: '${data.reason}\n${data.description}',
                                          onTap: () {},
                                          showButton: false,
                                          hideCrossIcon: false,
                                          bodyTextStyle: interFont(),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
