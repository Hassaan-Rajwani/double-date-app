import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/group_detail_model.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardWithCheckbox extends StatefulWidget {
  const CardWithCheckbox({
    super.key,
    required this.data,
    required this.onChanged,
    this.showCheckBox = true,
  });

  final Participants data;
  final bool? showCheckBox;
  final void Function(bool?)? onChanged;

  @override
  State<CardWithCheckbox> createState() => _CardWithCheckboxState();
}

class _CardWithCheckboxState extends State<CardWithCheckbox> {
  final pc = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: modalBorder(width: 0.2),
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.transparent,
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
                    borderRadius: BorderRadius.circular(100)),
                child: LoaderImage(
                  url: data.profilePicture!,
                  width: 50,
                  height: 50,
                ),
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pc.user.value.name! == data.name! ? 'You' : data.name!,
                    style: interFont(
                      color: const Color(0xFFB1124C),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 0.35.sw,
                    child: Text(
                      data.gender!,
                      style: interFont(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (widget.showCheckBox!)
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink, width: 2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Checkbox(
                value: widget.data.isChecked,
                onChanged: widget.onChanged,
                checkColor: Colors.pink,
                activeColor: Colors.transparent,
              ),
            ),
        ],
      ),
    );
  }
}
