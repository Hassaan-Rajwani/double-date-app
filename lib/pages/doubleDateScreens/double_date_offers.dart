import 'package:double_date/controllers/double_date_controller.dart';
import 'package:double_date/controllers/schedule_double_date_controller.dart';
import 'package:double_date/pages/doubleDateScreens/double_date_detail.dart';
import 'package:double_date/pages/doubleDateScreens/screenWidgets/double_date_card.dart';
import 'package:double_date/pages/doubleDateScreens/screenWidgets/double_date_searchbar.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DoubleDateOffersScreen extends StatefulWidget {
  const DoubleDateOffersScreen({super.key});

  @override
  State<DoubleDateOffersScreen> createState() => _DoubleDateOffersScreenState();
}

class _DoubleDateOffersScreenState extends State<DoubleDateOffersScreen> {
  final dd = Get.put(DoubleDateController());
  final sc = Get.put(ScheduleDoubleDateCalendarController());

  @override
  void initState() {
    super.initState();
    dd.getOffersData(context: context);
    sc.retrieveCalendars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(title: 'Double Date Offers'),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(heartBg),
              fit: BoxFit.cover,
            ),
          ),
          child: GetBuilder<DoubleDateController>(
            builder: (dd) {
              return Column(
                children: [
                  const DoubleDateSearchBar(),
                  24.verticalSpace,
                  dd.offersLoader
                      ? Container(
                          alignment: Alignment.center,
                          height: 0.65.sh,
                          child: spinkit,
                        )
                      : dd.doubleDateOffers.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              height: 0.65.sh,
                              child: Text(
                                'No Offers Available',
                                style: interFont(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: dd.doubleDateOffers.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = dd.doubleDateOffers[index];
                                return DoubleDateCard(
                                  showSchedulerName: false,
                                  data: data,
                                  onTap: () {
                                    Get.to(
                                      () => DoubleDateDetailScreen(
                                        id: data.sId!,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
