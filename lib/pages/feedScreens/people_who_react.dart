// ignore_for_file: deprecated_member_use
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/people_who_reacted_emoji_list.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PeopleWhoReact extends StatefulWidget {
  const PeopleWhoReact({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<PeopleWhoReact> createState() => _PeopleWhoReactState();
}

class _PeopleWhoReactState extends State<PeopleWhoReact> {
  final fc = Get.put(FeedController());

  @override
  void initState() {
    fc.getPostLikes(context: context, postId: widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'People who reacted'),
      body: GetBuilder<FeedController>(
        builder: (controller) {
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
              child: controller.likeList.isEmpty
                  ? Container()
                  : Column(
                      children: [
                        15.verticalSpace,
                        const PeopleWhoReactedEmojiList(),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
