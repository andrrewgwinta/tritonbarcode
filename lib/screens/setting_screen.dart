import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/page_template.dart';
import '../widgets/radio_row_scantype.dart';
import '../providers/session.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/Setting';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('настройки'),
        ),
        body: PageTemplate(
          child: Column(children: [
            RadioRowScanType(),
          ],),
          btnCaption: 'запомнить',
          btnClick: () async {
            await Provider.of<Session>(context, listen: false).saveCurrentSession();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ));
  }
}
