import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  final Widget? child;
  final String? btnCaption;
  final Function()? btnClick;

  const PageTemplate({Key? key, this.child, this.btnCaption, this.btnClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: SizedBox(
                  width: double.infinity, child: child)),
          Container(
            padding: const EdgeInsets.all(4),
            height: 45,
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                btnCaption ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: btnClick,
            ),
          )
        ],
      ),
    );
  }
}

// children: [
//   Expanded(
//       child: Column(
//     mainAxisAlignment: MainAxisAlignment.end,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Container(
//         padding: const EdgeInsets.all(4),
//         height: 35,
//         width: double.infinity,
//         child: ElevatedButton(
//           child: Text(
//             btnCaption ?? '',
//             style: const TextStyle(color: Colors.white),
//           ),
//           onPressed: btnClick,
//         ),
//       ),
//     ],
//),
//])
