import 'dart:async';
import 'package:double_date/widgets/Card%20Swiper/enums.dart';
import 'package:flutter/widgets.dart';

typedef CardSwiperOnSwipe = FutureOr<bool> Function(
  int previousIndex,
  int? currentIndex,
  CardSwiperDirection direction,
);

typedef CardSwiperOnSwipeUpdate = void Function(
  int? currentIndex,
  CardSwiperDirection direction,
);

typedef NullableCardBuilder = Widget? Function(
  BuildContext context,
  int index,
  int horizontalOffsetPercentage,
  int verticalOffsetPercentage,
);

typedef CardSwiperDirectionChange = void Function(
  CardSwiperDirection horizontalDirection,
  CardSwiperDirection verticalDirection,
);

typedef CardSwiperOnEnd = FutureOr<void> Function();

typedef CardSwiperOnTapDisabled = FutureOr<void> Function();

typedef CardSwiperOnUndo = bool Function(
  int? previousIndex,
  int currentIndex,
  CardSwiperDirection direction,
);
