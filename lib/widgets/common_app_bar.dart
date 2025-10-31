import 'package:flutter/material.dart';
import 'package:flutter_app/core/style/app_colors.dart';
import 'package:flutter_app/generated/assets.gen.dart';
import 'package:flutter_app/widgets/language_selector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final Widget? flexibleSpace;
  final String? subtitle;
  final Widget? trailingWidget;
  final bool showLanguageSwitcher;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.onBackPressed,
    this.centerTitle = true,
    this.flexibleSpace,
    this.subtitle,
    this.trailingWidget,
    this.showLanguageSwitcher = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: subtitle != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: centerTitle
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: foregroundColor ?? theme.colorScheme.onPrimary,
                  ),
                ),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: (foregroundColor ?? theme.colorScheme.onPrimary)
                        .withOpacity(0.7),
                  ),
                ),
              ],
            )
          : Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: foregroundColor ?? theme.colorScheme.onPrimary,
              ),
            ),
      leading:
          leading ??
          (automaticallyImplyLeading ? _buildLeadingButton(context) : null),
      actions: _buildActions(),
      backgroundColor: backgroundColor ?? AppColors.background,
      foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      flexibleSpace: flexibleSpace,
    );
  }

  Widget _buildLeadingButton(BuildContext context) {
    return GestureDetector(
      onTap: onBackPressed ?? () => context.pop(),
      child: Container(
        margin: EdgeInsets.all(5.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray500),
          color: AppColors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Assets.images.svg.backIcon.svg(width: 20.w, height: 20.w),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (subtitle != null ? 20 : 0));

  List<Widget>? _buildActions() {
    final List<Widget> built = [];
    if (trailingWidget != null) {
      built.add(trailingWidget!);
    } else if (actions != null) {
      built.addAll(actions!);
    }
    if (showLanguageSwitcher) {
      built.add(
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: const LanguageSelector(),
        ),
      );
    }
    return built.isEmpty ? null : built;
  }
}
