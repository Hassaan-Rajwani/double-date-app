import 'package:double_date/controllers/double_date_controller.dart';
import 'package:double_date/pages/doubleDateScreens/double_date_detail.dart';
import 'package:double_date/pages/doubleDateScreens/screenWidgets/double_date_card.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpcomingDoubleDateScreen extends StatefulWidget {
  const UpcomingDoubleDateScreen({super.key});

  @override
  State<UpcomingDoubleDateScreen> createState() => _UpcomingDoubleDateScreenState();
}

class _UpcomingDoubleDateScreenState extends State<UpcomingDoubleDateScreen> {
  final dd = Get.put(DoubleDateController());

  @override
  void initState() {
    dd.getUpcomgOffers(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Upcoming Double dates'),
      body: GetBuilder<DoubleDateController>(
        builder: (dd) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  14.verticalSpace,
                  Text(
                    'Tape on dates to check details',
                    style: interFont(
                      fontSize: 16.0,
                      color: const Color(0xFFB1124C),
                    ),
                  ),
                  24.verticalSpace,
                  dd.upcomingLoader
                      ? Container()
                      : dd.upcomingOffersList.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              height: 0.65.sh,
                              child: Text(
                                'No Upcoming Dates Available',
                                style: interFont(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: dd.upcomingOffersList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = dd.upcomingOffersList[index];
                                return DoubleDateCard(
                                  data: data.doubleDate!,
                                  showSchedulerName: true,
                                  schedulerName: data.friendsSubscribed,
                                  onTap: () {
                                    Get.to(
                                      () => DoubleDateDetailScreen(
                                        id: data.doubleDate!.sId!,
                                      ),
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
