import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageTemplate extends StatelessWidget {
  //final bool showButton;
  final String? btnCaption;
  final Function()? btnClick;
  final Widget child;

  const PageTemplate({
    Key? key,
    required this.child,
    required this.btnCaption,
    this.btnClick,
    //required this.list,
  }) : super(key: key);

  //final List list;
  //MainMenu(list: list)

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          'assets/images/bg_image2.jpg',
          fit: BoxFit.fitHeight,
        ),
        Scaffold(
          //bottomSheet: Text(';ggg'),
          bottomNavigationBar: (btnCaption == '')? const SizedBox(width: 1, height: 1,) :Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ElevatedButton(
                  child: Text(btnCaption!),
                  onPressed: btnClick,
                )),
              ],
            ),
          ),

          appBar: AppBar(
            title: const Text('Тритон-сервис. Штрих-коды'),
            elevation: 0.0,
            backgroundColor: const Color(0xFFB4C56C).withOpacity(0.5),
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Center(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 6.0,
                  sigmaY: 6.0,
                ),
                child: child,
              ),
            ),
          ),
        )
      ],
    );
  }
}
