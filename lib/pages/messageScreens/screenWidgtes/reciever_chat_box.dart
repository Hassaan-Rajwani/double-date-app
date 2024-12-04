import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/chat_video.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecieverChatBox extends StatefulWidget {
  const RecieverChatBox({
    super.key,
    required this.userName,
    required this.msg,
    this.media,
    required this.msgType,
    required this.msgTime,
    required this.isSender,
    this.showSendTime = true,
  });

  final String userName;
  final String msg;
  final String? media;
  final String msgType;
  final String msgTime;
  final bool isSender;
  final bool? showSendTime;

  @override
  State<RecieverChatBox> createState() => _RecieverChatBoxState();
}

class _RecieverChatBoxState extends State<RecieverChatBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 16,
        left: widget.isSender ? 30 : 0,
        right: widget.isSender ? 0 : 30,
      ),
      child: Align(
        alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 150.w,
              ),
              child: DecoratedBox(
                decoration: widget.isSender
                    ? BoxDecoration(
                        color: const Color(0xFFB1124C),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.r),
                          bottomLeft: Radius.circular(20.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFA8A8A8).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      )
                    : BoxDecoration(
                        border: modalBorder(width: 0.2),
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFA8A8A8).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: interFont(
                          color: widget.isSender ? Colors.white : const Color(0xFFB1124C),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      5.verticalSpace,
                      if (widget.msgType == 'image')
                        LoaderImage(
                          url: widget.media!,
                          width: 200,
                          height: 200,
                          borderRadius: 20,
                        )
                      else if (widget.msgType == 'text')
                        Text(
                          widget.msg,
                          style: interFont(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      else
                        SizedBox(
                          width: 250,
                          height: 180,
                          child: ChatVideoPlayer(url: widget.media!),
                        ),
                      if (widget.showSendTime!) 30.verticalSpace else 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            if (widget.showSendTime!)
              Positioned(
                bottom: 12,
                right: 12,
                child: Row(
                  children: [
                    Text(
                      widget.msgTime,
                      style: interFont(
                        color: widget.isSender ? Colors.white : const Color(0xFFB1124C),
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    8.horizontalSpace,
                    SvgPicture.asset(widget.isSender ? tickSquareIcon2 : tickSquareIcon),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
