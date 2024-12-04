import 'package:double_date/controllers/setting_controller.dart';
import 'package:double_date/pages/settingScreens/screenWidgets/block_user_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {
  final sc = Get.put(SettingController());

  @override
  void initState() {
    sc.getBlockedUsers(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Blocked Users'),
      body: GetBuilder<SettingController>(
        builder: (sc) {
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
                  20.verticalSpace,
                  sc.reportUserLoader
                      ? Container(
                          height: 0.8.sh,
                          alignment: Alignment.center,
                          child: spinkit,
                        )
                      : sc.blockedUsersList.isEmpty
                          ? Container(
                              height: 0.8.sh,
                              alignment: Alignment.center,
                              child: Text(
                                'No Users Available',
                                style: interFont(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: sc.blockedUsersList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = sc.blockedUsersList[index];
                                return BlockUserCard(
                                  dp: data.profilePicture!,
                                  userName: data.name!,
                                  onUnblockTap: () async {
                                    await sc.onUnblockUser(
                                      context: context,
                                      userId: data.sId!,
                                    );
                                  },
                                );
                              },
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
