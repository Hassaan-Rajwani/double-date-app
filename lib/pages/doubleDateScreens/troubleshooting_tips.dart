import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TroubleShootingTipsScreen extends StatelessWidget {
  const TroubleShootingTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(title: 'Troubleshooting Tips'),
      backgroundColor: Colors.black,
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
              14.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset(
                    bulbIcon,
                  ),
                  12.horizontalSpace,
                  Text(
                    'Help & guide for Double date app',
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
              28.verticalSpace,
              Text(
                '1. Help & guide for Double date app',
                style: interFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: const Color(0xFFB1124C),
                ),
              ),
              15.verticalSpace,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard. Lorem Ipsum has been the industry\'s',
                style: interFont(
                  fontSize: 12.0,
                ),
              ),
              28.verticalSpace,
              Text(
                '2. Help & guide for Double date app',
                style: interFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: const Color(0xFFB1124C),
                ),
              ),
              15.verticalSpace,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard. Lorem Ipsum has been the industry\'s',
                style: interFont(
                  fontSize: 12.0,
                ),
              ),
              28.verticalSpace,
              Text(
                '3. Help & guide for Double date app',
                style: interFont(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: const Color(0xFFB1124C),
                ),
              ),
              15.verticalSpace,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard. Lorem Ipsum has been the industry\'s',
                style: interFont(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
