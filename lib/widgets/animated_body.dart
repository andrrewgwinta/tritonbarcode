import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AnimatedBody extends StatefulWidget {
  @override
  State<AnimatedBody> createState() => _AnimatedBodyState();
}

class _AnimatedBodyState extends State<AnimatedBody> {

  final testBackGroud = Color(0xffcfcfff);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(alignment: AlignmentDirectional.topCenter, children: [
      Container(
        height: 250,
        width: 250,
        //color: Colors.grey,
         child: SvgPicture.asset('assets/images/barcode.svg'),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        //child: SizedBox(width: 1,),
         child: Container(
           width: 350,
           height: 40,
           color: Colors.blue.withOpacity(0.01),
           child: SizedBox(width: 1,),
        ),
      ),
    ]));
  }
}
