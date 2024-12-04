// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/post_model.dart';
import 'package:double_date/models/user_model.dart';
import 'package:double_date/repositories/auth_repository.dart';
import 'package:double_date/repositories/feed_repository.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/widgets/basic_dialog.dart';
import 'package:double_date/widgets/double_button_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FeedController extends GetxController {
  final ImagePicker picker = ImagePicker();
  int? showPostOptionIndex;
  List<File>? postImages = [];
  List editPostImages = [];
  List deletedImagesIds = [];
  int whoReacedListIndex = 0;
  bool feedLoader = false;
  bool singleLoader = false;
  bool commentShimmer = false;
  bool sendCommentLoader = false;
  List<PostModel> feedList = [];
  PostModel singlePost = PostModel();
  List<Likes> likeList = [];
  List<Comments> commentList = [];
  List<Likes> filteredLikeList = [];
  var editfeedData = [];
  final feedFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController commentPostController = TextEditingController();
  final pc = Get.put(ProfileController());

  pickCommentImage({
    required BuildContext context,
    required String postId,
    required String? commentId,
    required bool isFromReply,
  }) async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      update();
      if (isFromReply) {
        await onReplyCommentPost(
          context: context,
          postId: postId,
          commentId: commentId!,
          image: File(file.path),
        );
      } else {
        await onCommentPost(
          context: context,
          postId: postId,
          image: File(file.path),
        );
      }
    }
  }

  changeSingleLoader(val) {
    singleLoader = val;
    // update();
  }

  saveEditPostData({required int index}) {
    final data = editfeedData[index];
    titleController = TextEditingController(text: data['title']);
    descriptionController = TextEditingController(text: data['description']);
    editPostImages = data['media'];
    update();
  }

  savePostData({required List<PostModel> postData}) {
    feedList.clear();
    feedList = postData;
    update();
  }

  saveLikeData({required List<Likes> likeData}) {
    likeList = likeData;
    update();
  }

  saveCommentData({required List<Comments> commentData}) {
    commentList = commentData;
    update();
  }

  changeLoaderValue(value) {
    feedLoader = value;
    update();
  }

  void enablePostOption(int index) {
    showPostOptionIndex = index;
    update();
  }

  void hidePostOption() {
    showPostOptionIndex = null;
    update();
  }

  pickPostImages({bool isVideo = false, required bool isFromEdit}) async {
    List<XFile>? files;
    files = isVideo ? await picker.pickMultipleMedia() : await picker.pickMultiImage();
    if (files.isNotEmpty) {
      for (var file in files) {
        if (isFromEdit) {
          editPostImages.add({'url': file.path, '_id': 'no'});
        } else {
          postImages!.add(File(file.path));
        }
      }
      update();
    }
  }

  removeSpecificeSelectedPostImage({
    required int index,
    required isFromEdit,
  }) {
    if (isFromEdit) {
      if (editPostImages[index]['_id'] != 'no') {
        deletedImagesIds.add(editPostImages[index]['_id']);
        editPostImages.removeAt(index);
        update();
      } else {
        editPostImages.removeAt(index);
        update();
      }
    } else {
      postImages!.removeAt(index);
      update();
    }
  }

  clearPostImage() {
    postImages!.clear();
    titleController.clear();
    descriptionController.clear();
    deletedImagesIds.clear();
    update();
  }

  onReact({
    required int postIndex,
    required String postId,
    required String likeType,
    required bool alowChangeLikeType,
    required BuildContext context,
    bool? isSinglePost = false,
  }) async {
    if (isSinglePost == true) {
      if (singlePost.likedByOwn!.type == null) {
        singlePost.likedByOwn!.type = likeType;
        singlePost.likes!.add(Likes());
        update();
        await onLikePost(
          context: context,
          likeType: likeType,
          postId: postId,
        );
      } else if (alowChangeLikeType) {
        singlePost.likedByOwn!.type = likeType;
        update();
        await onLikePost(
          context: context,
          likeType: likeType,
          postId: postId,
        );
      } else {
        singlePost.likedByOwn!.type = null;
        singlePost.likes!.length = singlePost.likes!.length - 1;
        update();
        await onLikePost(
          context: context,
          likeType: null,
          postId: postId,
        );
      }
      update();
    } else {
      if (feedList[postIndex].likedByOwn!.type == null) {
        feedList[postIndex].likedByOwn!.type = likeType;
        feedList[postIndex].likes!.add(Likes());
        update();
        await onLikePost(
          context: context,
          likeType: likeType,
          postId: postId,
        );
      } else if (alowChangeLikeType) {
        feedList[postIndex].likedByOwn!.type = likeType;
        update();
        await onLikePost(
          context: context,
          likeType: likeType,
          postId: postId,
        );
      } else {
        feedList[postIndex].likedByOwn!.type = null;
        feedList[postIndex].likes!.length = feedList[postIndex].likes!.length - 1;
        update();
        await onLikePost(
          context: context,
          likeType: null,
          postId: postId,
        );
      }
      update();
    }
  }

  onReactFromProfile({
    required int postIndex,
    required String postId,
    required String likeType,
    required bool alowChangeLikeType,
    required BuildContext context,
  }) async {
    if (pc.user.value.posts![postIndex].likedByOwn!.type == null) {
      pc.user.value.posts![postIndex].likedByOwn!.type = likeType;
      pc.user.value.posts![postIndex].likes!.add(Likes());
      update();
      await onLikePost(
        context: context,
        likeType: likeType,
        postId: postId,
      );
    } else if (alowChangeLikeType) {
      pc.user.value.posts![postIndex].likedByOwn!.type = likeType;
      update();
      await onLikePost(
        context: context,
        likeType: likeType,
        postId: postId,
      );
    } else {
      pc.user.value.posts![postIndex].likedByOwn!.type = null;
      pc.user.value.posts![postIndex].likes!.length = pc.user.value.posts![postIndex].likes!.length - 1;
      update();
      await onLikePost(
        context: context,
        likeType: null,
        postId: postId,
      );
    }
    update();
  }

  String likeType(int type) {
    switch (type) {
      case 0:
        return 'like';
      case 1:
        return 'love';
      case 2:
        return 'haha';
      case 3:
        return 'wow';
      case 4:
        return 'sad';
      case 5:
        return 'angry';
      default:
        return 'like';
    }
  }

  String reactionIcon(String type) {
    switch (type) {
      case 'like':
        return likeEmoji;
      case 'love':
        return heartEmoji;
      case 'haha':
        return laughEmoji;
      case 'wow':
        return shockEmoji;
      case 'sad':
        return sadEmoji;
      case 'angry':
        return angryEmoji;
      default:
        return likeEmoji;
    }
  }

  updataWhoReacedListIndex(index) {
    whoReacedListIndex = index;
    update();
  }

  getFeeds({required BuildContext context}) async {
    changeLoaderValue(true);
    final res = await FeedRepository().getFeeds(context: context);
    if (res != null && res['data'] != null) {
      changeLoaderValue(false);
      editfeedData = res['data'];
      savePostData(
        postData: List.from(
          res['data'].map((item) => PostModel.fromJson(item)).toList(),
        ),
      );
      update();
    } else {
      changeLoaderValue(false);
    }
  }

  getSinglePost({
    required BuildContext context,
    required String postId,
  }) async {
    changeSingleLoader(true);
    singlePost = PostModel();
    final res = await FeedRepository().getSinglePost(
      context: context,
      postId: postId,
    );
    if (res != null && res['data'] != null) {
      changeSingleLoader(false);
      singlePost = PostModel.fromJson(res['data']);
      update();
    } else {
      singlePost = PostModel();
      update();
      changeSingleLoader(false);
    }
  }

  onCreatePost({required BuildContext context}) async {
    if (feedFormKey.currentState != null && feedFormKey.currentState!.validate()) {
      if (postImages!.isNotEmpty) {
        final body = {
          'title': titleController.value.text,
          'description': descriptionController.value.text,
        };
        final res = await FeedRepository().createPost(
          context: context,
          body: body,
          fileKey: 'posts',
          multipleFile: postImages,
        );
        if (res != null && res['data'] != null) {
          await getFeeds(context: context);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return BasicDialog(
                heading: 'Post Created',
                bodyText: 'Your post has been created',
                onTap: () {
                  Get.close(2);
                  clearPostImage();
                },
              );
            },
          );
          final res2 = await AuthRepository().autoLogin(context: context, showLoader: false);
          final fc = Get.put(FeedController());
          pc.saveUserDetails(
            UserModel.fromJson(
              res2['data']['user'],
            ),
          );
          fc.editfeedData = res2['data']['user']['posts'];
        }
      } else {
        Get.snackbar(
          'Error',
          'Please Select Image',
          backgroundColor: Colors.white,
        );
      }
    }
  }

  onEditPost({required BuildContext context, required String postId}) async {
    if (feedFormKey.currentState != null && feedFormKey.currentState!.validate()) {
      if (editPostImages.isNotEmpty) {
        final body = {
          'title': titleController.value.text,
          'description': descriptionController.value.text,
        };
        for (var i = 0; i < deletedImagesIds.length; i++) {
          body["removeIds[$i]"] = deletedImagesIds[i];
          update();
        }
        final res = await FeedRepository().updatePost(
          postId: postId,
          context: context,
          body: body,
          fileKey: 'posts',
          multipleFile: editPostImages,
        );
        if (res != null && res['data'] != null) {
          await getFeeds(context: context);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return BasicDialog(
                heading: 'Post Updated',
                bodyText: 'Your Post has been Updated.',
                onTap: () {
                  Get.close(2);
                  clearPostImage();
                },
              );
            },
          );
          final res2 = await AuthRepository().autoLogin(context: context, showLoader: false);
          final fc = Get.put(FeedController());
          pc.saveUserDetails(
            UserModel.fromJson(
              res2['data']['user'],
            ),
          );
          fc.editfeedData = res2['data']['user']['posts'];
        }
      } else {
        Get.snackbar(
          'Error',
          'Please Select Image',
          backgroundColor: Colors.white,
        );
      }
    }
  }

  onLikePost({
    required BuildContext context,
    required String? likeType,
    required String postId,
  }) async {
    final body = {"type": likeType};
    await FeedRepository().likePost(
      context: context,
      body: body,
      postId: postId,
    );
  }

  getPostLikes({
    required BuildContext context,
    required String postId,
  }) async {
    likeList.clear();
    final res = await FeedRepository().getPostLikes(
      context: context,
      postId: postId,
    );
    if (res != null && res['data'] != null) {
      saveLikeData(
        likeData: List.from(
          res['data']['likes'].map((item) => Likes.fromJson(item)).toList(),
        ),
      );
      filteredLikeList = likeList;
      update();
    }
  }

  getPostComments({
    required BuildContext context,
    required String postId,
  }) async {
    commentShimmer = true;
    final res = await FeedRepository().getPostComments(
      context: context,
      postId: postId,
    );
    if (res != null && res['data'] != null) {
      commentShimmer = false;
      saveCommentData(
        commentData: List.from(
          res['data']['comments'].map((item) => Comments.fromJson(item)).toList(),
        ),
      );
      update();
    } else {
      commentShimmer = false;
    }
  }

  updateCommentSendLoader(val) {
    sendCommentLoader = val;
    update();
  }

  onCommentPost({
    required BuildContext context,
    required String postId,
    dynamic image,
  }) async {
    if (image != null) {
      updateCommentSendLoader(true);
      final res = await FeedRepository().commentPost(
        context: context,
        body: null,
        postId: postId,
        file: image,
      );
      if (res != null && res['data'] != null) {
        final res2 = await FeedRepository().getPostComments(
          context: context,
          postId: postId,
        );
        commentPostController.clear();
        if (res2 != null && res2['data'] != null) {
          await getFeeds(context: context);
          updateCommentSendLoader(false);
          saveCommentData(
            commentData: List.from(
              res2['data']['comments'].map((item) => Comments.fromJson(item)).toList(),
            ),
          );
          update();
        } else {
          updateCommentSendLoader(false);
        }
        update();
      } else {
        updateCommentSendLoader(false);
      }
    } else {
      final comment = commentPostController.value.text.trim();
      if (comment.isEmpty) {
        return;
      }
      final body = {
        'text': commentPostController.value.text,
      };
      updateCommentSendLoader(true);
      final res = await FeedRepository().commentPost(
        context: context,
        body: body,
        postId: postId,
        file: image,
      );
      if (res != null && res['data'] != null) {
        final res2 = await FeedRepository().getPostComments(
          context: context,
          postId: postId,
        );
        commentPostController.clear();
        if (res2 != null && res2['data'] != null) {
          await getFeeds(context: context);
          updateCommentSendLoader(false);
          saveCommentData(
            commentData: List.from(
              res2['data']['comments'].map((item) => Comments.fromJson(item)).toList(),
            ),
          );
          update();
        } else {
          updateCommentSendLoader(false);
        }
        update();
      } else {
        updateCommentSendLoader(false);
      }
    }
  }

  onReplyCommentPost({
    required BuildContext context,
    required String postId,
    required String commentId,
    dynamic image,
  }) async {
    if (image != null) {
      updateCommentSendLoader(true);
      final res = await FeedRepository().onReplyComment(
        context: context,
        body: null,
        postId: postId,
        commentId: commentId,
        file: image,
      );
      if (res != null && res['data'] != null) {
        final res2 = await FeedRepository().getPostComments(
          context: context,
          postId: postId,
        );
        commentPostController.clear();
        if (res2 != null && res2['data'] != null) {
          updateCommentSendLoader(false);
          saveCommentData(
            commentData: List.from(
              res2['data']['comments'].map((item) => Comments.fromJson(item)).toList(),
            ),
          );
          update();
        } else {
          updateCommentSendLoader(false);
        }
        update();
      } else {
        updateCommentSendLoader(false);
      }
    } else {
      final comment = commentPostController.value.text.trim();
      if (comment.isEmpty) {
        return;
      }
      final body = {
        'text': commentPostController.value.text,
      };
      updateCommentSendLoader(true);
      final res = await FeedRepository().onReplyComment(
        context: context,
        body: body,
        postId: postId,
        commentId: commentId,
      );
      if (res != null && res['data'] != null) {
        final res2 = await FeedRepository().getPostComments(
          context: context,
          postId: postId,
        );
        commentPostController.clear();
        if (res2 != null && res2['data'] != null) {
          updateCommentSendLoader(false);
          saveCommentData(
            commentData: List.from(
              res2['data']['comments'].map((item) => Comments.fromJson(item)).toList(),
            ),
          );
          update();
        } else {
          updateCommentSendLoader(false);
        }
        update();
      } else {
        updateCommentSendLoader(false);
      }
    }
  }

  Map<String, int> get groupedLikes {
    var map = <String, int>{};
    for (var like in likeList) {
      if (map.containsKey(like.type)) {
        map[like.type!] = map[like.type]! + 1;
      } else {
        map[like.type!] = 1;
      }
    }
    return map;
  }

  void onTypeSelected(String type) {
    filteredLikeList = filterByType(type);
    update();
  }

  List<Likes> filterByType(String type) {
    if (type == '') {
      return likeList;
    } else {
      return likeList.where((like) => like.type == type).toList();
    }
  }

  onDeletePost({
    required BuildContext context,
    required String postId,
    bool? isFromNotification = false,
  }) {
    hidePostOption();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DoubleButtonDialog(
          onNo: () {
            Get.back();
          },
          onYes: () async {
            final body = {"postId": postId};
            Get.back();
            final res = await FeedRepository().deletePost(
              context: context,
              body: body,
            );
            if (res['status'] == 200 && res['success']) {
              await getFeeds(context: context);
              Get.defaultDialog(
                backgroundColor: Colors.transparent,
                title: "",
                content: BasicDialog(
                  heading: 'Post Deleted',
                  bodyText: 'Your Post has been Deleted.',
                  onTap: () {
                    Get.close(isFromNotification! ? 2 : 1);
                  },
                ),
              );
              final res2 = await AuthRepository().autoLogin(context: context, showLoader: false);
              final fc = Get.put(FeedController());
              pc.saveUserDetails(
                UserModel.fromJson(
                  res2['data']['user'],
                ),
              );
              fc.editfeedData = res2['data']['user']['posts'];
            }
          },
          heading: 'Delete Post',
          bodyText: 'Are you sure you want to\ndelet this post?',
        );
      },
    );
  }
}
