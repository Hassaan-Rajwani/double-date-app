// ignore_for_file: use_build_context_synchronously
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/models/post_model.dart';
import 'package:double_date/pages/feedScreens/comment_dialog_sheet.dart';
import 'package:double_date/pages/feedScreens/create_posts.dart';
import 'package:double_date/pages/feedScreens/people_who_react.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/comment_card.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/icon_text.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/post_vdeo_player.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/reaction_box.dart';
import 'package:double_date/pages/feedScreens/share_activity_dialog.dart';
import 'package:double_date/pages/matchedScreens/report_user_dialog.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.index,
    required this.showReportOption,
    required this.data,
    this.blockUserOnTap,
    this.onReplyComment,
    this.isSinglePostView = false,
  });

  final int index;
  final VoidCallback? blockUserOnTap;
  final bool showReportOption;
  final bool? isSinglePostView;
  final PostModel data;
  final VoidCallback? onReplyComment;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final feedController = Get.put(FeedController());
  final sc = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      builder: (controller) {
        bool showPostOption = controller.showPostOptionIndex == widget.index;
        final data = widget.data;
        return Stack(
          children: [
            Container(
              width: 1.sw,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFFF1472),
                ),
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 100,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
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
                            child: LoaderImage(
                              url: data.user!.profilePicture!,
                              width: 48,
                              height: 48,
                            ),
                          ),
                          8.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data.user!.name!} ${calculateAge(
                                  data.user!.dateofbirth!,
                                )}',
                                style: interFont(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                timeAgo(time: data.createdAt!),
                                style: interFont(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showPostOption ? controller.hidePostOption() : controller.enablePostOption(widget.index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF161616),
                            borderRadius: BorderRadius.circular(8),
                            border: modalBorder(width: 0.5),
                          ),
                          child: SvgPicture.asset(threeDotsIcon),
                        ),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  SizedBox(
                    height: 163.h,
                    child: PageView.builder(
                      itemCount: data.media!.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            isVideoUrl(data.media![index].url!)
                                ? PostVideoPlayer(
                                    url: data.media![index].url!,
                                    isNetwork: true,
                                    showControls: true,
                                    width: 400,
                                    height: 163,
                                  )
                                : LoaderImage(
                                    url: data.media![index].url!,
                                    width: 1.sw,
                                    height: 163.h,
                                    borderRadius: 10.r,
                                  ),
                            if (data.media!.length > 1)
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(
                                      100.r,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${index + 1}/${data.media!.length}',
                                    style: interFont(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            reactBox(
                              data: data,
                              likeOnTap: () async {
                                await controller.onReact(
                                  isSinglePost: widget.isSinglePostView,
                                  postIndex: widget.index,
                                  postId: data.sId!,
                                  likeType: controller.likeType(0),
                                  alowChangeLikeType: false,
                                  context: context,
                                );
                              },
                              likeLongTap: (likeIndex) async {
                                await controller.onReact(
                                  isSinglePost: widget.isSinglePostView,
                                  postIndex: widget.index,
                                  postId: data.sId!,
                                  likeType: controller.likeType(likeIndex),
                                  alowChangeLikeType: true,
                                  context: context,
                                );
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                if (data.likes!.isNotEmpty) {
                                  Get.to(
                                    () => PeopleWhoReact(postId: data.sId!),
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: Text(
                                  "${data.likes!.length} Likes",
                                  style: interFont(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  child: CommentDialogSheet(
                                    onMedia: () {},
                                    postId: data.sId!,
                                    isFromNotification: widget.isSinglePostView,
                                  ),
                                );
                              },
                            );
                            // await controller.getFeeds(context: context);
                          },
                          child: IconText(
                            icon: commentIcon,
                            text: "${data.comments!.length} Comments",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return const ShareActivityDialog();
                              },
                            );
                          },
                          child: IconText(
                            icon: shareIcon,
                            text: '${data.share} Share',
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    data.title!,
                    style: interFont(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    data.description!,
                    style: interFont(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (widget.isSinglePostView!)
                    Column(
                      children: [
                        16.verticalSpace,
                        ListView.builder(
                          itemCount: data.comments!.length > 2 ? 2 : data.comments!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final dataa = data.comments![index];
                            return CommentCard(
                              commentData: dataa,
                              replyList: data.comments![index].replies!,
                              onReply: widget.onReplyComment!,
                              isFromNotification: widget.isSinglePostView,
                            );
                          },
                        )
                      ],
                    ),
                ],
              ),
            ),
            if (showPostOption)
              Positioned(
                right: 18,
                top: 55,
                child: Column(
                  children: [
                    10.verticalSpace,
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161616),
                        borderRadius: BorderRadius.circular(8),
                        border: modalBorder(width: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.showReportOption)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.hidePostOption();
                                    controller.saveEditPostData(index: widget.index);
                                    Get.to(
                                      () => CreatePost(
                                        headingText: 'Edit Post',
                                        postId: data.sId,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Edit Post',
                                    style: interFont(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                12.verticalSpace,
                                GestureDetector(
                                  onTap: () async {
                                    await controller.onDeletePost(
                                      context: context,
                                      postId: data.sId!,
                                      isFromNotification: widget.isSinglePostView,
                                    );
                                  },
                                  child: Text(
                                    'Delete Post',
                                    style: interFont(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (!widget.showReportOption)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.hidePostOption();
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return ReportUserDialog(
                                          heading: 'Report Post',
                                          onTap: () async {
                                            await sc.onReportPost(
                                              context: context,
                                              postId: data.sId!,
                                              isFromNotification: widget.isSinglePostView,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Report Post',
                                    style: interFont(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                12.verticalSpace,
                                GestureDetector(
                                  // onTap: widget.blockUserOnTap,
                                  onTap: () async {
                                    controller.hidePostOption();
                                    await sc.onBlockUser(
                                      context: context,
                                      userId: data.user!.sId!,
                                    );
                                  },
                                  child: Text(
                                    'Block User',
                                    style: interFont(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
