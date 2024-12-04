import 'package:chewie/chewie.dart';
import 'package:double_date/utils/font_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class ShortVideoPlayer extends StatefulWidget {
  const ShortVideoPlayer({
    super.key,
    required this.url,
    required this.title,
    required this.isNetwork,
  });

  final dynamic url;
  final bool isNetwork;
  final String title;

  @override
  State<ShortVideoPlayer> createState() => _ShortVideoPlayerState();
}

class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = widget.isNetwork
        ? VideoPlayerController.networkUrl(
            Uri.parse(widget.url),
          )
        : VideoPlayerController.file(widget.url);

    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      setState(() {
        _videoPlayerController.setVolume(0.0);
      });
    });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      materialProgressColors: ChewieProgressColors(
        handleColor: Colors.pink,
        playedColor: Colors.pink,
      ),
      autoPlay: false,
      looping: false,
      showControls: true,
      showOptions: false,
      showControlsOnInitialize: false,
      allowFullScreen: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ShortVideoPlayer oldWidget) {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    _videoPlayerController = widget.isNetwork
        ? VideoPlayerController.networkUrl(
            Uri.parse(widget.url),
          )
        : VideoPlayerController.file(widget.url);

    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      setState(() {
        _videoPlayerController.setVolume(0.0);
      });
    });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      materialProgressColors: ChewieProgressColors(
        handleColor: Colors.pink,
        playedColor: Colors.pink,
      ),
      autoPlay: false,
      looping: false,
      showControls: true,
      showOptions: false,
      showControlsOnInitialize: false,
      allowFullScreen: true,
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Chewie(controller: _chewieController);
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                  ),
                );
              }
            },
          ),
        ),
        if (widget.title != '')
          Positioned(
            bottom: 70,
            left: 30,
            child: SizedBox(
              width: 0.5.sw,
              child: Text(
                widget.title,
                style: interFont(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// import 'dart:io';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:video_player/video_player.dart';

// class ShortVideoPlayer extends StatefulWidget {
//   const ShortVideoPlayer({
//     Key? key,
//     required this.url,
//     required this.title,
//     required this.isNetwork,
//   }) : super(key: key);

//   final dynamic url;
//   final bool isNetwork;
//   final String title;

//   @override
//   State<ShortVideoPlayer> createState() => _ShortVideoPlayerState();
// }

// class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }

//   void _initializeVideoPlayer() async {
//     _videoPlayerController = widget.isNetwork ? VideoPlayerController.network(widget.url) : VideoPlayerController.file(File(widget.url));

//     await _videoPlayerController.initialize();
//     setState(() {
//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController,
//         materialProgressColors: ChewieProgressColors(
//           handleColor: Colors.pink,
//           playedColor: Colors.pink,
//         ),
//         autoPlay: false,
//         looping: false,
//         showControls: true,
//         allowFullScreen: true,
//       );
//       _isInitialized = true;
//     });
//   }

//   @override
//   void didUpdateWidget(covariant ShortVideoPlayer oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     _isInitialized = false;
//     _videoPlayerController.dispose();
//     _initializeVideoPlayer();
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: 300,
//           height: 300,
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.pink,
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(10.r),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.pink.withOpacity(0.3),
//                 spreadRadius: 1,
//                 blurRadius: 100,
//                 offset: const Offset(0, 1),
//               ),
//             ],
//           ),
//           child: _isInitialized
//               ? Chewie(controller: _chewieController!)
//               : const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.pink,
//                   ),
//                 ),
//         ),
//         if (widget.title.isNotEmpty)
//           Positioned(
//             bottom: 70,
//             left: 30,
//             child: SizedBox(
//               width: 0.5.sw,
//               child: Text(
//                 widget.title,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.pink,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
