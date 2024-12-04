import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/like_recieved_model.dart';
import 'package:double_date/pages/homeScreens/other_profile_details.dart';
import 'package:double_date/pages/matchedScreens/screenWidgets/matched_card.dart';
import 'package:double_date/pages/paymentScreens/double_date_premium_dialog.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class MatchedLikeReceivedList extends StatefulWidget {
  const MatchedLikeReceivedList({
    super.key,
  });

  @override
  State<MatchedLikeReceivedList> createState() => _MatchedLikeReceivedListState();
}

class _MatchedLikeReceivedListState extends State<MatchedLikeReceivedList> {
  final profileController = Get.put(ProfileController());
  final mc = Get.put(MatchedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchedController>(
      builder: (controller) {
        return GetBuilder<ProfileController>(
          builder: (pc) {
            return controller.likeReceivedData.isEmpty
                ? SizedBox(
                    height: mc.likeFriendsData.isNotEmpty ? 0.5.sh : 0.7.sh,
                    child: Center(
                      child: Text(
                        'No Like Received',
                        style: interFont(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      ListView.builder(
                        itemCount: (controller.likeReceivedData.length / 2).ceil(),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final int firstIndex = index * 2;
                          final int secondIndex = firstIndex + 1;
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            margin: EdgeInsets.only(left: 3.5.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (firstIndex < controller.likeReceivedData.length)
                                  buildCard(
                                    data: controller.likeReceivedData[firstIndex].user!,
                                    onAccept: () async {
                                      await controller.onRespondRequest(
                                        context: context,
                                        isAccept: true,
                                        index: firstIndex,
                                      );
                                    },
                                    onReject: () async {
                                      await controller.onRespondRequest(
                                        context: context,
                                        isAccept: false,
                                        index: firstIndex,
                                      );
                                    },
                                    status: controller.likeReceivedData[firstIndex].status!,
                                    showAcceptDenyButton: controller.likeReceivedData[firstIndex].status == RequestStatus.Pending.name,
                                    showSingleButton: controller.likeReceivedData[firstIndex].status != RequestStatus.Pending.name,
                                  ),
                                10.horizontalSpace,
                                if (secondIndex < controller.likeReceivedData.length)
                                  buildCard(
                                    data: controller.likeReceivedData[secondIndex].user!,
                                    onAccept: () async {
                                      await controller.onRespondRequest(
                                        context: context,
                                        isAccept: true,
                                        index: secondIndex,
                                      );
                                    },
                                    onReject: () async {
                                      await controller.onRespondRequest(
                                        context: context,
                                        isAccept: false,
                                        index: secondIndex,
                                      );
                                    },
                                    status: controller.likeReceivedData[secondIndex].status!,
                                    showAcceptDenyButton: controller.likeReceivedData[secondIndex].status == RequestStatus.Pending.name,
                                    showSingleButton: controller.likeReceivedData[secondIndex].status != RequestStatus.Pending.name,
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                      if (!pc.premiumPurchased)
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return const DoubleDatePremiumDialog();
                              },
                            );
                          },
                          child: GlassContainer(
                            border: Border.all(
                              color: Colors.transparent,
                              width: 0,
                            ),
                            child: Container(
                              width: 1.sw,
                              height: 0.7.sh,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        )
                    ],
                  );
          },
        );
      },
    );
  }

  Widget buildCard({
    required RecievedUser data,
    required VoidCallback onAccept,
    required VoidCallback onReject,
    required String status,
    bool? showAcceptDenyButton = true,
    bool? showSingleButton = false,
  }) {
    return MatchedCard(
      width: 0.41,
      matchCount: '0',
      nameAge: '${data.name} & ${data.partner!.name!}',
      city: data.location!.address!,
      showAcceptDenyButton: showAcceptDenyButton,
      showSingleButton: showSingleButton,
      singleButtonText: status,
      onAccept: onAccept,
      onDeny: onReject,
      image: data.profilePicture,
      onTap: () {
        mc.getPartnersData(context: context, id: data.sId!);
        Get.to(
          () => OtherProfileDetailScreen(
            showAcceptDenyButton: true,
            isFromMatched: true,
            showOtherOption: false,
            requestStatus: status,
            isFrom: 'Like Recieved',
          ),
        );
      },
    );
  }
}
