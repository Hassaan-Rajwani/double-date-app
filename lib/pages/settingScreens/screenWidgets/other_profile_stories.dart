import 'package:double_date/models/user_model.dart';
import 'package:double_date/pages/homeScreens/short_videos.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtherProfileStory extends StatefulWidget {
  const OtherProfileStory({super.key, required this.shorts});

  final List<Shorts> shorts;

  @override
  State<OtherProfileStory> createState() => _OtherProfileStoryState();
}

class _OtherProfileStoryState extends State<OtherProfileStory> {
  @override
  Widget build(BuildContext context) {
    final data = widget.shorts;
    return Column(
      children: [
        20.verticalSpace,
        if (data.isNotEmpty)
          SizedBox(
            width: 0.9.sw,
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final shortData = data[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ShortVideosScreen(
                        showEditOption: false,
                        currentIndexData: shortData,
                        shortsDataList: data,
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
  }
}
