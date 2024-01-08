import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatelessWidget {
  const RadialProgress({
    super.key,
    required this.height,
    required this.width,
    required this.progress,
    required this.result,
  });
  final double height, width, progress, result;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(
        progress: 0.7,
      ),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${result.toInt()}",
                  style: const TextStyle(
                    color: AppColors.cOrange,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(text: "\n"),
                const TextSpan(
                  text: "kcal ",
                  style: TextStyle(
                    color: AppColors.cOrange,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  _RadialPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = AppColors.cOrange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(-relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
