import 'dart:convert';
import 'package:flutter/material.dart';

import '../utilities.dart';


class OrderInformation with ChangeNotifier {

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


  //List<PairString> items = [];
  @override
  Future<void> loadInfo(String barcode) async {
    //final Map infoJson;
    final infoJson = json.decode(barcode);
    List<PairString> result = [];
    String readingString;

    for (var element in infoJson.keys) {
      readingString = description
          .firstWhere((eds) => eds.containsKey(element.toString()))
          .values
          .toString();
      result.add(PairString(
        text1: readingString.substring(1, readingString.length - 1),
        text2: infoJson[element.toString()].toString().replaceAll('-', ''),
      ));

      items = result;
    }
  }
}



