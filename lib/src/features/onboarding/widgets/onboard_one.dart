import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/app_asset.dart';

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
          height: 380,
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Positioned(
              top: 70,
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
              bottom: 0,
              child: SizedBox(
                width: 220,
                height: 200,
                child: Image.asset(
                  AppAsset.chart,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-1.5, 1.7),
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
