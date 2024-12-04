// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, use_build_context_synchronously
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/post_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SinglePost extends StatefulWidget {
  const SinglePost({super.key, required this.postId});

  final String postId;

  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  final fc = Get.put(FeedController());
  final pc = Get.put(ProfileController());
  final FocusNode _replyFocusNode = FocusNode();
  String commentId = '';

  @override
  void initState() {
    fc.getSinglePost(
      context: context,
      postId: widget.postId,
    );
    super.initState();
  }

  @override
  void dispose() {
    _replyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        fc.getFeeds(context: context);
        return true;
      },
      child: GetBuilder<FeedController>(
        builder: (fc) {
          final data = fc.singlePost;
          final user = pc.user.value;
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: backButtonAppbar(
              title: 'Social Post',
              customOnBack: () async {
                Get.back();
                await fc.getFeeds(context: context);
              },
              allowCustomOnBack: true,
            ),
            body: SingleChildScrollView(
              child: fc.singleLoader
                  ? Container()
                  : data.user == null
                      ? SizedBox(
                          width: 1.sw,
                          height: 1.sh,
                          child: Center(
                            child: Text(
                              'Post not found',
                              style: interFont(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            20.verticalSpace,
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(heartBg),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: PostCard(
                                index: 0,
                                isSinglePostView: true,
                                data: data,
                                showReportOption: data.user!.sId == user.sId,
                                onReplyComment: () {
                                  commentId = data.sId!;
                                  FocusScope.of(context).requestFocus(_replyFocusNode);
                                },
                              ),
                            ),
                          ],
                        ),
            ),
            bottomNavigationBar: SizedBox(
              height: 85.h,
              child: AppInput(
                controller: fc.commentPostController,
                placeHolder: 'Send your message..',
                focusNode: _replyFocusNode,
                borderRadius: 20,
                bottomMargin: 0,
                backColor: Colors.transparent,
                horizontalMargin: 20,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset(emojiIcon),
                ),
                postfixIcon: SizedBox(
                  width: 95,
                  child: Row(
                    children: [
                      10.horizontalSpace,
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 8, 10),
                          child: SvgPicture.asset(mediaIcon),
                        ),
                      ),
                      GestureDetector(
                        onTap: fc.sendCommentLoader
                            ? () {}
                            : () async {
                                if (commentId != '') {
                                  await fc.onReplyCommentPost(
                                    context: context,
                                    postId: widget.postId,
                                    commentId: commentId,
                                  );
                                  commentId = '';
                                  await fc.getSinglePost(
                                    context: context,
                                    postId: widget.postId,
                                  );
                                } else {
                                  await fc.onCommentPost(
                                    context: context,
                                    postId: widget.postId,
                                  );
                                  await fc.getSinglePost(
                                    context: context,
                                    postId: widget.postId,
                                  );
                                }
                              },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(8, 10, 10, 10),
                          child: fc.sendCommentLoader
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.pink,
                                  ),
                                )
                              : SvgPicture.asset(sendIcon),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
