import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/pages/matchedScreens/like_profile.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MatchedScreen extends StatefulWidget {
  const MatchedScreen({super.key});

  @override
  State<MatchedScreen> createState() => _MatchedScreenState();
}

class _MatchedScreenState extends State<MatchedScreen> {
  final mc = Get.put(MatchedController());

  @override
  void initState() {
    mc.getMatchesList(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<MatchedController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(heartBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (mc.likeFriendsData.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace,
                        Text(
                          'Liked Friends',
                          style: interFont(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        10.verticalSpace,
                        SizedBox(
                          height: 55,
                          width: 1.sw,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mc.likeFriendsData.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final data = mc.likeFriendsData[index];
                              return GestureDetector(
                                onTap: () {
                                  mc.getPartnersData(context: context, id: data.sId!);
                                  Get.to(() => const LikeProfileScreen());
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: LoaderImage(
                                      url: '${data.profilePicture}',
                                      width: 55.w,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        15.verticalSpace,
                      ],
                    ),
                  Center(
                    child: FittedBox(
                      child: Row(
                        children: List.generate(
                          controller.matchedButtonList.length,
                          (index) {
                            final selectedIndex = controller.selectedIndex;
                            return Padding(
                              padding: EdgeInsets.only(right: 8, top: mc.likeFriendsData.isNotEmpty ? 0 : 15),
                              child: AppButton(
                                text: controller.matchedButtonList[index],
                                backgroundColor: index == selectedIndex ? const Color(0xFF93193A) : Colors.white,
                                textColor: index == selectedIndex ? Colors.white : Colors.black,
                                isGradinet: false,
                                horizontalMargin: 0,
                                minWidth: 100,
                                borderRadius: 10,
                                onPress: () async {
                                  await controller.updateIndex(index, context);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  controller.matchedLoader
                      ? SizedBox(
                          height: mc.likeFriendsData.isNotEmpty ? 0.5.sh : 0.7.sh,
                          child: spinkit,
                        )
                      : controller.matchedList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
