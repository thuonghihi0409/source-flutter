import 'package:flutter/material.dart';
import 'package:flutter_app/core/style/app_colors.dart';
import 'package:flutter_app/core/style/app_text_styles.dart';
import 'package:flutter_app/generated/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.background,
          borderRadius:
              borderRadius ??
              BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.outline,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Title
            if (title != null) ...[
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  title,
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            // Content
            Flexible(
              child: Padding(
                padding: padding ?? EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<String?> showLanguageSelector({
    required BuildContext context,
    required String currentLanguage,
  }) {
    return show<String>(
      context: context,
      title: 'Chọn ngôn ngữ',
      height: 250.h,
      child: Column(
        children: [
          _buildLanguageOption(
            context: context,
            language: 'VI',
            languageName: 'Tiếng Việt',
            flagIcon: Assets.images.png.viIcon,
            isSelected: currentLanguage == 'VI',
          ),
          SizedBox(height: 16.h),
          _buildLanguageOption(
            context: context,
            language: 'EN',
            languageName: 'English',
            flagIcon: Assets.images.png.enIcon,
            isSelected: currentLanguage == 'EN',
          ),
        ],
      ),
    );
  }

  static Widget _buildLanguageOption({
    required BuildContext context,
    required String language,
    required String languageName,
    required AssetGenImage flagIcon,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(language),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Flag icon
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: ClipOval(
                child: flagIcon.image(
                  width: 32.w,
                  height: 32.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Language name
            Expanded(
              child: Text(
                languageName,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.onBackground,
                ),
              ),
            ),

            // Check icon
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 20.w),
          ],
        ),
      ),
    );
  }
}
