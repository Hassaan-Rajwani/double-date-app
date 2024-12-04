import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhoReactCard extends StatelessWidget {
  const WhoReactCard({
    super.key,
    required this.dp,
    required this.likeReaction,
    required this.name,
  });

  final String dp;
  final String likeReaction;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.pink,
                    ),
                    borderRadius: BorderRadius.circular(100)),
                child: LoaderImage(
                  url: dp,
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    likeReaction,
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            ],
          ),
          10.horizontalSpace,
          Text(
            name,
            style: interFont(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
