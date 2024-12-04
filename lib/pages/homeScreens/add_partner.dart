import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/add_friend_card.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddPartnerScreen extends StatelessWidget {
  const AddPartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(),
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Watson wants to add you\nas a partner!',
                  style: interFont(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                24.verticalSpace,
                AddFriendsCard(
                  nameAge: 'Sarah David, 25',
                  city: 'Australia',
                  image: sarah3,
                  personMatch: '80',
                  relationShipStatus: 'Single',
                  orientation: 'Staright',
                  showButton: false,
                  fontSize: 26.0,
                  twoMoreFields: true,
                  allowTopPadding: true,
                  imageHeight: 295,
                  showNetworkImage: false,
                ),
                24.verticalSpace,
                const AppInput(
                  label: 'Paring Code',
                  placeHolder: 'Enter paring code here',
                  horizontalMargin: 0,
                ),
                10.verticalSpace,
                AppButton(
                  text: 'ADD',
                  horizontalMargin: 0,
                  onPress: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return BasicDialog(
                          heading: 'Partner Added',
                          bodyText: 'You have successfully added\nSarah as partner.',
                          onTap: () {
                            Get.back();
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
      ),
    );
  }
}
