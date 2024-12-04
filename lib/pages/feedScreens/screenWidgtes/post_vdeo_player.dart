import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoPlayer extends StatefulWidget {
  const PostVideoPlayer({
    super.key,
    required this.url,
    required this.isNetwork,
    required this.showControls,
    this.height = 72,
    this.width = 72,
    this.onTap,
    this.showPlayButton = false,
  });

  final dynamic url;
  final bool isNetwork;
  final bool showControls;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final bool? showPlayButton;

  @override
  State<PostVideoPlayer> createState() => _PostVideoPlayerState();
}

class _PostVideoPlayerState extends State<PostVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late Future<void> _initializeVideoFuture;

  @override
  void initState() {
    _videoPlayerController = widget.isNetwork
        ? VideoPlayerController.networkUrl(
            Uri.parse(widget.url),
          )
        : VideoPlayerController.file(
            widget.url,
          );
    _initializeVideoFuture = _videoPlayerController.initialize().then((_) {
      _videoPlayerController.setVolume(0.0);
      _chewieController = ChewieController(
        materialProgressColors: ChewieProgressColors(
          handleColor: Colors.pink,
          playedColor: Colors.pink,
        ),
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        showControls: widget.showControls,
        showOptions: false,
        showControlsOnInitialize: false,
        allowFullScreen: widget.showControls,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeVideoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading video'));
        } else {
          return GestureDetector(
            onTap: widget.onTap,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                ),
                if (widget.showPlayButton == true)
                  const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
