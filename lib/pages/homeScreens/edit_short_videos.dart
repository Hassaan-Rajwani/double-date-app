// ignore_for_file: deprecated_member_use
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/user_model.dart';
import 'package:double_date/pages/homeScreens/screenWidgets/short_video_player.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditVideosScreen extends StatefulWidget {
  const EditVideosScreen({
    super.key,
    required this.isEdit,
    this.currentIndexData,
  });

  final bool isEdit;
  final Shorts? currentIndexData;

  @override
  State<EditVideosScreen> createState() => EditVideosScreenState();
}

class EditVideosScreenState extends State<EditVideosScreen> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    if (widget.currentIndexData != null) {
      final data = widget.currentIndexData;
      profileController.shortTitleController = TextEditingController(text: data!.title);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: backButtonAppbar(
        title: widget.isEdit ? 'Edit Short Videos' : 'Create Short Video',
        showSkipButton: widget.isEdit,
        showIconOnSkipArea: trashIcon,
        onSkipTap: () async {
          await profileController.onDeleteShort(
            context: context,
            shortId: widget.currentIndexData!.sId!,
          );
        },
      ),
      body: GetBuilder<ProfileController>(
        builder: (pc) {
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
              child: Form(
                key: pc.addShortFormKey,
                child: Column(
                  children: [
                    30.verticalSpace,
                    widget.isEdit
                        ? Container(
                            width: 300,
                            height: 300,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.pink,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pink.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 100,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: LoaderImage(
                              url: widget.currentIndexData!.media!.thumbnail!,
                              width: 300,
                              height: 300,
                              borderRadius: 10,
                            ),
                          )
                        // ShortVideoPlayer(
                        //     url: widget.currentIndexData!.media!.url,
                        //     title: '',
                        //     isNetwork: true,
                        //   )
                        : ShortVideoPlayer(
                            url: pc.shortVideo,
                            title: '',
                            isNetwork: false,
                          ),
                    30.verticalSpace,
                    AppInput(
                      label: widget.isEdit ? 'Edit Title' : 'Add Title',
                      placeHolder: 'Title of post',
                      horizontalMargin: 0,
                      controller: pc.shortTitleController,
                      validator: (title) => appValidator(title!),
                    ),
                    10.verticalSpace,
                    AppButton(
                      text: widget.isEdit ? 'UPDATE' : 'UPLOAD',
                      horizontalMargin: 0,
                      onPress: () async {
                        widget.isEdit
                            ? await pc.onCreateShort(
                                context: context,
                                isFromEdit: true,
                                shortId: widget.currentIndexData!.sId!,
                              )
                            : await pc.onCreateShort(
                                context: context,
                                isFromEdit: false,
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
