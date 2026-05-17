import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class Details {
  final String label1;
  final dynamic value1;
  final String label2;
  final dynamic value2;
  final String label3;
  final dynamic value3;

  Details({
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
    required this.label3,
    required this.value3,
  });
}

class SymbolDetailsRowTile extends StatelessWidget {
  const SymbolDetailsRowTile({super.key, required this.data});
  final Details data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorTheme.secondarySurface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Row(
          spacing: 16,
          children: [
            Expanded(child: _buildDetailItem(data.label1, data.value1)),
            Expanded(child: _buildDetailItem(data.label2, data.value2)),
            Expanded(child: _buildDetailItem(data.label3, data.value3)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          label,
          style: TextStyle(
            fontSize: 14,
            color: ColorTheme.secondaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        CustomText(
          value.toString(),
          style: TextStyle(
            fontSize: 14,
            color: ColorTheme.primaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
