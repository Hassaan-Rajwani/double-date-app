import 'package:double_date/controllers/message_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/message_model.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AcceptRejectCard extends StatefulWidget {
  const AcceptRejectCard({
    super.key,
    required this.userName,
    required this.msg,
    required this.msgTime,
    required this.image,
    required this.onAccept,
    required this.onReject,
    required this.title,
    required this.isSender,
    required this.status,
  });

  final String userName;
  final String msg;
  final String title;
  final String msgTime;
  final String image;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isSender;
  final List<IdeaPlanner> status;

  @override
  State<AcceptRejectCard> createState() => _AcceptRejectCardState();
}

class _AcceptRejectCardState extends State<AcceptRejectCard> {
  final messageController = Get.put(MessageController());
  final pc = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) {
        final fData = widget.status.where((element) => element.user!.sId == pc.user.value.sId).toList();
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 16,
                left: widget.isSender ? 30 : 0,
                right: widget.isSender ? 0 : 30,
              ),
              child: Align(
                alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          Text(
                            widget.title,
                            style: interFont(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          5.verticalSpace,
                          Text(
                            widget.msg,
                            style: interFont(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          8.verticalSpace,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              widget.image,
                              width: 1.sw,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          widget.isSender ? 38.verticalSpace : 8.verticalSpace,
                          if (widget.isSender == false)
                            if (fData[0].status == 'Pending')
                              Column(
                                children: [
                                  FittedBox(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AppButton(
                                          text: 'ACCEPT',
                                          minWidth: 150,
                                          horizontalMargin: 0,
                                          verticalMargin: 15,
                                          onPress: widget.onAccept,
                                        ),
                                        16.horizontalSpace,
                                        AppButton(
                                          text: 'REJECT',
                                          minWidth: 150,
                                          backgroundColor: Colors.transparent,
                                          isGradinet: false,
                                          borderColor: Colors.white,
                                          horizontalMargin: 0,
                                          verticalMargin: 15,
                                          onPress: widget.onReject,
                                        ),
                                      ],
                                    ),
                                  ),
                                  30.verticalSpace,
                                ],
                              )
                            else
                              SvgPicture.asset(
                                fData[0].status == 'Accepted' ? tickPinkSquareIcon : crossPinkSquareIcon,
                                width: 25,
                                height: 25,
                              ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 16,
                      child: Row(
                        children: [
                          Text(
                            widget.msgTime,
                            style: interFont(
                              color: widget.isSender ? Colors.white : const Color(0xFFB1124C),
                              fontSize: 12.0,
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
            ),
            if (widget.isSender)
              Positioned(
                left: widget.isSender ? 40 : 10,
                bottom: 22,
                child: SizedBox(
                  height: 35,
                  child: ListView.builder(
                    itemCount: widget.status.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = widget.status[index];
                      if (data.status != 'Pending') {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5),
                              height: 25,
                              width: 25,
                              child: LoaderImage(url: data.user!.profilePicture!),
                            ),
                            SvgPicture.asset(
                              data.status == 'Accepted' ? tickPinkSquareIcon : crossPinkSquareIcon,
                              width: 15,
                              height: 15,
                            )
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  Widget customCard() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 1,
            color: Colors.white,
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          sarah,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
