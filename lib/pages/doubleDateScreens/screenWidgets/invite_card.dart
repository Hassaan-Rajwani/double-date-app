import 'package:double_date/models/chat_room_model.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteCard extends StatelessWidget {
  const InviteCard({
    super.key,
    required this.onChanged,
    required this.data,
  });

  final ChatRoomModel data;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
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
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: LoaderImage(
                    url: data.picture!,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              12.horizontalSpace,
              SizedBox(
                width: 120.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name!,
                      style: interFont(
                        color: const Color(0xFFB1124C),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Group Chat',
                      style: interFont(
                        fontSize: 10.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.horizontalSpace,
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.pink, width: 2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Checkbox(
              value: data.isChecked,
              onChanged: onChanged,
              checkColor: Colors.pink,
              activeColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
