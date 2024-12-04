// ignore_for_file: deprecated_member_use
import 'package:double_date/models/doube_date_offer_model.dart';
import 'package:double_date/models/upcoming_date_model.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoubleDateCard extends StatelessWidget {
  const DoubleDateCard({
    super.key,
    required this.onTap,
    required this.showSchedulerName,
    required this.data,
    this.schedulerName,
  });

  final VoidCallback onTap;
  final bool showSchedulerName;
  final DoubleDateOfferModel data;
  final List<FriendsSubscribed>? schedulerName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 1.sw,
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: modalBorder(width: 0.2),
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFA8A8A8).withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showSchedulerName)
                  Column(
                    children: [
                      Container(
                        width: 1.sw,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                        decoration: BoxDecoration(
                          border: modalBorder(width: 0.2),
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFA8A8A8).withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          'Scheduled by ${schedulerName!.first.friendName}',
                          style: interFont(
                            color: const Color(0xFFB1124C),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      12.verticalSpace,
                    ],
                  ),
                Text(
                  data.name!.length > 20 ? data.name!.substring(0, 20) : data.name!,
                  style: interFont(
                    color: const Color(0xFFB1124C),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                12.verticalSpace,
                Row(
                  children: [
                    Text(
                      'Activity: ',
                      style: interFont(
                        color: const Color(0xFFB1124C),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      data.activity!,
                      style: interFont(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                Row(
                  children: [
                    Text(
                      'Location: ',
                      style: interFont(
                        color: const Color(0xFFB1124C),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      data.location!.address!,
                      style: interFont(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                if (data.detail != null)
                  Column(
                    children: [
                      Text(
                        data.detail!,
                        style: interFont(
                          fontSize: 12.0,
                        ),
                      ),
                      12.verticalSpace,
                    ],
                  ),
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
                          formatOffersDate(data.startTime!),
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
                          formatOffersTime(data.startTime!),
                          style: interFont(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: showSchedulerName ? 73 : 20,
            right: 20,
            child: Row(
              children: [
                if (data.discount != 0)
                  Text(
                    '\$${data.price}',
                    style: interFont(
                      color: const Color(0xFFB1124C),
                      fontSize: 12.0,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: const Color(0xFFB1124C),
                    ),
                  ),
                10.horizontalSpace,
                Text(
                  '\$${data.price! - data.discount!}',
                  style: interFont(
                    color: const Color(0xFFB1124C),
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
