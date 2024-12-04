import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/homeScreens/short_videos.dart';
import 'package:double_date/pages/settingScreens/shorts_bottomsheet.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileStory extends StatefulWidget {
  const ProfileStory({super.key});

  @override
  State<ProfileStory> createState() => _ProfileStoryState();
}

class _ProfileStoryState extends State<ProfileStory> {
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (pc) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: ShortsBottomSheet(
                        onCameraTap: () {
                          Navigator.pop(context);
                          pc.pickVideo(oepnCamera: true);
                        },
                        onGalleryTap: () {
                          Navigator.pop(context);
                          pc.pickVideo();
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  10,
                  pc.user.value.shorts!.isEmpty ? 10 : 0,
                  10,
                  pc.user.value.shorts!.isEmpty ? 10 : 0,
                ),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.pink,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.pink,
                ),
              ),
            ),
            if (pc.user.value.shorts!.isNotEmpty)
              SizedBox(
                width: 0.8.sw,
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pc.user.value.shorts!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final shortData = pc.user.value.shorts![index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ShortVideosScreen(
                            showEditOption: true,
                            currentIndexData: shortData,
                            shortsDataList: pc.user.value.shorts!,
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
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
                          const Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
