import 'package:double_date/controllers/socket_controller.dart';
import 'package:double_date/controllers/support_controller.dart';
import 'package:double_date/pages/homeScreens/create_ticket.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/support_tickets.dart';
import 'package:double_date/pages/homeScreens/support_chat.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/chip.dart';
import 'package:double_date/widgets/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final sc = Get.put(SupportController());
  final socket = Get.put(SocketController());

  @override
  void initState() {
    socket.listenSupportList();
    socket.emitGetSupportList();
    super.initState();
  }

  @override
  void dispose() {
    sc.selectSupportButton('ALL TICKETS');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: 'Support Tickets',
        showSkipButton: true,
        showIconOnSkipArea: addIcon,
        onSkipTap: () {
          Get.to(() => const CreateTicketScreen());
        },
      ),
      body: GetBuilder<SupportController>(
        builder: (sc) {
          return SingleChildScrollView(
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
                  24.verticalSpace,
                  FittedBox(
                    child: Row(
                      children: List.generate(
                        sc.supportTicketButtonList.length,
                        (index) {
                          final List<String> data = sc.supportTicketButtonList;
                          final String selectedData = sc.supportTicketSelectedButton;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10, bottom: 20),
                            child: CustomChip(
                              horizontalPadding: 12,
                              verticalPadding: 12,
                              onTap: () {
                                sc.selectSupportButton(data[index]);
                              },
                              text: data[index],
                              fontSize: 11.0,
                              backgroundColor: selectedData == data[index] ? const Color(0xFFFF1472) : Colors.transparent,
                              borderColor: selectedData == data[index] ? Colors.transparent : Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  sc.supportLoader
                      ? Center(
                          child: spinkit,
                        )
                      : ListView.builder(
                          itemCount: sc.filteredTicketList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final data = sc.filteredTicketList[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => SupportChat(
                                      ticketId: data.sId!,
                                      status: data.status!,
                                    ));
                              },
                              child: SupportTickets(
                                data: data,
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
