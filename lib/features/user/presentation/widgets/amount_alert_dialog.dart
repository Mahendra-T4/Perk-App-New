import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class AmountAlertDialog extends StatefulWidget {
  final String title;
  final String description;
  final String hint;
  final Function(String) onSubmit;
  final VoidCallback? onCancel;

  const AmountAlertDialog({
    Key? key,
    this.title = 'Enter Amount',
    this.description = 'Please enter the amount you want to withdraw',
    this.hint = 'Enter amount',
    required this.onSubmit,
    this.onCancel,
  }) : super(key: key);

  @override
  State<AmountAlertDialog> createState() => _AmountAlertDialogState();
}

class _AmountAlertDialogState extends State<AmountAlertDialog> {
  late TextEditingController _amountController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter an amount'),
          backgroundColor: Colors.red.shade400,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    widget.onSubmit(_amountController.text);

    // Close dialog after a short delay to show loading state
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorTheme.secondarySurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with title
              Column(
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: ColorTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomText(
                    widget.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: ColorTheme.primaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    widget.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorTheme.primaryText.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Amount Input Field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorTheme.primaryText.withOpacity(0.05),
                  border: Border.all(
                    color: ColorTheme.primaryColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  enabled: !_isLoading,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorTheme.primaryText,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: ColorTheme.primaryText.withOpacity(0.5),
                      fontSize: 15,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                      color: ColorTheme.primaryColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: GestureDetector(
                      onTap: _isLoading
                          ? null
                          : () {
                              widget.onCancel?.call();
                              Navigator.of(context).pop();
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: ColorTheme.primaryColor.withOpacity(0.5),
                            width: 1.5,
                          ),
                          color: Colors.transparent,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Center(
                          child: CustomText(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: ColorTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Submit Button
                  Expanded(
                    child: GestureDetector(
                      onTap: _isLoading ? null : _handleSubmit,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              ColorTheme.primaryColor,
                              ColorTheme.primaryColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ColorTheme.primaryColor.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Center(
                          child: _isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      ColorTheme.primaryText,
                                    ),
                                  ),
                                )
                              : CustomText(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: ColorTheme.primaryText,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
