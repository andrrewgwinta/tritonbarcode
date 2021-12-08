import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../globals.dart' as global;
import '../utilities.dart';

class PassItem {
  final String? barcode;
  final String? id;
  final String? num;
  final DateTime? date;
  final String? worker;
  final String? cargo;
  final String? author;
  final String? car;
  final String? listorder;

  PassItem(
      {this.barcode,
        this.id,
      this.num,
      this.date,
      this.worker,
      this.cargo,
      this.author,
      this.car,
      this.listorder});

  factory PassItem.fromJson(String bc, Map<String, dynamic> json) {
    return PassItem(
      barcode: bc,
      id: json["id"].toString(),
      num: json["num"].toString(),
      date: (json["date"] != null)
          ? DateTime.parse(json['date'])
          : DateTime(2000, 1, 1),
      worker: json["worker"],
      cargo: json["cargo"],
      car: json["car"],
      author: json["author"],
      listorder: json["listorder"] ?? '',
    );
  }

  String operator [](prop) {
    if (prop == 'id')
      return id!;
    else if (prop == 'date')
      return DateFormat.yMMMd('ru').add_Hm().format(date!);
    else if (prop == 'worker')
      return worker!;
    else if (prop == 'num')
      return num!;
    else if (prop == 'cargo')
      return cargo!;
    else if (prop == 'author')
      return author!;
    else if (prop == 'listorder')
      return (listorder == '')?'не указаны':listorder!;
    else
      return car!;
  }
}

class Pass extends ChangeNotifier {
  List<PairString> items = [];

  PassItem value = PassItem(
      id: '',
      num: '',
      date: DateTime.now(),
      worker: '',
      cargo: '',
      author: '',
      car: '',
      listorder:'');

  final description = [
    {"barcode": "штрих-код"},
    {"id": "регистрационный номер"},
    {"num": "номер пропуска"},
    {"date": "дата выдачи "},
    {"worker": "водитель/сотрудник"},
    {"cargo": "груз"},
    {"author": "оформил(а)"},
    {"car": "автомобиль"},
    {"listorder": "заказы в пропуске"},
  ];

  Future<void> redemptionPass(String barcode) async {
    final id = barcode.substring(3, 3 + int.parse(barcode.substring(2, 3)));
    final url = Uri.parse(
        '${API.prefixURL}do_pass_done.php?id=$id&token=${global.token}');
    //print(url);
    try {
      final response = await http.get(
        url,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> loadInfo(String barcode) async {
    //print(barcode);
    String s;
    final id = barcode.substring(3, 3 + int.parse(barcode.substring(2, 3)));
    final url = Uri.parse(
        '${API.prefixURL}get_pass_info.php?id=$id&token=${global.token}');
    //print(url);
    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        final loadJson = json.decode(response.body)[0];
        final _loadedInformation = PassItem.fromJson(barcode, loadJson);
        value = _loadedInformation;

        List<PairString> result = [];
          for (var element in description) {
            s = element.keys.toString();

            result.add(PairString(
              text1: element.values
                  .toString()
                  .substring(1, element.values.toString().length - 1),
              text2: value[s.substring(1, s.length - 1)],
            ));
          }
          items = result;
      }
    } catch (error) {
      rethrow;
    }
  }

}
