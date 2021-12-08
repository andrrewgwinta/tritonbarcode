import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as global;
import '../providers/session.dart';
import '../providers/users.dart';
import '../screens/scanner_screen.dart';
import '../utilities.dart';
import '../widgets/page_template.dart';

class LogonScreen extends StatelessWidget {
  static const routeName = '/logon';

  const LogonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text('ВХОД'),
      // ),
      body: Container(
        // decoration: BoxDecoration(
        //   color: Theme.of(context).primaryColor,
        //   image: DecorationImage(
        //    image: Image.asset('assets/image/biesse_start1.png').image,
        //     fit: BoxFit.fitWidth,
        //   ),
        // ),
        child: LogonWidget(),
      ),
    );
  }
}

class LogonWidget extends StatefulWidget {
  const LogonWidget({Key? key}) : super(key: key);

  @override
  _LogonWidgetState createState() => _LogonWidgetState();
}

class _LogonWidgetState extends State<LogonWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _keyboardVisible = false;
  late StreamSubscription<bool> keyboardSubscription;
  String passwordText = '';

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _keyboardVisible = visible;
      });
    });
  }

  // void onClickMch(String value) {
  //   setState(() {
  //     global.machineId = value;
  //     global.machineName =
  //         Provider.of<Machines>(context, listen: false).getNameById(value);
  //     Provider.of<Session>(context, listen: false).saveCurrentSession();
  //   });
  // }

  void onClickUsr(String value) {
    setState(() {
      global.userId = value;
      global.userName =
          Provider.of<Users>(context, listen: false).getNameById(value);
      Provider.of<Session>(context, listen: false).saveCurrentSession();
    });

    print('onClickUsr ${global.userId}');
  }

  void doLogonClick() async {
    final users = Provider.of<Users>(context, listen: false);
    // await users.doLogin(_controller.text).then((_) => if (global.token != '')
    // {Navigator.of(context).pushNamed(OrderOverview.routeName);});

    await users.doLogin(_controller.text).then((value) => (global.token == '')
        ? print('NO')
        : Navigator.of(context).pushReplacementNamed(ScannerScreen.routeName));
  }

  @override
  void dispose() {
    _controller.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  void choiceUsersClick() {
    API.choiceUserDialog(context, onClickUsr);
  }

  @override
  Widget build(BuildContext context) {
    //print('in build logon  ${global.machineId} ${global.userId}');
    bool _emptyUser = (global.userName.trim() == '');
    return PageTemplate(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                child: const Text(
                  'пользователь',
                  style: TextStyle(color: kFieldLabelText),
                )),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 65,
                    decoration: API.kBoxDecoration(),
                    child: Center(
                      child: Text(
                        _emptyUser ? 'выберите пользователя...' : global.userName,
                        style: TextStyle(
                            fontSize: 20,
                            color: _emptyUser ? Colors.white : kFieldText),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.black,
                  onPressed: choiceUsersClick,
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: kFieldText,
                  ),
                )
              ],
            ),
            //password field
            const SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                child: const Text(
                  'пароль',
                  style: TextStyle(color: kFieldLabelText),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                child: Container(
                  decoration: API.kBoxDecoration(),
                  height: 65,
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: _controller,
                    onChanged: (value) => passwordText = value,
                    decoration: API.kInputDecoration(),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 130,
              ),
              _keyboardVisible
                  ? FloatingActionButton(
                      elevation: 1,
                      onPressed: doLogonClick,
                      child: const Icon(Icons.forward,
                          size: 20, color: Colors.white))
                  : const SizedBox(width: 20),
            ]),
          ],
        ),
      ),
      btnCaption: 'продолжить',
      btnClick: doLogonClick,
    );
  }
}
