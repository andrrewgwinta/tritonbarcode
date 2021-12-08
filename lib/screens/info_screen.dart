import 'package:dackservice/widgets/page_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/furnitures_detail.dart';
import '../providers/order_information.dart';
import '../providers/pass.dart';
import '../utilities.dart';

class InfoScreenParameter {
  final String barcode;
  final ScannerInfoType scannerInfoType;

  InfoScreenParameter({required this.scannerInfoType, required this.barcode});
}

class InfoScreen extends StatefulWidget {
  static const routeName = '/screeninfo';

  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool isInit = true;
  late InfoScreenParameter parameter;

  //late String passId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      //print('didChangeDependencies');
      parameter =
          ModalRoute.of(context)?.settings.arguments as InfoScreenParameter;
      //passId = info.substring(3, 3 + int.parse(info.substring(2, 3)));
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        child: Card(
          elevation: 12,
          shape: kShapeBorderNoSide,
          color: Palette.kDackColor.shade100.withOpacity(0.5),
          child: ShowingData(parameter: parameter),
        ),
        btnCaption: (parameter.scannerInfoType == ScannerInfoType.sitPass)
            ? 'отметить выезд ( в БД Тритон)'
            : 'продолжить сканирование',
        btnClick: () {
          if (parameter.scannerInfoType == ScannerInfoType.sitPass) {
            Provider.of<Pass>(context, listen: false)
                .redemptionPass(parameter.barcode)
                .then((_) => Navigator.of(context).pop());
          } else {
            Navigator.of(context).pop();
          }
        });
  }
}

class ShowingData extends StatelessWidget {
  //final ScannerInfoType scannerInfoType;
  //final String barcode;
  final InfoScreenParameter parameter;

  const ShowingData({required this.parameter});

  @override
  Widget build(BuildContext context) {
    print('${parameter.scannerInfoType}');
    return FutureBuilder(
      future: (parameter.scannerInfoType == ScannerInfoType.sitPass)
          ? Provider.of<Pass>(context, listen: false)
              .loadInfo(parameter.barcode)
          : (parameter.scannerInfoType == ScannerInfoType.sitCalculation)
              ? Provider.of<OrderInformation>(context, listen: false)
                  .loadInfo(parameter.barcode)
              : Provider.of<Detail>(context, listen: false)
                  .loadInfo(parameter.barcode),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          //return Consumer<(parameter.scannerInfoType == ScannerInfoType.sitPass)?Pass:OrderInformation>
          if (parameter.scannerInfoType == ScannerInfoType.sitPass) {
            return Consumer<Pass>
              (builder: (ctx, infoData, child) => ConsumerBuilder(items:infoData.items));
          }
          else
          if (parameter.scannerInfoType == ScannerInfoType.sitCalculation) {
            return Consumer<OrderInformation>
              (builder: (ctx, infoData, child) => ConsumerBuilder(items:infoData.items));
          }
          if (parameter.scannerInfoType == ScannerInfoType.sitSaw) {
            return Consumer<Detail>
              (builder: (ctx, infoData, child) => ConsumerBuilder(items:infoData.items));
          }
          else {
            return const Center(child:Text('что-то не так!!!'));
          }

        }
      },
    );
  }
}

class ConsumerBuilder extends StatelessWidget {
  final List<PairString> items;
  const ConsumerBuilder({
    Key? key,
    required this.items,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(18.0),
          child: (items.isNotEmpty)?ListView.builder(
            //itemCount: infoData.items.length,
            itemCount: items.length,
            itemBuilder: (ctx, index) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  //infoData.items[index].text1,
                  items[index].text1,
                  style: TextStyle(color: Palette.kDackColor[600]),
                ),
                Text(
                  //infoData.items[index].text2,
                  items[index].text2,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    //color: Palette.kDackColor[600],
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
          :const Center(child: Text('КОД НЕ РАСПОЗНАН', style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            //color: Palette.kDackColor[600],
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),),)
      ,
        );
  }
}
