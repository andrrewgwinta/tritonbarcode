import 'package:flutter/material.dart';

import '../utilities.dart';
import '../globals.dart' as global;


class RadioRowScanType extends StatefulWidget {
  ScannerInfoType selectedValue = global.scannerInfoType;

  RadioRowScanType({Key? key}) : super(key: key);

  @override
  State<RadioRowScanType> createState() => _RadioRowDateState();
}

class _RadioRowDateState extends State<RadioRowScanType> {

  void onRadioClick(ScannerInfoType? value) {
    setState(() {
      widget.selectedValue = value!;
      global.scannerInfoType = widget.selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
        elevation: 12,
        shape: kShapeBorderNoSide,
        color: kDialogBackGround,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RadioListTile<ScannerInfoType>(
              title: const Text('раскрой (детвль, узел'),
              value: ScannerInfoType.sitSaw,
              groupValue: widget.selectedValue,
              onChanged: onRadioClick,
            ),
            RadioListTile<ScannerInfoType>(
              title: const Text('пропуск'),
              value: ScannerInfoType.sitPass,
              groupValue: widget.selectedValue,
              onChanged: onRadioClick,
            ),
            RadioListTile<ScannerInfoType>(
              title: const Text('калькуляция заказа'),
              value: ScannerInfoType.sitCalculation,
              groupValue: widget.selectedValue,
              onChanged: onRadioClick,
            ),
          ],
        ),
      ),
    );
  }
}
