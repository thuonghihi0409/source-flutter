import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/style/app_colors.dart';
import '../core/style/app_text_styles.dart';
import '../generated/assets.gen.dart';

class Login2FAOTPBottomSheet extends StatefulWidget {
  final Function(String) onVerify;
  final VoidCallback onCancel;

  const Login2FAOTPBottomSheet({
    super.key,
    required this.onVerify,
    required this.onCancel,
  });

  @override
  State<Login2FAOTPBottomSheet> createState() => _Login2FAOTPBottomSheetState();
}

class _Login2FAOTPBottomSheetState extends State<Login2FAOTPBottomSheet> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  bool get _isOTPComplete {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  String get _otpCode {
    return _controllers.map((controller) => controller.text).join();
  }

  void _onVerifyPressed() {
    if (_isOTPComplete) {
      setState(() {
        _isLoading = true;
      });
      widget.onVerify(_otpCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.gray600,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Text(
                  'Xác thực 2 bước',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onCancel();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColors.gray400,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // Lock icon
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Center(
                      child: Image.asset(
                        Assets.images.png.iconLockPassword.path,
                        width: 40.w,
                        height: 40.w,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Title
                  Text(
                    'Nhập mã xác thực',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.onBackground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Description
                  Text(
                    'Vui lòng nhập mã 6 số từ ứng dụng xác thực của bạn',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.gray400,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return _buildOTPField(index);
                    }),
                  ),

                  SizedBox(height: 40.h),

                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: _isLoading || !_isOTPComplete
                          ? null
                          : _onVerifyPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.white,
                                ),
                              ),
                            )
                          : Text(
                              'Xác thực',
                              style: AppTextStyles.titleMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOTPField(int index) {
    return Container(
      width: 45.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: AppColors.gray800,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: _focusNodes[index].hasFocus
              ? AppColors.primary
              : AppColors.gray700,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTextStyles.titleLarge.copyWith(
          color: AppColors.onBackground,
          fontWeight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
            }
          } else {
            if (index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          }
          setState(() {}); // Trigger rebuild to update button state
        },
      ),
    );
  }
}
