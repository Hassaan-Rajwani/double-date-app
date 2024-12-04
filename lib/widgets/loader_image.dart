import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoaderImage extends StatelessWidget {
  const LoaderImage({
    super.key,
    required this.url,
    this.width = 50,
    this.height = 50,
    this.borderRadius = 100,
  });

  final String url;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius!),
      child: CachedNetworkImage(
        imageUrl: url,
        color: const Color.fromARGB(255, 202, 202, 202),
        width: width,
        height: height,
        colorBlendMode: BlendMode.darken,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          width: 10.w,
          height: 10.h,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            color: Colors.pink,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
