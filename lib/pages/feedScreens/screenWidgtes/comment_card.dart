import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/models/post_model.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/icon_text.dart';
import 'package:double_date/pages/matchedScreens/report_user_dialog.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.onReply,
    required this.commentData,
    required this.replyList,
    this.isFromNotification,
  });

  final List<Replies> replyList;
  final VoidCallback onReply;
  final Comments commentData;
  final bool? isFromNotification;

  @override
  Widget build(BuildContext context) {
    final pc = Get.put(ProfileController());
    final sc = Get.put(SettingController());
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFFF1472),
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LoaderImage(
                        url: commentData.user!.profilePicture!,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commentData.user!.name!,
                        style: interFont(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFB1124C),
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        commentDateConverter(time: commentData.createdAt!),
                        style: interFont(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (commentData.user!.sId != pc.user.value.sId)
                CustomChip(
                  text: 'Report',
                  verticalPadding: 8,
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return ReportUserDialog(
                          heading: 'Report User',
                          onTap: () async {
                            await sc.onReportUser(
                              context: context,
                              userId: commentData.user!.sId!,
                              isFromNotification: isFromNotification,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
            ],
          ),
          8.verticalSpace,
          if (commentData.text != null)
            SizedBox(
              width: 0.7.sw,
              child: Text(
                commentData.text!,
                style: interFont(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
          if (commentData.picture != null)
            SizedBox(
              width: 0.7.sw,
              child: LoaderImage(
                url: commentData.picture!.mediaUrl!,
                height: 100,
                borderRadius: 10.r,
              ),
            ),
          8.verticalSpace,
          if (commentData.user!.sId != pc.user.value.sId)
            Row(
              children: [
                // GestureDetector(
                //   onTap: () {},
                //   child: const IconText(
                //     text: 'Like',
                //     textColor: Color(0xFFB1124C),
                //     isAppIcon: true,
                //     appIcon: Icon(
                //       FontAwesomeIcons.heart,
                //       color: Color(0xFFB1124C),
                //       size: 20,
                //     ),
                //   ),
                // ),
                // 20.horizontalSpace,
                GestureDetector(
                  onTap: onReply,
                  child: const IconText(
                    text: 'Reply',
                    textColor: Color(0xFFB1124C),
                    isAppIcon: true,
                    appIcon: Icon(
                      FontAwesomeIcons.share,
                      color: Color(0xFFB1124C),
                      size: 20,
                    ),
                  ),
                ),
              ],
            )
          else
            10.verticalSpace,
          // REPLY OF REPLY
          8.verticalSpace,
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: replyList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final replyData = replyList[index];
              return Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xFFFF1472),
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: LoaderImage(
                                  url: replyData.user!.profilePicture!,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                            8.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  replyData.user!.name!,
                                  style: interFont(
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFB1124C),
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  commentDateConverter(time: replyData.createdAt!),
                                  style: interFont(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (commentData.replies![index].user!.sId != pc.user.value.sId)
                          CustomChip(
                            text: 'Report',
                            verticalPadding: 8,
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return ReportUserDialog(
                                    heading: 'Report User',
                                    onTap: () async {
                                      await sc.onReportUser(
                                        context: context,
                                        userId: commentData.user!.sId!,
                                        isFromNotification: isFromNotification,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                      ],
                    ),
                    8.verticalSpace,
                    if (replyData.text != null)
                      SizedBox(
                        width: 0.7.sw,
                        child: Text(
                          replyData.text!,
                          style: interFont(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    if (replyData.picture != null)
                      SizedBox(
                        width: 0.7.sw,
                        child: LoaderImage(
                          url: replyData.picture!.mediaUrl!,
                          height: 100,
                          borderRadius: 10.r,
                        ),
                      ),
                    8.verticalSpace,
                    // if (commentData.replies![index].user!.sId != pc.user.value.sId)
                    //   GestureDetector(
                    //     onTap: () {},
                    //     child: const IconText(
                    //       text: 'Like',
                    //       textColor: Color(0xFFB1124C),
                    //       isAppIcon: true,
                    //       appIcon: Icon(
                    //         FontAwesomeIcons.heart,
                    //         color: Color(0xFFB1124C),
                    //         size: 20,
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
