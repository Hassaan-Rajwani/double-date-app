import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({
    super.key,
    required this.person1Name,
    required this.person2Name,
    required this.person1Image,
    required this.person2Image,
    required this.onHeartTap,
    required this.onImage1Tap,
    required this.onImage2Tap,
  });

  final String person1Name;
  final String person2Name;
  final String person1Image;
  final String person2Image;
  final VoidCallback onHeartTap;
  final VoidCallback onImage1Tap;
  final VoidCallback onImage2Tap;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 422,
      width: 422,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: const Color(0xFF93193A),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: widget.onImage1Tap,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26.r),
                      topRight: Radius.circular(26.r),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Color(0xFFFF1472),
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          LoaderImage(
                            url: widget.person1Image,
                            height: 200,
                            width: 1.sw,
                            borderRadius: 0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFFA31943),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(26),
                                bottomRight: Radius.circular(26),
                              ),
                            ),
                            child: Text(
                              widget.person1Name,
                              style: interFont(
                                fontSize: 15.8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onImage2Tap,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(26.r),
                      bottomRight: Radius.circular(26.r),
                    ),
                    child: Container(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          LoaderImage(
                            url: widget.person2Image,
                            height: 200,
                            width: 1.sw,
                            borderRadius: 0,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 20,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFFA31943),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(26),
                                  topRight: Radius.circular(26),
                                ),
                              ),
                              child: Text(
                                widget.person2Name,
                                style: interFont(
                                  fontSize: 15.8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: widget.onHeartTap,
              child: SvgPicture.asset(heartIcon),
            ),
          ],
        ),
      ),
    );
  }
}
