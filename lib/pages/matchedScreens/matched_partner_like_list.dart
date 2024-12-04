import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/models/partner_like_model.dart';
import 'package:double_date/pages/homeScreens/other_profile_details.dart';
import 'package:double_date/pages/matchedScreens/screenWidgets/matched_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MatchedPartnerLikeList extends StatefulWidget {
  const MatchedPartnerLikeList({
    super.key,
  });

  @override
  State<MatchedPartnerLikeList> createState() => _MatchedPartnerLikeListState();
}

class _MatchedPartnerLikeListState extends State<MatchedPartnerLikeList> {
  final matchedController = Get.put(MatchedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchedController>(
      builder: (controller) {
        return controller.partnerLikeData.isEmpty
            ? SizedBox(
                height: controller.likeFriendsData.isNotEmpty ? 0.5.sh : 0.7.sh,
                child: Center(
                  child: Text(
                    'No Partner Like',
                    style: interFont(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: (controller.partnerLikeData.length / 2).ceil(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final int firstIndex = index * 2;
                  final int secondIndex = firstIndex + 1;
                  return Container(
                    margin: EdgeInsets.only(left: 3.5.sp),
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (firstIndex < controller.partnerLikeData.length)
                          buildCard(
                            data: controller.partnerLikeData[firstIndex].recievedFrom!,
                            onAccept: () async {
                              await controller.onPartnerRespond(
                                context: context,
                                isAccept: true,
                                index: firstIndex,
                              );
                            },
                            onReject: () async {
                              await controller.onPartnerRespond(
                                context: context,
                                isAccept: false,
                                index: firstIndex,
                              );
                            },
                            status: controller.partnerLikeData[firstIndex].status!,
                            showAcceptDenyButton: controller.partnerLikeData[firstIndex].status == RequestStatus.Pending.name,
                            showSingleButton: controller.partnerLikeData[firstIndex].status != RequestStatus.Pending.name,
                          ),
                        10.horizontalSpace,
                        if (secondIndex < controller.partnerLikeData.length)
                          buildCard(
                            data: controller.partnerLikeData[secondIndex].recievedFrom!,
                            onAccept: () {
                              controller.onPartnerRespond(
                                context: context,
                                isAccept: true,
                                index: secondIndex,
                              );
                            },
                            onReject: () {
                              controller.onPartnerRespond(
                                context: context,
                                isAccept: false,
                                index: secondIndex,
                              );
                            },
                            status: controller.partnerLikeData[secondIndex].status!,
                            showAcceptDenyButton: controller.partnerLikeData[secondIndex].status == RequestStatus.Pending.name,
                            showSingleButton: controller.partnerLikeData[secondIndex].status != RequestStatus.Pending.name,
                          ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }

  Widget buildCard({
    required RecievedFrom data,
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
        matchedController.getPartnersData(context: context, id: data.sId!);
        Get.to(
          () => OtherProfileDetailScreen(
            showAcceptDenyButton: true,
            isFromMatched: true,
            showOtherOption: false,
            requestStatus: status,
          ),
        );
      },
    );
  }
}
