import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/pages/paymentScreens/payment_method.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/pages/paymentScreens/screenWidgets/row_text.dart';
import 'package:double_date/pages/paymentScreens/screenWidgets/payment_cards.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    super.key,
    required this.isFromSubscription,
    this.cardHeading = 'Add 3 more friends',
  });

  final bool isFromSubscription;
  final String? cardHeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: isFromSubscription ? 'My Subscription' : 'Double Date Premium',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.55.sh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    25.verticalSpace,
                    PaymentDetailCard(
                      text1: isFromSubscription ? cardHeading : 'Add 3 More Friends',
                      text2: '20',
                    ),
                    24.verticalSpace,
                    Text(
                      'Payment Method',
                      style: interFont(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    24.verticalSpace,
                    PaymentVisaCard(
                      last4Digits: '1234',
                      onTap: () {
                        Get.to(() => const PaymentMethodScreen());
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
                width: 1.sw,
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
                child: const Column(
                  children: [
                    RowText(text1: 'Quantity', text2: '1'),
                    RowText(text1: 'Tax', text2: '\$0.5'),
                    RowText(
                      text1: 'Total',
                      text2: '\$15.5',
                      hideLine: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25),
        child: AppButton(
          text: 'CONTINUE',
          horizontalMargin: 0,
          onPress: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return BasicDialog(
                  heading: 'Purchase Successful',
                  bodyText: 'You have successfully purchased\n$cardHeading',
                  onTap: () {
                    final profileController = Get.put(ProfileController());
                    profileController.enablePremium();
                    Get.back();
                    Get.back();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
