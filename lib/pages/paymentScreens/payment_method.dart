import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/pages/paymentScreens/screenWidgets/payment_method_card.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:double_date/widgets/double_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void openDeleteDialog() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DoubleButtonDialog(
            onYes: () {
              Get.back();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return BasicDialog(
                    heading: 'Card Removed',
                    bodyText: 'Your Card has been deleted.',
                    buttonText: 'OK',
                    onTap: () {
                      Get.back();
                    },
                  );
                },
              );
            },
            onNo: () {
              Get.back();
            },
            heading: 'Delete Your Card',
            bodyText: 'Are you sure you want\nto delete your card?',
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: 'Payment Method',
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
              60.verticalSpace,
              PaymentMethodCard(
                onDelete: () {
                  openDeleteDialog();
                },
              ),
              24.verticalSpace,
              PaymentMethodCard(
                onDelete: () {
                  openDeleteDialog();
                },
              ),
              32.verticalSpace,
              AppButton(
                text: 'ADD PAYMENT METHOD',
                horizontalMargin: 0,
                onPress: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return BasicDialog(
                        heading: 'Card Added',
                        bodyText: 'Your Card has been added.',
                        buttonText: 'GO BACK',
                        onTap: () {
                          Get.back();
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
