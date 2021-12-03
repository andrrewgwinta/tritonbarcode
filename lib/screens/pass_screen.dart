import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pass.dart';
import '../utilities.dart';
import '../widgets/page_template.dart';

class PassScreen extends StatefulWidget {
  static const routeName = '/passinfo';

  const PassScreen({Key? key}) : super(key: key);

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  bool isInit = true;
  late String info;
  late String passId;

  final description = [
    {"id": "регистрационный номер"},
    {"num": "номер пропуска"},
    {"date": "дата выдачи "},
    {"worker": "водитель/сотрудник"},
    {"cargo": "груз"},
    {"author": "фофрмил"},
    {"car": "автомобиль "},
  ];

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      print('didChangeDependencies');
      info = ModalRoute.of(context)?.settings.arguments as String;
      passId = info.substring(3, 3 + int.parse(info.substring(2, 3)));
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('build passid=$passId');
    // final provider = Provider.of<Pass>(context, listen: false);
    // provider.loadInfo(passId);
    // List<PairString> items = provider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('пропуск $passId'),
      ),
      body: PageTemplate(
        child: Card(
          elevation: 12,
          shape: kShapeBorderNoSide,
          color: kDialogBackGround,
          child: PassInfo(id: passId),
        ),
        btnCaption: 'отметить выезд ( в БД Тритон)',
        btnClick: () {
          Provider.of<Pass>(context, listen: false)
              .redemtionPass(passId)
              .then((_) => Navigator.of(context).pop());
        },
      ),
    );
  }
}

class PassInfo extends StatelessWidget {
  final String id;

  const PassInfo({required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Pass>(context, listen: false).loadInfo(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<Pass>(
              builder: (ctx, passData, child) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: passData.items.length,
                      itemBuilder: (ctx, index) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(passData.items[index].text1),
                          Text(
                            passData.items[index].text2,
                            maxLines: 5,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        }
      },
    );
  }
}
