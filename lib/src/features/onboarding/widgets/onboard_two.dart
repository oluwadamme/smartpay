import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/app_asset.dart';

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
          height: 380,
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Positioned(
              right: -15,
              bottom: -50,
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
