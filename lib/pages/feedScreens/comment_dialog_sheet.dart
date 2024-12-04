// ignore_for_file: deprecated_member_use
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/comment_card.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/comment_input.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/comment_shimmer.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentDialogSheet extends StatefulWidget {
  const CommentDialogSheet({
    super.key,
    required this.onMedia,
    required this.postId,
    this.isFromNotification,
  });

  final VoidCallback onMedia;
  final String postId;
  final bool? isFromNotification;

  @override
  State<CommentDialogSheet> createState() => _CommentDialogSheetState();
}

class _CommentDialogSheetState extends State<CommentDialogSheet> with WidgetsBindingObserver {
  final messageController = Get.put(MessageController());
  final fc = Get.put(FeedController());
  final sc = Get.put(SettingController());
  final FocusNode _replyFocusNode = FocusNode();
  String commentId = '';

  @override
  void initState() {
    fc.getPostComments(
      context: context,
      postId: widget.postId,
    );
    WidgetsBinding.instance.addObserver(this);
    _replyFocusNode.addListener(() {
      if (_replyFocusNode.hasFocus) {
        messageController.changeEmojiValue(true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    messageController.changeInChatRoomVal(false);
    WidgetsBinding.instance.removeObserver(this);
    _replyFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0.0;
    if (isKeyboardVisible) {
      messageController.changeEmojiValue(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (messageController.emojiShowing == true) {
          return true;
        } else {
          messageController.changeEmojiValue(true);
          return false;
        }
      },
      child: GetBuilder<FeedController>(
        builder: (controller) {
          return Container(
            height: 665,
            width: 1.sw,
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.r),
                topRight: Radius.circular(40.r),
              ),
              border: const Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 219, 89, 128),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 1.5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                20.verticalSpace,
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  width: 75.w,
                  height: 8,
                ),
                20.verticalSpace,
                Text(
                  'Comments',
                  style: interFont(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                ),
                16.verticalSpace,
                const Divider(
                  color: Colors.grey,
                ),
                16.verticalSpace,
                Expanded(
                  child: controller.commentShimmer
                      ? const CommentShimmerLoader()
                      : controller.commentList.isEmpty
                          ? Center(
                              child: Text(
                                'No Comments Available',
                                style: interFont(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(20),
                              child: ListView.builder(
                                itemCount: controller.commentList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final data = controller.commentList[index];
                                  return CommentCard(
                                    isFromNotification: widget.isFromNotification,
                                    commentData: data,
                                    replyList: data.replies!,
                                    onReply: () {
                                      commentId = data.sId!;
                                      FocusScope.of(context).requestFocus(_replyFocusNode);
                                    },
                                  );
                                },
                              ),
                            ),
                ),
                20.verticalSpace,
                CommentEmojiInput(
                  focusNode: _replyFocusNode,
                  inputController: controller.commentPostController,
                  onMedia: () async {
                    await controller.pickCommentImage(
                      context: context,
                      postId: widget.postId,
                      isFromReply: commentId != '',
                      commentId: commentId,
                    );
                  },
                  onMessageSend: controller.sendCommentLoader
                      ? () {}
                      : () async {
                          if (commentId != '') {
                            await controller.onReplyCommentPost(
                              context: context,
                              postId: widget.postId,
                              commentId: commentId,
                            );
                            commentId = '';
                          } else {
                            await controller.onCommentPost(
                              context: context,
                              postId: widget.postId,
                            );
                          }
                        },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
