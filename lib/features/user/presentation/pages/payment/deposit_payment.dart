import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/custom_button.dart';
import 'package:perk_app/core/utils/widget/custom_tf.dart';
import 'package:perk_app/core/utils/widget/date_picker_field.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/user/presentation/widgets/file_picker_button.dart';

class DepositPayment extends StatefulWidget {
  const DepositPayment({super.key});
  static const String routeName = '/deposit-payment';

  @override
  State<DepositPayment> createState() => _DepositPaymentState();
}

class _DepositPaymentState extends State<DepositPayment> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _utrController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Deposit Payment'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorTheme.primaryColor.withOpacity(0.15),
                    ColorTheme.primaryColor.withOpacity(0.05),
                  ],
                ),
                border: Border.all(
                  color: ColorTheme.primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ColorTheme.primaryColor.withOpacity(0.2),
                              ColorTheme.primaryColor.withOpacity(0.05),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet_rounded,
                          color: ColorTheme.primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'Add Funds',
                              style: TextStyle(
                                color: ColorTheme.primaryText,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            CustomText(
                              'Securely deposit funds into your account',
                              style: TextStyle(
                                color: ColorTheme.secondaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Form section
            CustomText(
              'Payment Details',
              style: TextStyle(
                color: ColorTheme.primaryText,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Amount field
            _buildFormField(
              label: 'Deposit Amount',
              child: CustomTextFormField(
                controller: _amountController,
                labelText: 'Amount',
                hintText: 'Enter amount to deposit',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(height: 16),

            // UTR field
            _buildFormField(
              label: 'UTR Number',
              child: CustomTextFormField(
                controller: _utrController,
                labelText: 'UTR Number',
                hintText: 'Enter UTR number',
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 16),

            // Date field
            _buildFormField(
              label: 'Transaction Date',
              child: DatePickerField(
                controller: _dateController,
                hint: 'Pick a date',
                onDateChanged: (selectedDate) {
                  print('Selected: $selectedDate');
                },
              ),
            ),
            const SizedBox(height: 16),

            // File picker
            _buildFormField(
              label: 'Upload Proof',
              child: FilePickerButton(
                label: 'Attach File',
                hint: 'Choose a file',
                onFilePicked: (filePath) {
                  print('File selected: $filePath');
                },
                onClear: () {
                  print('File cleared');
                },
              ),
            ),
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
              child: CustomButton(label: 'Submit Deposit', onPressed: () {}),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({required String label, required Widget child}) {
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
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorTheme.primaryColor.withOpacity(0.2)),
          ),
          child: child,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _utrController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
