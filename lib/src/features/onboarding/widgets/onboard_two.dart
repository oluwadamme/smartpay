import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/app_asset.dart';
import 'package:smartpay/src/utils/spacing_util.dart';

class OnboardTwo extends StatelessWidget {
  const OnboardTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.asset(AppAsset.device2),
        SizedBox(
          height: 400,
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Positioned(
              top: screenHeight(context, percent: 0.4),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 100,
                width: screenWidth(context),
                color: Colors.white.withOpacity(0.9),
                child: const Row(children: []),
              ),
            ),
            Positioned(
              right: -15,
              bottom: -20,
              child: SizedBox(
                width: 220,
                height: 200,
                child: Image.asset(AppAsset.contact),
              ),
            ),
            Align(
              alignment: const Alignment(-1.5, 0.2),
              child: SizedBox(
                width: 220,
                height: 200,
                child: Image.asset(AppAsset.payment),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
