import 'dart:convert';

import 'package:flutter/material.dart';

import '../utilities.dart';
import '../widgets/page_template.dart';


class OrderInformation extends StatefulWidget {
  static const routeName = '/ordinfo';

  OrderInformation({Key? key}) : super(key: key);

  @override
  State<OrderInformation> createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  bool isInit = true;
  late String info;
  late Map infoJson;
  List<PairString> items = [];

  final description = [
    {"T1": "таможенная очистка"},
    {"KY": "метод "},
    {"K1": "коэффициент 1"},
    {"K2": "коэффициент 2"},
    {"D0": "без скидки "},
    {"D1": "скидка на материалы "},
    {"D2": "скидка на материалы и услуги"},
    {"RT": "курс €"},
    {"A0": "без учета авиадоставки"},
    {"A1": "авиадоставки €/кг"},
    {"CALC0": "расчет по всей ветке"},
    {"CALC1": "расчет одного заказа"},
    {"CALC2": "расчет всего проекта"},
    {"GRP0": "без детализации"},
    {"GRP1": "без группировки (материалы/услуги)"},
    {"GRP2": "группировка по материалам(общ карточка)"},
    {"GRP3": "группировка по типам"},
    {"GRP4": "группировка по разделам"},
    {"EM0": "есть пустые строки"},
    {"EM1": "пустые строки не показаны"},
    {"SH0": "по всем типам"},
    {"SH1": "только по магазинным типам"},
  ];


  @override
  void initState() {
    super.initState();
    //info = ModalRoute.of(context)?.settings.arguments as String;
    //infoJson = json.decode(info);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String decsr;

    if (isInit) {
      info = ModalRoute.of(context)?.settings.arguments as String;
      infoJson = json.decode(info);
    }

    for (var element in infoJson.keys) {
      decsr = description
          .firstWhere((eds) => eds.containsKey(element.toString()))
          .values
          .toString();
      // print(element.toString());
      // print(infoJson[element.toString()]);
      items.add(PairString(
        text1: decsr.substring(1, decsr.length - 1),
        text2: infoJson[element.toString()].toString().replaceAll('-', ''),
      ));
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    //print(info);
    //print(infoJson.keys);
    //print();
    //print('ittems count ${items.length.toString()}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('сведения о расчете'),
      ),
      body: PageTemplate(
        child: Card(
          elevation: 12,
          shape: kShapeBorderNoSide,
          color: kDialogBackGround,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(items[index].text1),
                          Text(
                            items[index].text2,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )),
        ),
        //child: Text(info),

        btnClick: () {
          Navigator.of(context).pop();
        },
        btnCaption: 'продолжить сканирование',
      ),
    );
  }
}
