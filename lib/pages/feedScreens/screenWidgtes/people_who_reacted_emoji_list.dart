import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/who_react_card.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PeopleWhoReactedEmojiList extends StatefulWidget {
  const PeopleWhoReactedEmojiList({super.key});

  @override
  State<PeopleWhoReactedEmojiList> createState() => _PeopleWhoReactedEmojiListState();
}

class _PeopleWhoReactedEmojiListState extends State<PeopleWhoReactedEmojiList> {
  final fc = Get.put(FeedController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      builder: (controller) {
        final reactions = controller.groupedLikes;
        return Column(
          children: [
            Row(
              children: [
                CustomChip(
                  text: 'All ${controller.likeList.length}',
                  verticalPadding: 8,
                  onTap: () {
                    controller.onTypeSelected('');
                  },
                ),
                4.horizontalSpace,
                ...reactions.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CustomChip(
                      onTap: () {
                        controller.onTypeSelected(entry.key);
                      },
                      text: '${entry.value}',
                      showIcon: true,
                      backgroundColor: Colors.transparent,
                      borderColor: Colors.white,
                      icon: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          controller.reactionIcon(entry.key),
                          width: 20,
                        ),
                      ),
                      verticalPadding: 8,
                    ),
                  );
                }),
              ],
            ),
            24.verticalSpace,
            SizedBox(
              height: 0.75.sh,
              child: ListView.builder(
                itemCount: controller.filteredLikeList.length,
                itemBuilder: (context, index) {
                  var like = controller.filteredLikeList[index];
                  return WhoReactCard(
                    dp: like.user!.profilePicture!,
                    likeReaction: controller.reactionIcon(like.type!),
                    name: like.user!.name!,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
