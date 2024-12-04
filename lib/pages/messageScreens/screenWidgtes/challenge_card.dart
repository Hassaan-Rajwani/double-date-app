import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 24),
        width: 1.sw,
        decoration: BoxDecoration(
          border: modalBorder(width: 0.2),
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA8A8A8).withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          text,
          style: interFont(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            color: const Color(0xFF831136),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
