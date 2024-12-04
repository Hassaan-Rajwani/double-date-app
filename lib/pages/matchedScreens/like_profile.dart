import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/pages/homeScreens/other_profile_details.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LikeProfileScreen extends StatefulWidget {
  const LikeProfileScreen({super.key});

  @override
  State<LikeProfileScreen> createState() => _LikeProfileScreenState();
}

class _LikeProfileScreenState extends State<LikeProfileScreen> {
  final mc = Get.put(MatchedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchedController>(
      builder: (controller) {
        dynamic userData;
        dynamic partnerData;
        if (mc.pairedUserData.user != null) {
          userData = mc.pairedUserData.user!;
          partnerData = mc.pairedUserData.user!.partner!.user!;
        }
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: backButtonAppbar(title: 'Liked Profile'),
          body: mc.pairedLoader
              ? Center(child: spinkit)
              : SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(heartBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
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
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      mc.getPartnersData(context: context, id: userData.sId!);
                                      Get.to(() => const OtherProfileDetailScreen(
                                            isFromMatched: true,
                                            showOtherOption: true,
                                          ));
                                    },
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
                                              url: userData.profilePicture!,
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
                                                userData.name!,
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
                                    onTap: () {
                                      mc.getPartnersData(context: context, id: partnerData.sId!);
                                      Get.to(() => const OtherProfileDetailScreen(
                                            isFromMatched: true,
                                            showOtherOption: true,
                                          ));
                                    },
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
                                              url: partnerData.profilePicture!,
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
                                                  partnerData.name!,
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
                            ),
                          ),
                          24.verticalSpace,
                          AppButton(
                            text: 'START CONVERSATION',
                            horizontalMargin: 0,
                            onPress: () async {
                              await controller.getConversationId(
                                context: context,
                                id: partnerData.sId!,
                              );
                              // Get.off(() => const ChatRoomScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
