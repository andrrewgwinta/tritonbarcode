import 'dart:async';
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart' as global;
import '../utilities.dart';

class Session with ChangeNotifier {
  Future<void> loadSavedSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    global.userId = preferences.getString('userId') ?? '';
    global.userName = preferences.getString('userName') ?? '';
    global.serverName = '91.237.235.227:8012';
    global.scannerInfoType = ScannerInfoType
        .values[int.parse(preferences.getString('scannerInfoType') ?? '0')];
    //print('load last session ${global.userId}');

  }

  Future<void> loadSavedFilter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

  }

  Future<void> saveCurrentSession() async {
    //print('save session ${global.userId}');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userId', global.userId);
    preferences.setString('userName', global.userName);
    preferences.setString('serverName', global.serverName);
    preferences.setString('scannerInfoType', global.scannerInfoType.index.toString());
    notifyListeners();
  }

  void setServerName(String value) {
    global.serverName = value;
  }
}
