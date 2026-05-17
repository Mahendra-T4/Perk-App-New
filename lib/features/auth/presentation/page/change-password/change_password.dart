import 'package:flutter/material.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/custom_button.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class ChangePasswordPanel extends StatefulWidget {
  const ChangePasswordPanel({super.key});
  static const String routeName = '/change-password';

  @override
  State<ChangePasswordPanel> createState() => _ChangePasswordPanelState();
}

class _ChangePasswordPanelState extends State<ChangePasswordPanel> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isPasswordEmpty = true;
  bool _passwordMatch = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_updatePasswordStrength);
    _confirmPasswordController.addListener(_updatePasswordMatch);
  }

  void _updatePasswordStrength() {
    setState(() {
      _isPasswordEmpty = _newPasswordController.text.isEmpty;
    });
  }

  void _updatePasswordMatch() {
    setState(() {
      _passwordMatch =
          _newPasswordController.text == _confirmPasswordController.text &&
          _newPasswordController.text.isNotEmpty;
    });
  }

  int _getPasswordStrength(String password) {
    if (password.isEmpty) return 0;
    if (password.length < 6) return 1;
    if (password.length < 8) return 2;
    if (password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')))
      return 3;
    return 2;
  }

  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 1:
        return ColorTheme.bearish;
      case 2:
        return Color(0xFFFF9500);
      case 3:
        return ColorTheme.bullish;
      default:
        return ColorTheme.secondaryText;
    }
  }

  String _getStrengthText(int strength) {
    switch (strength) {
      case 1:
        return 'Weak';
      case 2:
        return 'Medium';
      case 3:
        return 'Strong';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Change Password'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorTheme.primaryColor.withOpacity(0.1),
                    ColorTheme.primaryColor.withOpacity(0.03),
                  ],
                ),
                border: Border.all(
                  color: ColorTheme.primaryColor.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shield_rounded,
                    color: ColorTheme.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomText(
                      'Create a strong password to keep your account secure',
                      style: TextStyle(
                        color: ColorTheme.primaryText,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Current password field
            _buildPasswordField(
              label: 'Current Password',
              controller: _currentPasswordController,
              isVisible: _showCurrentPassword,
              onVisibilityChanged: (value) {
                setState(() => _showCurrentPassword = value);
              },
            ),
            const SizedBox(height: 22),

            // New password field
            _buildPasswordField(
              label: 'New Password',
              controller: _newPasswordController,
              isVisible: _showNewPassword,
              onVisibilityChanged: (value) {
                setState(() => _showNewPassword = value);
              },
            ),
            if (!_isPasswordEmpty) ...[
              const SizedBox(height: 10),
              _buildPasswordStrengthIndicator(
                _getPasswordStrength(_newPasswordController.text),
              ),
            ],
            const SizedBox(height: 22),

            // Confirm password field
            _buildPasswordField(
              label: 'Confirm New Password',
              controller: _confirmPasswordController,
              isVisible: _showConfirmPassword,
              onVisibilityChanged: (value) {
                setState(() => _showConfirmPassword = value);
              },
              showCheck:
                  _passwordMatch && _newPasswordController.text.isNotEmpty,
            ),
            if (_newPasswordController.text.isNotEmpty &&
                _confirmPasswordController.text.isNotEmpty &&
                !_passwordMatch) ...[
              const SizedBox(height: 8),
              CustomText(
                'Passwords do not match',
                style: TextStyle(
                  color: ColorTheme.bearish,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
            const SizedBox(height: 40),

            // Submit button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: ColorTheme.primaryColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CustomButton(
                label: 'Update Password',
                onPressed: () {
                  print('Current Password: ${_currentPasswordController.text}');
                  print('New Password: ${_newPasswordController.text}');
                  print('Confirm Password: ${_confirmPasswordController.text}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator(int strength) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: strength / 3,
                  minHeight: 4,
                  backgroundColor: ColorTheme.secondaryText.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getStrengthColor(strength),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            CustomText(
              _getStrengthText(strength),
              style: TextStyle(
                color: _getStrengthColor(strength),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required Function(bool) onVisibilityChanged,
    bool showCheck = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label,
          style: TextStyle(
            color: ColorTheme.primaryText,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorTheme.secondarySurface,
            border: Border.all(
              color: showCheck
                  ? ColorTheme.bullish.withOpacity(0.4)
                  : ColorTheme.primaryColor.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: showCheck
                ? [
                    BoxShadow(
                      color: ColorTheme.bullish.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: controller,
            obscureText: !isVisible,
            decoration: InputDecoration(
              hintText: 'Enter password',
              hintStyle: TextStyle(
                color: ColorTheme.secondaryText.withOpacity(0.5),
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showCheck)
                      Icon(
                        Icons.check_circle_rounded,
                        color: ColorTheme.bullish,
                        size: 20,
                      ),
                    if (showCheck) const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => onVisibilityChanged(!isVisible),
                      child: Icon(
                        isVisible
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: ColorTheme.primaryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            style: TextStyle(
              color: ColorTheme.primaryText,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            cursorColor: ColorTheme.primaryColor,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
