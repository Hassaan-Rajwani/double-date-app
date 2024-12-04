import 'package:double_date/controllers/matched_controller.dart';
import 'package:double_date/models/like_sent_model.dart';
import 'package:double_date/pages/homeScreens/other_profile_details.dart';
import 'package:double_date/pages/matchedScreens/screenWidgets/matched_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MatchedLikeSentList extends StatefulWidget {
  const MatchedLikeSentList({
    super.key,
  });

  @override
  State<MatchedLikeSentList> createState() => _MatchedLikeSentListState();
}

class _MatchedLikeSentListState extends State<MatchedLikeSentList> {
  final mc = Get.put(MatchedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchedController>(
      builder: (controller) {
        return controller.likeSentData.isEmpty
            ? SizedBox(
                height: mc.likeFriendsData.isNotEmpty ? 0.5.sh : 0.7.sh,
                child: Center(
                  child: Text(
                    'No Like Sent',
                    style: interFont(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: (controller.likeSentData.length / 2).ceil(),
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
                        if (firstIndex < controller.likeSentData.length)
                          buildCard(
                            context: context,
                            data: controller.likeSentData[firstIndex].user!,
                          ),
                        10.horizontalSpace,
                        if (secondIndex < controller.likeSentData.length)
                          buildCard(
                            context: context,
                            data: controller.likeSentData[secondIndex].user!,
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
    required BuildContext context,
    required LikeUser data,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: MatchedCard(
        width: 0.41,
        matchCount: '0',
        nameAge: '${data.name!} & ${data.partner!.name!}',
        city: data.location!.address!,
        showAcceptDenyButton: false,
        onTap: () {
          mc.getPartnersData(context: context, id: data.sId!);
          Get.to(
            () => OtherProfileDetailScreen(
              showAcceptDenyButton: true,
              isFromMatched: true,
              showOtherOption: false,
              requestStatus: RequestStatus.Approved.name,
            ),
          );
        },
        image: data.profilePicture!,
      ),
    );
  }
}
