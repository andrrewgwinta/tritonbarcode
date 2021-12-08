import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utilities.dart';
import '../globals.dart' as global;

const edgeDescription = [
  'нет кромок',
  '1 тонкая',
  '2 тонких',
  '1 толстая',
  '2 толстых',
  '1 толстая + 1 тонкая',
  'торцевая декорация',
  'postform',
  'postform + 1 тонкая',
  '2 пластик-профиль',
  '1 пластик-профиль + 1 тонкая',
  '1 Краска',
  '2 Краска',
  '1 Краска + 1 Тонкая',
  '1 Краска + 1 Толстая'
];

class FurnitureDetail {
  final String barcode;
  final String id;
  final String name;
  final String sizeX;
  final String sizeY;
  final String mainMaterial;
  final String veenerFrontMaterial;
  final String veenerBackMaterial;
  final String edgeX;
  final String edgeY;
  final String orderName;
  final String projectName;

  @override
  String toString(){
    return ('id=$id name=$name');
      }

  FurnitureDetail({
    this.barcode='',
    this.id = '',
    this.name = '',
    this.sizeX = '',
    this.sizeY = '',
    this.mainMaterial = '',
    this.veenerFrontMaterial = '',
    this.veenerBackMaterial = '',
    this.edgeX = '',
    this.edgeY = '',
    this.orderName = '',
    this.projectName = '',
  });

  factory FurnitureDetail.fromJson(String bc, Map<String, dynamic> json) {
    return FurnitureDetail(
        barcode: bc,
        id: json['id'].toString(),
        name: json['name'],
        sizeX: json['sx'].toString(),
        sizeY: json['sy'].toString(),
        mainMaterial: json['am'],
        veenerBackMaterial: json['ab'],
        veenerFrontMaterial: json['af'],
        edgeX: json['ex'].toString(),
        edgeY: json['ey'].toString(),
        orderName: json['ordername'],
        projectName: json['projectname']);
  }

  String operator [](prop) {
    if (prop == 'id')
      return id;
    else if (prop == 'barcode')
      return barcode;
    else if (prop == 'name')
      return name;
    //else if (prop == 'note')
    //   return note;
    else if (prop == 'sizeX')
      return sizeX;
    else if (prop == 'sizeY')
      return sizeY;
    else if (prop == 'mainMaterial')
      return mainMaterial;
    else if (prop == 'veenerFrontMaterial')
      return veenerFrontMaterial;
    else if (prop == 'veenerBackMaterial')
      return veenerBackMaterial;
    else if (prop == 'edgeX')
      return edgeDescription[int.parse(edgeX)];
    else if (prop == 'edgeY')
      return edgeDescription[int.parse(edgeY)];
    else if (prop == 'ordername')
      return orderName;
    else if (prop == 'projectname')
      return projectName;
    else
      return '';
  }
}

class Detail extends  ChangeNotifier {
  FurnitureDetail value = FurnitureDetail();
  List<PairString> items = [];

  final description = [
    {"barcode": "штрих-код"},
    {"id": "регистрационный номер"},
    {"name": "наименование"},
    {"sizeX": "размер X"},
    {"sizeY": "размер Y"},
    {"mainMaterial": "материал"},
    {"veenerFrontMaterial": "покрытие лицевой стороны"},
    {"veenerBackMaterial": "покрытие обратной стороны"},
    {"edgeX": "кромка по X"},
    {"edgeY": "кромка по Y"},
    {"ordername": "заказ"},
    {"projectname": "проект"},
  ];

  @override
  Future<void> loadInfo(String barcode) async {
    List<PairString> result = [];
    String s;

    final url = Uri.parse('${API.prefixURL}get_detail_info.php?bc=$barcode&token=${global.token}');
    print(url);
    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        final loadJson = json.decode(response.body)[0];
        final _loadedInformation = FurnitureDetail.fromJson(barcode, loadJson);
        value = _loadedInformation;

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