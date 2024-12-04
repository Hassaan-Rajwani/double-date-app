// ignore_for_file: deprecated_member_use
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/models/post_model.dart';
import 'package:double_date/utils/image_constant.dart';
import 'package:double_date/utils/svg_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed_reaction/flutter_feed_reaction.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget reactBox({
  required PostModel data,
  required VoidCallback likeOnTap,
  required Function(int index) likeLongTap,
}) {
  return GetBuilder<FeedController>(
    builder: (controller) {
      return GestureDetector(
        onTap: likeOnTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
          child: FlutterFeedReaction(
            containerDecoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(100),
            ),
            onPressed: likeOnTap,
            reactions: [
              FeedReaction(
                header: Container(),
                id: 0,
                reaction: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    likeEmoji,
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              ),
              FeedReaction(
                header: Container(),
                id: 1,
                reaction: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    heartEmoji,
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              ),
              FeedReaction(
                header: Container(),
                id: 2,
                reaction: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    laughEmoji,
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              ),
              FeedReaction(
                header: Container(),
                id: 3,
                reaction: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    shockEmoji,
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              ),
              FeedReaction(
                header: Container(),
                id: 4,
                reaction: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    sadEmoji,
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              ),
              FeedReaction(
                header: Container(),
                id: 5,
                reaction: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    angryEmoji,
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              ),
            ],
            dragSpace: 50.0,
            onReactionSelected: (val) {
              likeLongTap(val.id);
            },
            prefix: data.likedByOwn!.type != null
                ? Image.asset(
                    controller.reactionIcon(data.likedByOwn!.type!),
                    width: 20,
                  )
                : SvgPicture.asset(
                    like2Icon,
                    color: Colors.white,
                    width: 20,
                  ),
          ),
        ),
      );
    },
  );
}
