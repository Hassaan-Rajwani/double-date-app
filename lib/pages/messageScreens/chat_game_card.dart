import 'package:flutter/material.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatGameCard extends StatelessWidget {
  const ChatGameCard({
    super.key,
    required this.userName,
    required this.msg,
    required this.msgTime,
    required this.isSender,
    this.msgType = '',
    this.questionData = '',
  });

  final String userName;
  final String msg;
  final String msgTime;
  final bool isSender;
  final String? msgType;
  final dynamic questionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 16,
        left: isSender ? 30 : 0,
        right: isSender ? 0 : 30,
      ),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: isSender
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
                    userName,
                    style: interFont(
                      color: isSender ? Colors.white : const Color(0xFFB1124C),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  5.verticalSpace,
                  if (msg != '')
                    Column(
                      children: [
                        Text(
                          msg,
                          style: interFont(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        12.verticalSpace,
                      ],
                    ),
                  Container(
                    width: 1.sw,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: msgType == 'knowMe'
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: questionData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  questionData[index]['question'],
                                  style: interFont(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          )
                        : msgType == 'ticTacToe'
                            ? Center(
                                child: Text(
                                  'Tic-Tac\nToe',
                                  style: interFont(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFB1124C),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Dirty Minds\nChallenge',
                                  style: interFont(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFB1124C),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              right: 16,
              child: Row(
                children: [
                  Text(
                    msgTime,
                    style: interFont(
                      color: isSender ? Colors.white : const Color(0xFFB1124C),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  8.horizontalSpace,
                  SvgPicture.asset(isSender ? tickSquareIcon2 : tickSquareIcon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
