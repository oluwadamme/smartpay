import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartpay/src/utils/app_asset.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/spacing_util.dart';

class OtherAuthMethod extends StatelessWidget {
  const OtherAuthMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AppAsset.or),
        const YMargin(30),
        Row(
          children: [
            Expanded(
              child: Container(
                width: screenWidth(context),
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey200),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: SvgPicture.asset(AppAsset.google)),
              ),
            ),
            const XMargin(20),
            Expanded(
              child: Container(
                width: screenWidth(context),
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey200),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: SvgPicture.asset(AppAsset.apple)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
