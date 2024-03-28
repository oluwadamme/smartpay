import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/app_asset.dart';
import 'package:smartpay/src/utils/spacing_util.dart';

class OnboardOne extends StatelessWidget {
  const OnboardOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.asset(AppAsset.device),
        SizedBox(
          height: 400,
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Positioned(
              top: screenHeight(context, percent: 0.35),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 100,
                width: screenWidth(context),
                color: Colors.white.withOpacity(0.8),
                child: const Row(children: []),
              ),
            ),
            Positioned(
              top: 50,
              left: -10,
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.asset(
                  AppAsset.shield,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Positioned(
              right: -15,
              bottom: 10,
              child: SizedBox(
                width: 220,
                height: 200,
                child: Image.asset(
                  AppAsset.chart,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-1.5, 1.6),
              child: SizedBox(
                width: 220,
                height: 200,
                child: Image.asset(AppAsset.deposit),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
