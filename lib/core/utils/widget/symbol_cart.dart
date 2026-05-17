import 'package:flutter/material.dart';
import 'package:perk_app/assets/assets.dart';
import 'package:perk_app/core/constants/font_family.dart';
import 'package:perk_app/core/constants/text_const.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/utils.dart';

class SymbolCartTile extends StatelessWidget {
  const SymbolCartTile({
    super.key,
    required this.symbolName,
    this.sellPrice,
    this.buyPrice,
    this.change,
    this.lastPrice,
    this.high,
    this.low,
    this.onTap,
    required this.expiryDate,
  });
  final String symbolName;
  final dynamic sellPrice;
  final dynamic buyPrice;
  final dynamic change;
  final dynamic lastPrice;
  final dynamic high;
  final dynamic low;
  final String expiryDate;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 12, right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorTheme.secondarySurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(symbolName).textStyleH1()],
                  ),
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sellPrice).textStyleH1(),

                    Text(buyPrice).textStyleH1(),
                    // const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Text(expiryDate).textStyleH2(),
                ),

                GestureDetector(
                  onTap: () async {},
                  child: Image.asset(
                    Assets.wishlistButtonIcon,
                    width: 28,
                    height: 28,
                  ),
                  // : Container(
                  //     margin: const EdgeInsets.only(right: 8),
                  //     height: 28,
                  //     width: 28,
                  //     decoration: BoxDecoration(
                  //       color: Colors.lightGreen.withOpacity(0.5),
                  //       border: Border.all(color: greyColor, width: 2),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Chg: ",
                      style: TextStyle(
                        color: change.toString().contains('-')
                            ? ColorTheme.bearish
                            : ColorTheme.bullish,
                        fontSize: 11.5,
                        fontFamily: FontFamily.globalFontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      Utils.formatNumber(change),
                      style: TextStyle(
                        color: change.toString().contains('-')
                            ? ColorTheme.bearish
                            : ColorTheme.bullish,
                        fontSize: 11.5,
                        fontFamily: FontFamily.globalFontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("LTP: ").textStyleH3(),
                    Text(Utils.formatNumber(lastPrice)).textStyleH3(),
                  ],
                ),
                Row(
                  children: [
                    const Text("H: ").textStyleH3(),
                    Text(Utils.formatNumber(high)).textStyleH3(),
                  ],
                ),
                Row(
                  children: [
                    const Text("L: ").textStyleH3(),
                    Text(Utils.formatNumber(low)).textStyleH3(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
