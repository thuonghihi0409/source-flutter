import 'package:flutter/material.dart';
import 'package:flutter_app/generated/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/style/app_colors.dart';
import '../core/style/app_text_styles.dart';
import '../l10n/app_localizations.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  final VoidCallback? onCenterButtonTap;

  const CommonBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.onCenterButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Background with curve
          Positioned(
            top: -25.h,
            bottom: 0,
            left: 10,
            right: 10,
            child: Assets.images.png.navBackground.image(
              height: 77.h,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),

          // Navigation Items
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: SizedBox(
              height: 77.h,
              child: Row(
                children: [
                  // Home Button (Index 0)
                  Expanded(
                    child: _NavItem(
                      icon: Icons.home_outlined,
                      label: AppLocalizations.of(context)!.homeTab,
                      isSelected: currentIndex == 0,
                      onTap: () => _handleTap(context, 0),
                    ),
                  ),

                  // History Button (Index 1)
                  Expanded(
                    child: _NavItem(
                      icon: Icons.history_outlined,
                      label: AppLocalizations.of(context)!.historyTab,
                      isSelected: currentIndex == 1,
                      onTap: () => _handleTap(context, 1),
                    ),
                  ),

                  // Center Floating Button Spacer
                  SizedBox(width: 80.w),

                  // Voucher Button (Index 2)
                  Expanded(
                    child: _NavItem(
                      icon: Icons.card_giftcard_outlined,
                      label: AppLocalizations.of(context)!.voucherTab,
                      isSelected: currentIndex == 2,
                      onTap: () => _handleTap(context, 2),
                    ),
                  ),

                  // Profile Button (Index 3)
                  Expanded(
                    child: _NavItem(
                      icon: Icons.person_outline,
                      label: AppLocalizations.of(context)!.profileTab,
                      isSelected: currentIndex == 3,
                      onTap: () => _handleTap(context, 3),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center Floating Button
          Positioned(
            top: -20.h,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: onCenterButtonTap ?? () => context.push('/scanner'),
                child: Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 26.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
    } else {
      switch (index) {
        case 0:
          // Home
          context.go('/home');
          break;
        case 1:
          // History
          context.go('/history');
          break;
        case 2:
          // Voucher
          context.go('/voucher');
          break;
        case 3:
          // Profile
          context.push('/profile');
          break;
      }
    }
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 77.h,
        padding: EdgeInsets.only(bottom: 12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: isSelected ? AppColors.primary : AppColors.gray500,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: 10.sp,
                color: isSelected ? AppColors.primary : AppColors.gray500,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
