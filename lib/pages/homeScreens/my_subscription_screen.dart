import 'package:double_date/pages/homeScreens/screenWidgets/subscription_card.dart';
import 'package:double_date/pages/paymentScreens/payment_screen.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: 'My Subscription',
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
              20.verticalSpace,
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
