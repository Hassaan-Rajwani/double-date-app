import 'package:double_date/models/report_post_model.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/post_vdeo_player.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportedPostCard extends StatelessWidget {
  const ReportedPostCard({
    super.key,
    required this.dp,
    required this.postMedia,
    required this.nameAge,
    required this.postTime,
    required this.caption,
    required this.description,
    required this.onTap,
  });

  final String dp;
  final List<Media> postMedia;
  final String nameAge;
  final String postTime;
  final String caption;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                        url: dp,
                        width: 48,
                        height: 48,
                      ),
                    ),
                    8.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameAge,
                          style: interFont(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          postTime,
                          style: interFont(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            12.verticalSpace,
            SizedBox(
              height: 163.h,
              child: PageView.builder(
                itemCount: postMedia.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      isVideoUrl(postMedia[index].url!)
                          ? PostVideoPlayer(
                              url: postMedia[index].url!,
                              isNetwork: true,
                              showControls: true,
                              width: 400,
                              height: 163,
                            )
                          : LoaderImage(
                              url: postMedia[index].url!,
                              width: 1.sw,
                              height: 163.h,
                              borderRadius: 10.r,
                            ),
                      if (postMedia.length > 1)
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
                              '${index + 1}/${postMedia.length}',
                              style: interFont(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            16.verticalSpace,
            Text(
              caption,
              style: interFont(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            8.verticalSpace,
            Text(
              description,
              style: interFont(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
