import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:frontend/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';

class CFadeInAnimation extends StatelessWidget {
  CFadeInAnimation({
    super.key,
    required this.durationInMs,
    required this.animatePositionModel,
    required this.child,
  });

  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final CAnimationPositionModel? animatePositionModel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: durationInMs),
        top: controller.animation.value
            ? animatePositionModel!.topAfter
            : animatePositionModel!.topBefore,
        left: controller.animation.value
            ? animatePositionModel!.leftAfter
            : animatePositionModel!.leftBefore,
        right: controller.animation.value
            ? animatePositionModel!.rigthAfter
            : animatePositionModel!.rightBefore,
        bottom: controller.animation.value
            ? animatePositionModel!.bottomAfter
            : animatePositionModel!.bottomBefore,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: durationInMs),
          opacity: controller.animation.value ? 1 : 0,
          child: child,
        ),
      ),
    );
  }
}
