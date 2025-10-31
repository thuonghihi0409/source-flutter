import 'package:flutter/material.dart';
import 'package:flutter_app/generated/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../core/services/language_service.dart';
import '../core/style/app_colors.dart';
import '../core/style/app_text_styles.dart';
import 'custom_toast.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = 'vi'; // 'vi' or 'en'

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  void _loadCurrentLanguage() {
    final languageService = Provider.of<LanguageService>(
      context,
      listen: false,
    );
    setState(() {
      _selectedLanguage = languageService.currentLanguageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        // Update local state when language service changes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted &&
              _selectedLanguage != languageService.currentLanguageCode) {
            setState(() {
              _selectedLanguage = languageService.currentLanguageCode;
            });
          }
        });

        return Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Flag icon
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 2.r,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: _getFlagIcon().image(
                        width: 24.w,
                        height: 24.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    _getLanguageText(),
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AssetGenImage _getFlagIcon() {
    return _selectedLanguage == 'vi'
        ? Assets.images.png.viIcon
        : Assets.images.png.enIcon;
  }

  String _getLanguageText() {
    return _selectedLanguage == 'vi' ? 'VI' : 'EN';
  }

  Future<void> _toggleLanguage() async {
    final languageService = Provider.of<LanguageService>(
      context,
      listen: false,
    );

    // Toggle language using the service
    await languageService.toggleLanguage();

    // Update local state
    if (mounted) {
      setState(() {
        _selectedLanguage = languageService.currentLanguageCode;
      });

      // Show success message
      CustomToast.showSuccess(
        context,
        _selectedLanguage == 'vi'
            ? 'Đã chuyển sang Tiếng Việt'
            : 'Changed to English',
      );
    }
  }
}
