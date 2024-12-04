import 'package:double_date/widgets/Card%20Swiper/enums.dart';
import 'package:flutter/widgets.dart';

extension DirectionExtension on CardSwiperDirection {
  Axis get axis => switch (this) {
        CardSwiperDirection.left || CardSwiperDirection.right => Axis.horizontal,
        CardSwiperDirection.top || CardSwiperDirection.bottom => Axis.vertical,
        CardSwiperDirection.none => throw Exception('Direction is none'),
      };
}
