import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './globals.dart' as global;
import '../widgets/dialog_single_choice.dart';

const kDackGray = Color.fromRGBO(154, 152, 162, 1);
const kDackGreen1 = Color.fromRGBO(146, 192, 62, 1);
const kDackGreen2 = Color.fromRGBO(145, 192, 69, 1);
const kDackGreen3 = Color.fromRGBO(150, 190, 69, 1);
const kDackGreenLight = Color.fromRGBO(174, 208, 110, 1);

const kFieldBackGroud = Color(0xFFcfcfcf);
const kDialogBackGround = Color(0xFFddddff);
const kFieldBorder = Color(0xFF9999ff);
const kFieldText = Color(0xFF484f2b);
//const kFieldLabelText = Color(0xFF8080ff);
const kFieldLabelText =  Color(0xFF242716);
const kIconColor = Color(0xFF0000b3);
const kShapeBorder = RoundedRectangleBorder(
    side: BorderSide(color:Colors.blueGrey, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(15.0)));

const kShapeBorderNoSide = RoundedRectangleBorder(
    //side: BorderSide(color:Colors.blueGrey, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(25.0)));

const kDialogElevation = 24.0;

enum ScannerInfoType {
  sitSaw,
  sitPass,
  sitCalculation,
}

class PairString {
  final String text1;
  final String text2;

  PairString({required this.text1, required this.text2});
}

class NsiRecord {
  final String id;
  final String name;
  late int npp;
  bool checked;

  NsiRecord({this.id = '', this.name = '', this.npp = 0, this.checked = false});

  @override
  String toString() {
    return 'id:$id  name:$name npp:${npp.toString()} checked:${checked.toString()}';
  }

  factory NsiRecord.fromJson(Map<String, dynamic> json) {
    return NsiRecord(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}


class API {
  API() : super();

  // static Map<String, dynamic> get filterToJson => {
  //   'fltOrdNum': global.fltOrdNum,
  //   'fltOrdPerson': global.fltOrdPerson,
  //   'fltOrdNum1c': global.fltOrdNum1C,
  //   'fltDateType': global.fltDateType.index.toString(),
  //   'fltMachineType': global.fltMachineType.index.toString(),
  //   'filterDate': DateFormat.yMd('ru').format(global.filterDate),
  //   'machineId': global.machineId,
  //   'token': global.token,
  // };

  static String get prefixURL {
    if ((global.serverName == null) || (global.serverName.trim() == '')) {
      return 'http://91.237.235.227:8012/bcode/';
    } else {
      return 'http://${global.serverName}/bcode/';
    }
  }

  static BoxDecoration kOrdArticleDecoration() {
    return BoxDecoration(
        border: Border.all(color: kFieldBorder, width: 1),
        color: kFieldBackGroud,
        borderRadius: BorderRadius.circular(10));
  }

  static BoxDecoration kBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: kFieldBorder, width: 1),
        color: kFieldBackGroud,
        borderRadius: BorderRadius.circular(10));
  }

  static BoxDecoration kCardDecoration() {
    return BoxDecoration(
        // border: Border.all(color: kFieldBorder, width: 1),
        // color: kFieldBackGroud,
        borderRadius: BorderRadius.circular(10));
  }

  static InputDecoration kInputDecoration([String text = '']) {
    return InputDecoration(
      //prefixStyle: TextStyle(color: Colors.amberAccent),
      //labelText: text,
      hintText: text,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding:
      const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
    );
  }

//   static choiseMachineDialog(BuildContext context, ChoiseType ct, bool twicePop,
//       Function(String) clickOK) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return DialogSingleChoise(
//           choiseType: ct,
//           twicePop: twicePop,
//           value: global.machineId,
//           pressOK: clickOK,
//         );
//       },
//     );
//   }
//
  static choiceUserDialog(BuildContext context, Function(String) clickOK) {

      showDialog(
        context: context,
        builder: (context) {
          return DialogSingleChoise(
            //choiseType: ChoiseType.ctUser,
            //twicePop: false,
            value: global.userId,
            pressOK: clickOK,
          );
        },
      );

  }
 }

class Palette {
  static const MaterialColor kDackColor = MaterialColor(
    0xFFb4c56c,
    // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFa2b161), //10%
      100: Color(0xFF909e56), //20%
      200: Color(0xFF7e8a4c), //30%
      300: Color(0xFF6c7641), //40%
      400: Color(0xFF5a6336), //50%
      500: Color(0xFF484f2b), //60%
      600: Color(0xFF363b20), //70%
      700: Color(0xFF242716), //80%
      800: Color(0xFF12140b), //90%
      900: Color(0xFF000000), //100%
    },
  );
}

const kTextStylePopUp = TextStyle(
  color: Colors.blue,
  fontSize: 18,
  overflow: TextOverflow.ellipsis,
);

