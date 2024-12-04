import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlockUserCard extends StatelessWidget {
  const BlockUserCard({
    super.key,
    required this.dp,
    required this.userName,
    this.onUnblockTap,
    this.onTap,
    this.showUnblockButton = true,
  });

  final String dp;
  final String userName;
  final VoidCallback? onUnblockTap;
  final bool? showUnblockButton;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          border: modalBorder(width: 0.2),
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA8A8A8).withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.pink,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: LoaderImage(
                    url: dp,
                    width: 50,
                    height: 50,
                  ),
                ),
                12.horizontalSpace,
                Text(
                  userName,
                  style: interFont(
                    color: const Color(0xFFB1124C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (showUnblockButton!)
              CustomChip(
                text: 'Unblock',
                backgroundColor: Colors.transparent,
                borderColor: const Color(0xFFFF1472),
                textColor: const Color(0xFFFF1472),
                verticalPadding: 8.5,
                horizontalPadding: 15,
                onTap: onUnblockTap,
              )
          ],
        ),
      ),
    );
  }
}
