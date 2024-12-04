// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/user_model.dart';
import 'package:double_date/pages/feedScreens/screenWidgtes/post_vdeo_player.dart';
import 'package:double_date/pages/settingScreens/shorts_bottomsheet.dart';
import 'package:double_date/repositories/auth_repository.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:double_date/utils/helpers.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:double_date/utils/validators.dart';
import 'package:double_date/widgets/app_button.dart';
import 'package:double_date/widgets/app_input.dart';
import 'package:double_date/widgets/back_button_appbar.dart';
import 'package:double_date/widgets/loader_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({
    super.key,
    required this.headingText,
    this.postId = '',
    this.isFromProfile = false,
  });

  final String headingText;
  final String? postId;
  final bool? isFromProfile;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final fc = Get.put(FeedController());
  final pc = Get.put(ProfileController());

  @override
  void dispose() {
    fc.clearPostImage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.headingText == 'Edit Post';
    return WillPopScope(
      onWillPop: () async {
        if (widget.isFromProfile!) {
          final res2 = await AuthRepository().autoLogin(context: context, showLoader: false);
          pc.saveUserDetails(
            UserModel.fromJson(
              res2['data']['user'],
            ),
          );
          fc.editfeedData = res2['data']['user']['posts'];
        } else {
          await fc.getFeeds(context: context);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: backButtonAppbar(
          title: widget.headingText,
          customOnBack: () async {
            if (widget.isFromProfile!) {
              final res2 = await AuthRepository().autoLogin(context: context, showLoader: false);
              pc.saveUserDetails(
                UserModel.fromJson(
                  res2['data']['user'],
                ),
              );
              fc.editfeedData = res2['data']['user']['posts'];
              Get.back();
            } else {
              await fc.getFeeds(context: context);
              Get.back();
            }
          },
          allowCustomOnBack: true,
        ),
        body: GetBuilder<FeedController>(
          builder: (controller) {
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
                  key: controller.feedFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.verticalSpace,
                      AppInput(
                        placeHolder: 'Title of post',
                        horizontalMargin: 0,
                        label: 'Title',
                        backColor: Colors.transparent,
                        controller: controller.titleController,
                        validator: (email) => titleValidator(email!),
                      ),
                      AppInput(
                        placeHolder: 'Post Description',
                        horizontalMargin: 0,
                        label: 'Write Description',
                        backColor: Colors.transparent,
                        maxLines: 10,
                        maxLenght: 500,
                        controller: controller.descriptionController,
                        validator: (email) => descriptionValidator(email!),
                      ),
                      5.verticalSpace,
                      Text(
                        'Add photos/videos:',
                        style: interFont(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      10.verticalSpace,
                      FittedBox(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                      ),
                                      child: ShortsBottomSheet(
                                        title: 'Select Media',
                                        firstButtonTitle: 'PHOTOS',
                                        secondButtonTitle: 'VIDEOS',
                                        onCameraTap: () {
                                          Navigator.pop(context);
                                          controller.pickPostImages(isFromEdit: isEdit);
                                        },
                                        onGalleryTap: () {
                                          Navigator.pop(context);
                                          controller.pickPostImages(isFromEdit: isEdit, isVideo: true);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: const Color(0xFFFF1472),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.plus,
                                  color: Color(0xFFFF1472),
                                ),
                              ),
                            ),
                            15.horizontalSpace,
                            SizedBox(
                              width: 0.72.sw,
                              height: 74,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    isEdit ? controller.editPostImages.length : controller.postImages!.length,
                                    (index) {
                                      return Stack(
                                        children: [
                                          Container(
                                            width: 72,
                                            height: 72,
                                            margin: const EdgeInsets.only(right: 15),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xFFFF1472),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: isEdit
                                                  ? containsHttpOrHttps(controller.editPostImages[index]['url'])
                                                      ? isVideoUrl(controller.editPostImages[index]['url'])
                                                          ? PostVideoPlayer(
                                                              url: controller.editPostImages[index]['url'],
                                                              isNetwork: true,
                                                              showControls: false,
                                                              width: 72,
                                                              height: 72,
                                                            )
                                                          : LoaderImage(
                                                              url: controller.editPostImages[index]['url'],
                                                              width: 72,
                                                              height: 72,
                                                            )
                                                      : isVideoUrl(controller.editPostImages[index]['url'])
                                                          ? PostVideoPlayer(
                                                              url: File(controller.editPostImages[index]['url']),
                                                              isNetwork: false,
                                                              showControls: false,
                                                              width: 72,
                                                              height: 72,
                                                            )
                                                          : Image.file(
                                                              File(controller.editPostImages[index]['url']),
                                                              width: 72,
                                                              height: 72,
                                                              fit: BoxFit.cover,
                                                            )
                                                  : isVideoUrl(controller.postImages![index].path)
                                                      ? PostVideoPlayer(
                                                          url: controller.postImages![index],
                                                          isNetwork: false,
                                                          showControls: false,
                                                          width: 72,
                                                          height: 72,
                                                        )
                                                      : Image.file(
                                                          controller.postImages![index],
                                                          width: 72,
                                                          height: 72,
                                                          fit: BoxFit.cover,
                                                        ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 12,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.removeSpecificeSelectedPostImage(
                                                  index: index,
                                                  isFromEdit: isEdit,
                                                );
                                              },
                                              child: SvgPicture.asset(imageCrossIcon),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      30.verticalSpace,
                      AppButton(
                        text: isEdit ? 'UPDATE' : 'POST',
                        horizontalMargin: 0,
                        onPress: () async {
                          isEdit
                              ? await controller.onEditPost(context: context, postId: widget.postId!)
                              : await controller.onCreatePost(context: context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
