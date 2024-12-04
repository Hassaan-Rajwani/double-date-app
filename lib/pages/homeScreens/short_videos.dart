import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/user_model.dart';
import 'package:double_date/pages/homeScreens/edit_short_videos.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/short_video_player.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShortVideosScreen extends StatefulWidget {
  const ShortVideosScreen({
    super.key,
    required this.showEditOption,
    required this.shortsDataList,
    required this.currentIndexData,
  });

  final bool showEditOption;
  final List<Shorts> shortsDataList;
  final Shorts currentIndexData;

  @override
  State<ShortVideosScreen> createState() => _ShortVideosScreenState();
}

class _ShortVideosScreenState extends State<ShortVideosScreen> {
  final pc = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    pc.currentIndexData = widget.currentIndexData;
    pc.shortsScrollController = ScrollController();
  }

  @override
  void dispose() {
    pc.shortsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: 'Short Videos',
        showSkipButton: widget.showEditOption,
        showIconOnSkipArea: editIcon,
        onSkipTap: () {
          Get.to(
            () => EditVideosScreen(
              isEdit: true,
              currentIndexData: widget.currentIndexData,
            ),
          );
        },
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  30.verticalSpace,
                  ShortVideoPlayer(
                    url: widget.currentIndexData.media!.url!,
                    title: widget.currentIndexData.title!,
                    isNetwork: true,
                  ),
                  30.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.6.sw,
                          height: 90,
                          child: ListView.builder(
                            controller: pc.shortsScrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.shortsDataList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final shortData = widget.shortsDataList[index];
                              return Column(
                                children: [
                                  if (shortData.media!.url != widget.currentIndexData.media!.url!)
                                    GestureDetector(
                                      onTap: () {
                                        if (widget.shortsDataList.length > 1) {
                                          pc.updateCurrentVideo(shortData);
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(right: 15),
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFFF1472),
                                            width: 1,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: LoaderImage(
                                            url: shortData.media!.thumbnail!,
                                            width: 55,
                                            height: 55,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        if (widget.shortsDataList.length > 4)
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 30,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                                size: 30.sp,
                              ),
                              onPressed: () {
                                pc.animateLeftOrRight(isRight: false);
                              },
                            ),
                          ),
                        if (widget.shortsDataList.length > 4)
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 30,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 30.sp,
                              ),
                              onPressed: () {
                                pc.animateLeftOrRight(isRight: true);
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
