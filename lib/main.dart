import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './helpers/custom_route.dart';
import './providers/session.dart';
import './providers/users.dart';
import './providers/pass.dart';
import './screens/launch_screen.dart';
import './screens/logon_screen.dart';
import './screens/scanner_screen.dart';
import './screens/setting_screen.dart';
import './screens/order_screen.dart';
import './screens/pass_screen.dart';
import '../globals.dart' as global;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Session()),
        ChangeNotifierProvider(create: (ctx) => Users()),
        ChangeNotifierProvider(create: (ctx) => Pass()),
      ],
      child: Consumer<Session>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Тритон-сервис.Штрих коды',
          theme: ThemeData(
            //brightness: Brightness.dark,
            //primarySwatch: Palette.kDackColor,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            }),
          ),
          routes: {
            '/': (ctx) => (global.starting)
                ? LaunchScreen()
                : (global.token == '')
                    ? LogonScreen()
                    : ScannerScreen(),
            //'/': (ctx) => ScannerScreen(),
            LogonScreen.routeName: (ctx) => LogonScreen(),
            LaunchScreen.routeName: (ctx) => LaunchScreen(),
            ScannerScreen.routeName: (ctx) => ScannerScreen(),
            SettingScreen.routeName: (ctx) => SettingScreen(),
            OrderInformation.routeName: (ctx) => OrderInformation(),
            PassScreen.routeName: (ctx) => PassScreen(),
          },
        ),
      ),
    );
  }
}
