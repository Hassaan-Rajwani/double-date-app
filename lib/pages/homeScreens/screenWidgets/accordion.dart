import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Accordion extends StatefulWidget {
  const Accordion({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF434343),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            onExpansionChanged: (value) {
              setState(() {
                expanded = value;
              });
            },
            trailing: SvgPicture.asset(expanded ? minusIcon : plusIcon),
            title: Text(
              widget.text1,
              style: interFont(
                color: const Color(0xFFB1124C),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.text2,
                  style: interFont(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
