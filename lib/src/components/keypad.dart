import 'package:flutter/material.dart';
import 'package:smartpay/src/components/number_field.dart';
import 'package:smartpay/src/utils/utils.dart';

class Keypad extends StatefulWidget {
  const Keypad({super.key, required this.pin});
  final TextEditingController pin;
  @override
  State<Keypad> createState() => _KeypadState();
}

class _KeypadState extends State<Keypad> {
  String pinField = '';
  void updateController(String value) {
    print(value);
    setState(() {
      if (pinField.length < 5) {
        pinField += value;
        widget.pin.text = pinField;
        return;
      }
    });
  }

  void deleteField() {
    if (pinField.isEmpty) {
      pinField = '';
    } else {
      final list = pinField.split('');
      list.removeLast();
      setState(() {
        pinField = list.join("");
        widget.pin.text = pinField;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      pinField = widget.pin.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumberField(
                label: "1",
                onTap: (value) {
                  updateController(value);
                },
              ),
              NumberField(
                label: "2",
                onTap: (value) {
                  updateController(value);
                },
              ),
              NumberField(
                label: "3",
                onTap: (value) {
                  updateController(value);
                },
              ),
            ],
          ),
          const YMargin(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumberField(
                label: "4",
                onTap: (value) {
                  updateController(value);
                },
              ),
              NumberField(
                label: "5",
                onTap: (value) {
                  updateController(value);
                },
              ),
              NumberField(
                label: "6",
                onTap: (value) {
                  updateController(value);
                },
              ),
            ],
          ),
          const YMargin(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumberField(
                label: "7",
                onTap: (value) {
                  updateController(value);
                },
              ),
              NumberField(
                label: "8",
                onTap: (value) {
                  updateController(value);
                },
              ),
              NumberField(
                label: "9",
                onTap: (value) {
                  updateController(value);
                },
              ),
            ],
          ),
          const YMargin(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NumberField(
                label: "*",
                onTap: (value) {},
              ),
              NumberField(
                label: "0",
                onTap: (value) {
                  updateController(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    deleteField();
                  },
                  child: const Icon(Icons.backspace_outlined, size: 20),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
