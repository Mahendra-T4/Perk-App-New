import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perk_app/core/constants/font_family.dart';
import 'package:perk_app/core/constants/text_const.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/custom_tf.dart';
import 'package:perk_app/core/utils/widget/symbol_details_tile.dart';

import 'package:perk_app/features/home/presentation/page/nfo/symbol/nfo_symbol.dart';

abstract class NFOSymbolBuilder extends State<NFOSymbolPanel> {
  late TabController tabController;
  int selectedTab = 0;
  final TextEditingController amountController = TextEditingController();
  final ValueNotifier<int> lotsNotifierMrk = ValueNotifier<int>(1);

  final ValueNotifier<int> lotsNotifierOrder = ValueNotifier<int>(1);
  final TextEditingController lotsMktController = TextEditingController(
    text: '1',
  );
  final TextEditingController lotsOdrController = TextEditingController(
    text: '1',
  );

  Widget get amountField => CustomTextFormField(
    controller: amountController,
    labelText: 'Amount',
    hintText: 'Enter amount',
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    prefixIcon: Icon(Icons.attach_money, color: ColorTheme.primaryColor),
    // onChanged: (value) {
    //   log('Amount changed: $value');
    // },
  );

  Widget inputTile({
    required ValueListenable<int> valueListenable,
    required TextEditingController controller,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorTheme.primaryText,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("UNITS").textStyleH11Color(),
          ValueListenableBuilder<int>(
            valueListenable: valueListenable,
            builder: (context, lots, child) {
              return Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: lots > 1
                          ? () =>
                                (valueListenable as ValueNotifier<int>).value =
                                    (valueListenable).value - 1
                          : null,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorTheme.secondaryText.withOpacity(0.6),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: ColorTheme.background,
                          size: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.20,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorTheme.secondaryText.withOpacity(0.6),
                    ),
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,

                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: ColorTheme.background,
                        fontFamily: FontFamily.globalFontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          final newLots = int.tryParse(value) ?? 1;
                          if (newLots > 0) {
                            (valueListenable as ValueNotifier<int>).value =
                                newLots;
                            log('Lots updated: $newLots');
                          }
                        }
                      },
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () =>
                          (valueListenable as ValueNotifier<int>).value =
                              (valueListenable).value + 1,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorTheme.secondaryText.withOpacity(0.6),
                        ),
                        child: Icon(
                          Icons.add,
                          color: ColorTheme.background,
                          size: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget get tabBar => SizedBox(
    height: 70,

    child: Row(
      children: [
        // Market Tab
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => selectedTab = 0);
              tabController.animateTo(0);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: selectedTab == 0
                    ? ColorTheme.secondarySurface
                    : Colors.transparent,
                border: Border.all(
                  color: selectedTab == 0
                      ? ColorTheme.primaryColor
                      : Colors.transparent,
                  width: 1.5,
                ),
                boxShadow: selectedTab == 0
                    ? [
                        BoxShadow(
                          color: ColorTheme.primaryColor.withOpacity(0.2),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedScale(
                    scale: selectedTab == 0 ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: selectedTab == 0
                            ? ColorTheme.primaryColor
                            : Colors.grey[500],
                        fontWeight: selectedTab == 0
                            ? FontWeight.w800
                            : FontWeight.w600,
                        fontSize: selectedTab == 0 ? 16 : 14,
                        letterSpacing: 0.5,
                        fontFamily: FontFamily.globalFontFamily,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.show_chart_rounded,
                            size: selectedTab == 0 ? 18 : 16,
                            color: selectedTab == 0
                                ? const Color(0xFF56CCF2)
                                : Colors.grey[500],
                          ),
                          const SizedBox(width: 6),
                          const Text('Market'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Order Tab
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => selectedTab = 1);
              tabController.animateTo(1);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: selectedTab == 1
                    ? ColorTheme.secondarySurface
                    : Colors.transparent,
                border: Border.all(
                  color: selectedTab == 1
                      ? ColorTheme.primaryColor
                      : Colors.transparent,
                  width: 1.5,
                ),
                boxShadow: selectedTab == 1
                    ? [
                        BoxShadow(
                          color: ColorTheme.primaryColor.withOpacity(0.2),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedScale(
                    scale: selectedTab == 1 ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: selectedTab == 1
                            ? ColorTheme.primaryColor
                            : Colors.grey[500],
                        fontWeight: selectedTab == 1
                            ? FontWeight.w800
                            : FontWeight.w600,
                        fontSize: selectedTab == 1 ? 16 : 14,
                        letterSpacing: 0.5,
                        fontFamily: FontFamily.globalFontFamily,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_rounded,
                            size: selectedTab == 1 ? 18 : 16,
                            color: selectedTab == 1
                                ? const Color(0xFF56CCF2)
                                : Colors.grey[500],
                          ),
                          const SizedBox(width: 6),
                          const Text('Orders'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildDetailsBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorTheme.secondarySurface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          // spacing: 20,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SymbolDetailsRowTile(
              data: Details(
                label1: 'Sell Price',
                value1: '4,500.00',
                label2: 'Buy Price',
                value2: '4,500.00',
                label3: 'Last',
                value3: '5,200',
              ),
            ),
            SymbolDetailsRowTile(
              data: Details(
                label1: 'Open',
                value1: '4,500.00',
                label2: 'Close',
                value2: '4,500.00',
                label3: 'ATP',
                value3: '5,200',
              ),
            ),
            SymbolDetailsRowTile(
              data: Details(
                label1: 'High',
                value1: '4,500.00',
                label2: 'Low',
                value2: '4,500.00',
                label3: 'Volume',
                value3: '5,200',
              ),
            ),
            SymbolDetailsRowTile(
              data: Details(
                label1: 'Upper Ckt',
                value1: '4,500.00',
                label2: 'Lower Ckt',
                value2: '4,500.00',
                label3: 'Change',
                value3: '5,200',
              ),
            ),
            SymbolDetailsRowTile(
              data: Details(
                label1: 'Last Sell',
                value1: '4,500.00',
                label2: 'Last Buy',
                value2: '4,500.00',
                label3: 'Lot Size',
                value3: '100',
              ),
            ),
            SymbolDetailsRowTile(
              data: Details(
                label1: 'Open Interest',
                value1: '45%',
                label2: '',
                value2: '',
                label3: '',
                value3: '',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderTab() {
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme.secondarySurface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 60, color: Colors.grey[700]),
            const SizedBox(height: 16),
            Text(
              'Your Orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
