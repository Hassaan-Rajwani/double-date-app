import 'package:double_date/pages/homeScreens/my_subscription_screen.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/subscription_card.dart';
import 'package:double_date/pages/paymentScreens/payment_screen.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: 'Subscription',
        showSkipButton: true,
        showIconOnSkipArea: permiumIcon,
        onSkipTap: () {
          Get.to(() => const MySubscriptionScreen());
        },
      ),
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
          child: Column(
            children: [
              14.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    bulbIcon,
                  ),
                  12.horizontalSpace,
                  Text(
                    'Buy our subscription to get\nmore features',
                    style: interFont(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: const Color(0xFFB1124C),
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard. Lorem Ipsum has been the industry\'s',
                style: interFont(
                  fontSize: 12.0,
                ),
              ),
              16.verticalSpace,
              SubscriptionCard(
                onTap: () {
                  Get.to(
                    () => const PaymentScreen(
                      isFromSubscription: true,
                      cardHeading: 'Unlimited swipes',
                    ),
                  );
                },
                heading: 'Unlimited swipes',
                text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has',
              ),
              SubscriptionCard(
                onTap: () {
                  Get.to(
                    () => const PaymentScreen(
                      isFromSubscription: true,
                      cardHeading: 'Profile boost',
                    ),
                  );
                },
                heading: 'Profile boost',
                text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has',
              ),
              SubscriptionCard(
                onTap: () {
                  Get.to(
                    () => const PaymentScreen(
                      isFromSubscription: true,
                      cardHeading: 'Add 3 more friends',
                    ),
                  );
                },
                heading: 'Add 3 more friends',
                text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
