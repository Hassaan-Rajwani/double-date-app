import 'package:double_date/models/ticket_model.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportTickets extends StatelessWidget {
  const SupportTickets({super.key, required this.data});

  final TicketsModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '#${data.sId!.substring(0, 3)}/Status ',
                    style: interFont(
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    data.status!,
                    style: interFont(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                ticketsDate(data.createdAt!),
                style: interFont(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          5.verticalSpace,
          const Divider(
            color: Color.fromARGB(255, 100, 100, 100),
          ),
          4.verticalSpace,
          Text(
            data.title!,
            style: interFont(
              fontWeight: FontWeight.w600,
              color: const Color(0xFFB1124C),
            ),
          ),
          6.verticalSpace,
          Text(
            data.description!,
            style: interFont(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
