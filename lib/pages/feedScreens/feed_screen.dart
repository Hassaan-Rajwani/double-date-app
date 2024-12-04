// ignore_for_file: use_build_context_synchronously
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/feedScreens/create_posts.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/post_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final fc = Get.put(FeedController());
  final pc = Get.put(ProfileController());

  @override
  void initState() {
    fc.getFeeds(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fc.hidePostOption();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: GetBuilder<FeedController>(
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              controller.hidePostOption();
            },
            child: Column(
              children: [
                5.verticalSpace,
                AppInput(
                  placeHolder: 'What\'s on your mind?',
                  horizontalMargin: 20,
                  verticalPadding: 0,
                  readOnly: true,
                  onInputTap: () {
                    controller.hidePostOption();
                    Get.to(
                      () => const CreatePost(
                        headingText: 'Create Post',
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 0.7.sh,
                  child: controller.feedLoader
                      ? spinkit
                      : controller.feedList.isEmpty
                          ? Center(
                              child: Text(
                                'No Posts Available',
                                style: interFont(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(heartBg),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.feedList.length,
                                  itemBuilder: (context, index) {
                                    final data = controller.feedList[index];
                                    final user = pc.user.value;
                                    return PostCard(
                                      index: index,
                                      isSinglePostView: false,
                                      data: data,
                                      showReportOption: data.user!.sId == user.sId,
                                    );
                                  },
                                ),
                              ),
                            ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
