// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommentEmojiInput extends StatefulWidget {
  const CommentEmojiInput({
    super.key,
    required this.inputController,
    required this.onMedia,
    required this.onMessageSend,
    required this.focusNode,
  });

  final TextEditingController inputController;
  final VoidCallback onMedia;
  final VoidCallback onMessageSend;
  final FocusNode focusNode;

  @override
  State<CommentEmojiInput> createState() => _CommentEmojiInputState();
}

class _CommentEmojiInputState extends State<CommentEmojiInput> with WidgetsBindingObserver {
  final messageController = Get.put(MessageController());
  final fc = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      builder: (fc) {
        return GetBuilder<MessageController>(
          builder: (controller) {
            return Column(
              children: [
                AppInput(
                  focusNode: widget.focusNode,
                  placeHolder: 'Send your message..',
                  backColor: Colors.transparent,
                  controller: widget.inputController,
                  horizontalMargin: 20,
                  bottomMargin: 20,
                  maxLines: 5,
                  minLine: 1,
                  maxLenght: 1000,
                  prefixIcon: GestureDetector(
                    onTap: () {
                      if (controller.emojiShowing == false) {
                        controller.changeEmojiValue(true);
                      } else {
                        keyboardDismissle(context);
                        Future.delayed(const Duration(milliseconds: 300), () {
                          controller.changeEmojiValue(false);
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(emojiIcon),
                    ),
                  ),
                  postfixIcon: SizedBox(
                    width: 95,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            10.horizontalSpace,
                            GestureDetector(
                              onTap: widget.onMedia,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 10, 8, 10),
                                child: SvgPicture.asset(mediaIcon),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: widget.onMessageSend,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 10, 10, 10),
                            child: controller.sendLoader || fc.sendCommentLoader
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: const CircularProgressIndicator(
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
                Offstage(
                  offstage: controller.emojiShowing,
                  child: EmojiPicker(
                    textEditingController: widget.inputController,
                    config: Config(
                      height: 256,
                      checkPlatformCompatibility: true,
                      emojiViewConfig: EmojiViewConfig(
                        backgroundColor: const Color(0xFF22272B),
                        emojiSizeMax: 28 * (Platform.isIOS ? 1.2 : 1.0),
                      ),
                      swapCategoryAndBottomBar: false,
                      skinToneConfig: const SkinToneConfig(),
                      categoryViewConfig: const CategoryViewConfig(),
                      bottomActionBarConfig: const BottomActionBarConfig(
                        showBackspaceButton: false,
                        showSearchViewButton: false,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
