import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/models/chat_room_model.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    super.key,
    required this.onTap,
    required this.data,
  });

  final VoidCallback onTap;
  final ChatRoomModel data;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  final mc = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (mc) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              border: modalBorder(width: 0.2),
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFA8A8A8).withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.pink,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: LoaderImage(
                        url: widget.data.picture!,
                        width: 50,
                        height: 50,
                        borderRadius: 100,
                      ),
                    ),
                    12.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        5.verticalSpace,
                        SizedBox(
                          width: 0.5.sw,
                          child: Text(
                            // widget.data.isDisabled! ? 'Group Left' : widget.data.name!,
                            widget.data.name!,
                            style: interFont(
                              color: const Color(0xFFB1124C),
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 0.6.sw,
                          child: Text(
                            widget.data.isDisabled! ? 'Group Left' : widget.data.lastMessage!,
                            style: interFont(
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: -5,
                  right: 0,
                  child: Text(
                    formatTimeFromDate(widget.data.updatedAt!),
                    style: interFont(
                      fontSize: 12.0,
                    ),
                  ),
                ),
                if (widget.data.unreadMessagesCount != 0)
                  Positioned(
                    bottom: 10,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 10.sp,
                      child: Text(
                        '${widget.data.unreadMessagesCount}',
                        style: interFont(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
