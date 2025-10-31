import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/style/app_colors.dart';
import '../generated/assets.gen.dart';

/// A widget that demonstrates the new DnPay branding with blue gradient
/// and the dnpay icon, matching the background aesthetic
class DnPayBrandWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final double? iconSize;
  final bool showGradientBackground;

  const DnPayBrandWidget({
    super.key,
    this.title,
    this.subtitle,
    this.iconSize,
    this.showGradientBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: showGradientBackground
          ? const BoxDecoration(gradient: AppColors.backgroundGradient)
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // DnPay Icon
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.dnpayGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SvgPicture.asset(
              Assets.images.svg.dnpay.path,
              width: iconSize ?? 80,
              height: iconSize ?? 80,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          if (title != null) ...[
            Text(
              title!,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],

          // Subtitle
          if (subtitle != null) ...[
            Text(
              subtitle!,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// A success indicator widget using the new blue theme instead of green
class DnPaySuccessIndicator extends StatelessWidget {
  final String message;
  final IconData? icon;
  final VoidCallback? onTap;

  const DnPaySuccessIndicator({
    super.key,
    required this.message,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: AppColors.successGradient,
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.success.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? Icons.check_circle, color: AppColors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A button widget using the new DnPay gradient theme
class DnPayGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const DnPayGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.dnpayGradient,
        borderRadius: BorderRadius.circular(AppColors.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading) ...[
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ] else if (icon != null) ...[
                  Icon(icon, color: AppColors.white, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
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
