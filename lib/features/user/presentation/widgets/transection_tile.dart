import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:perk_app/core/extension/string_ext.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class TransactionItem extends StatelessWidget {
  final String transactionId;
  final String date;
  final String status;
  final double amount;

  const TransactionItem({
    super.key,
    required this.transactionId,
    required this.date,
    required this.status,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorTheme.secondarySurface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "Txn #",
                style: TextStyle(
                  fontSize: 14,

                  fontWeight: FontWeight.w500,
                  color: ColorTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                transactionId,
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorTheme.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const CustomText(
                "Status",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorTheme.secondaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                StringExtension(status).capitalize(),
                style: TextStyle(
                  fontSize: 16,

                  color: status == "pending"
                      ? Colors.orangeAccent
                      : ColorTheme.bullish,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Right Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomText(
                "Date and Time",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorTheme.primaryText,

                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                date,
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorTheme.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const CustomText(
                "Amount",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorTheme.secondaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                "₹$amount",
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorTheme.bullish,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
