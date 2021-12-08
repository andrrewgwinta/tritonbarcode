import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../utilities.dart';
import '../globals.dart' as global;

class MainMenu extends StatelessWidget {

  final Function() startScanning;

  const MainMenu({
    Key? key,
    required this.startScanning,
  }) : super(key: key);

  final List list = const [
    ' ',
    'раскрой(деталь, узел)',
    'пропуск',
    'калькуляция',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFB4C56C).withOpacity(0.3),
        //color: const Color(0xFFB4C56C),
        borderRadius: const BorderRadius.all( Radius.circular(50.0)),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return index == 0
              ? Container(
            height: 50.0,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
                color: const Color(0xFFB4C56C)
                    .withOpacity(0.7),
                borderRadius: const BorderRadius.all(
                    Radius.circular(25.0)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0)
                ]),
            child: Row(
              children: const <Widget>[
                // Icon(
                //   Icons.info,
                //   color: Colors.white,
                // ),
                SizedBox(width: 8.0, ),
                Text('что сканируем',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 24.0))
              ],
            ),
          )
              : Column(
            children: [
              const SizedBox(height: 30,),
              Row(
                children: [Expanded(
                  child: ElevatedButton(

                    onPressed: (){
                      if (index == 1) {
                        global.scannerInfoType = ScannerInfoType.sitSaw;
                      }
                      else
                        if (index == 2) {
                          global.scannerInfoType = ScannerInfoType.sitPass;
                        }
                        else
                          if (index == 3) {
                            global.scannerInfoType = ScannerInfoType.sitCalculation;
                          }
                          startScanning();
                    },
                    child: Text(
                      list[index],
                      style: TextStyle(color: Palette.kDackColor[400],
                        fontSize: 20,
                        backgroundColor: const Color(0xFFB4C56C)
                            .withOpacity(0.7),
                      ),
                    ),
                  ),
                )],
              ),
            ],
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
