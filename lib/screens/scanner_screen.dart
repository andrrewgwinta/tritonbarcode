import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globals.dart' as global;
import '../screens/logon_screen.dart';
import '../screens/order_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/pass_screen.dart';
import '../utilities.dart';
import '../widgets/page_template.dart';
import '../widgets/animated_body.dart';

class ScannerScreen extends StatefulWidget {
  static const routeName = '/scanner';

  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  void _badCodeMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          //title: const Text('Permission required'),
          content: const Text('это не ш-код Тритон-сервис'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ));
  }


  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Тритон-сервис. Штрих-коды'),
          actions: [
            // 1
            PopupMenuButton(
              //tooltip: '',
              child: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SettingScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'настройки',
                          style: kTextStylePopUp,
                        ),
                        Icon(FontAwesomeIcons.tools)
                      ],
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      global.token = '';
                      Navigator.of(context)
                          .pushReplacementNamed(LogonScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'выход ',
                          style: kTextStylePopUp,
                        ),
                        Icon(FontAwesomeIcons.signOutAlt)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: PageTemplate(
          child: AnimatedBody(),
          btnCaption: 'сканировать',
          btnClick: () {
            if (global.scannerInfoType == ScannerInfoType.sitCalculation) {
              //рабочий режим
              //*******************
              // scanQR().then((_) => (_scanBarcode.substring(0,4) == '{"KY')?Navigator.of(context).pushNamed(
              //     OrderInformation.routeName,
              //     arguments: _scanBarcode):_badCodeMessage()).then((_) => _scanBarcode='');

              //отладка манипуляций со строкой
              //*******************
               _scanBarcode =
               '{"KY":"F6","K1":" 1","K2":" 1","D1":"15","RT":"1,00","T1":"1,10","A0":"0.00","CALC1":"-","GRP1":"-","EM1":"-","SH0":"-"}';

              Navigator.of(context).pushNamed(OrderInformation.routeName,
                  arguments: _scanBarcode).then((_) => _scanBarcode='');
              //*******************

            }
            else if (global.scannerInfoType == ScannerInfoType.sitPass) {
              //рабочий режим
              //*******************
              // scanBarcodeNormal().then((_) => (_scanBarcode.substring(0,2) == '99')?Navigator.of(context).pushNamed(
              //     PassScreen.routeName,
              //     arguments: _scanBarcode):_badCodeMessage()).then((_) => _scanBarcode='');

              //*******************
              //отладка манипуляций со строкой
             //  _scanBarcode = '9951983100007';
             _scanBarcode = '9951982400009';
              //_scanBarcode = '9951982700000';

              if (_scanBarcode.substring(0,2) == '99') {
                Navigator.of(context).pushNamed(
                    PassScreen.routeName,
                    arguments: _scanBarcode).then((_) => _scanBarcode = '');
              }
              else {
                _badCodeMessage();
              }
              //*******************
            }
          },
        ));
  }
}


