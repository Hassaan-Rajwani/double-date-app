// ignore_for_file: unused_local_variable, deprecated_member_use
import 'package:double_date/controllers/double_date_controller.dart';
import 'package:double_date/controllers/schedule_double_date_controller.dart';
import 'package:double_date/pages/doubleDateScreens/schedule_double_date.dart';
import 'package:double_date/pages/feedScreens/share_activity_dialog.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoubleDateDetailScreen extends StatefulWidget {
  const DoubleDateDetailScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<DoubleDateDetailScreen> createState() => _DoubleDateDetailScreenState();
}

class _DoubleDateDetailScreenState extends State<DoubleDateDetailScreen> {
  final dd = Get.put(DoubleDateController());
  final sc = Get.put(ScheduleDoubleDateCalendarController());

  @override
  void initState() {
    super.initState();
    dd.getSingleOffersData(
      context: context,
      offerId: widget.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        showSkipButton: true,
        skipButtonText: 'Share',
        onSkipTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const ShareActivityDialog();
            },
          );
        },
      ),
      body: GetBuilder<DoubleDateController>(
        builder: (dd) {
          final LatLng initialPosition = dd.singleOfferData.name == null
              ? const LatLng(0, 0)
              : LatLng(dd.singleOfferData.location!.coordinates![0], dd.singleOfferData.location!.coordinates![1]);
          late GoogleMapController mapController;

          final Set<Marker> markers = {
            Marker(
              markerId: const MarkerId('1'),
              position: initialPosition,
              infoWindow: InfoWindow(title: dd.singleOfferData.name == null ? '' : dd.singleOfferData.location!.address!),
            ),
          };
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
              child: dd.detailLoader
                  ? Container(
                      alignment: Alignment.center,
                      height: 0.65.sh,
                      child: spinkit,
                    )
                  : dd.singleOfferData.name == null
                      ? Container(
                          alignment: Alignment.center,
                          height: 0.65.sh,
                          child: Text(
                            'No Data Available',
                            style: interFont(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dd.singleOfferData.name!.length > 20 ? dd.singleOfferData.name!.substring(0, 20) : dd.singleOfferData.name!,
                                  style: interFont(
                                    color: const Color(0xFFB1124C),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (dd.singleOfferData.discount != 0)
                                      Text(
                                        '\$${dd.singleOfferData.price}',
                                        style: interFont(
                                          color: const Color(0xFFB1124C),
                                          fontSize: 12.0,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: const Color(0xFFB1124C),
                                        ),
                                      ),
                                    10.horizontalSpace,
                                    Text(
                                      '\$${dd.singleOfferData.price! - dd.singleOfferData.discount!}',
                                      style: interFont(
                                        color: const Color(0xFFB1124C),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            16.verticalSpace,
                            FittedBox(
                              child: Row(
                                children: [
                                  CustomChip(
                                    text: 'Valid: ${formatOffersDate(dd.singleOfferData.startTime!)}',
                                    horizontalPadding: 12,
                                    verticalPadding: 8,
                                    fontSize: 12,
                                  ),
                                  8.horizontalSpace,
                                  CustomChip(
                                    text: 'Activity: ${dd.singleOfferData.activity}',
                                    horizontalPadding: 12,
                                    verticalPadding: 8,
                                    fontSize: 12,
                                  ),
                                  8.horizontalSpace,
                                  const CustomChip(
                                    text: 'Rating 0.0',
                                    horizontalPadding: 12,
                                    verticalPadding: 8,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            16.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      calenderIcon,
                                      color: const Color(0xFFB1124C),
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      formatOffersDate(dd.singleOfferData.startTime!),
                                      style: interFont(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.clock,
                                      color: Color(0xFFB1124C),
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      '${formatOffersTime(dd.singleOfferData.startTime!)} to ${formatOffersTime(dd.singleOfferData.endTime!)}',
                                      style: interFont(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            16.verticalSpace,
                            if (dd.singleOfferData.detail != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details:',
                                    style: interFont(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    dd.singleOfferData.detail!,
                                    style: interFont(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  12.verticalSpace,
                                ],
                              ),
                            Text(
                              'Terms:',
                              style: interFont(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              dd.singleOfferData.terms!,
                              style: interFont(
                                fontSize: 12.0,
                              ),
                            ),
                            12.verticalSpace,
                            Text(
                              'Challenges:',
                              style: interFont(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            8.verticalSpace,
                            ListView.builder(
                              itemCount: dd.singleOfferData.challenges!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return dotText(text: dd.singleOfferData.challenges![index]);
                              },
                            ),
                            12.verticalSpace,
                            Text(
                              'Location:',
                              style: interFont(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            12.verticalSpace,
                            SizedBox(
                              width: 1.sw,
                              height: 205,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: GoogleMap(
                                  onMapCreated: (controller) {
                                    mapController = controller;
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: initialPosition,
                                    zoom: 14.0,
                                  ),
                                  markers: markers,
                                  scrollGesturesEnabled: false,
                                  zoomGesturesEnabled: false,
                                  rotateGesturesEnabled: false,
                                  tiltGesturesEnabled: false,
                                ),
                              ),
                            ),
                            30.verticalSpace,
                          ],
                        ),
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<DoubleDateController>(
        builder: (dd) {
          return dd.detailLoader
              ? Container()
              : dd.singleOfferData.name == null
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 70,
                      child: Column(
                        children: [
                          AppButton(
                            text: dd.singleOfferData.isSynced! ? 'CANCEL DATE' : 'SCHEDULE ACTIVITY',
                            horizontalMargin: 20,
                            onPress: () {
                              sc.selectOffer(data: dd.singleOfferData);
                              Future.delayed(const Duration(milliseconds: 300), () {
                                if (dd.singleOfferData.isSynced!) {
                                  sc.unSyncOfferWithApi(context: context, offerId: dd.singleOfferData.sId!);
                                } else {
                                  Get.to(
                                    () => const ScheduleDoubleDateScreen(),
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }

  Widget dotText({required String text}) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 3,
          backgroundColor: Colors.white,
        ),
        5.horizontalSpace,
        SizedBox(
          width: 0.85.sw,
          child: Text(
            text,
            style: interFont(
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );
  }
}
