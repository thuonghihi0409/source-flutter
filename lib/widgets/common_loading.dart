import 'package:flutter/material.dart';
import '../../core/style/app_colors.dart';
import '../generated/assets.gen.dart';

class CommonLoading extends StatefulWidget {
  final String? text;
  final double? size;
  final Color? color;
  final Duration? duration;
  final bool showText;
  final Color? backgroundColor;

  const CommonLoading({
    super.key,
    this.text,
    this.size,
    this.color,
    this.duration,
    this.showText = true,
    this.backgroundColor,
  });

  @override
  State<CommonLoading> createState() => _CommonLoadingState();
}

class _CommonLoadingState extends State<CommonLoading>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration ?? const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingSize = widget.size ?? 50.0;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 2 * 3.14159, // Full rotation
          child: SizedBox(
            width: loadingSize,
            height: loadingSize,
            child: Assets.images.svg.loadingSpinner.svg(
              width: loadingSize,
              height: loadingSize,
              colorFilter: ColorFilter.mode(
                widget.color ?? AppColors.hexWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
        );
      },
    );
  }
}
