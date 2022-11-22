import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test1/styles.dart';

// import 'package:testapp/styles.dart';

import 'numberInput.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'kalkulacka'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  TextEditingController textEditingController1 = TextEditingController();

  TextEditingController initialAmountController = TextEditingController();

  List<TextEditingController> initialAmountControllerField = [];

  TextEditingController addedAmountController = TextEditingController();
  TextEditingController totalInStockController = TextEditingController();
  TextEditingController afterShiftController = TextEditingController();
  TextEditingController totalSoldController = TextEditingController();
  TextEditingController totalMarketController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // void _printLatestValue() {
  //   print('Second text field: ${totalInStockController.text}');
  // }

  int _recalculateTotalInStock() {
    var sum = (int.tryParse(initialAmountController.text) ?? 0) +
        (int.tryParse(addedAmountController.text) ?? 0);
    totalInStockController.text = sum.toString();

    return sum;
    // print('Second text field: ${totalInStockController.text}');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final List<String> entries = <String>['A', 'B', 'C', 'D'];
    final List<int> colorCodes = <int>[600, 500, 100, 200];

    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                child: Column(
                  children: [Text("Ahoj"), Text("Ahoj 2")],
                ),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                icon: Icon(Icons.add_card),
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
// mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: textEditingController1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                NumberInput(
                  label: 'aaaaa',
                ),
                Text(">>:" + textEditingController1.text),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                        style: getButtonStyle(
                            backgroundColor:
                                const Color.fromARGB(255, 225, 225, 225)),
                        onPressed: () {
                          var sum =
                              (int.tryParse(textEditingController1.text) ?? 0) +
                                  5;
                          textEditingController1.text = sum.toString();
                          setState(() {});
                        },
                        child: Text(
                          '5',
                          style: TextStyle(fontSize: width * 0.12),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    padding: const EdgeInsets.all(8),
                    children: [
                      TextButton(
                        style: getButtonStyle(
                            backgroundColor:
                                const Color.fromARGB(255, 225, 225, 225)),
                        onPressed: () {
                          var sum =
                              (int.tryParse(textEditingController1.text) ?? 0) +
                                  5;
                          textEditingController1.text = sum.toString();
                          setState(() {});
                        },
                        child: Text(
                          '5',
                          style: TextStyle(fontSize: width * 0.12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Table(
                      border: TableBorder.all(
                        color: Color.fromARGB(120, 220, 180, 255),
                      ),
                      children: [
                        TableRow(children: [
                          Text('Zboží',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('MJ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Cena',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Začátek',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Dodáno',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Celkem',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Konec',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Prodáno',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Tržba',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ]),

                        TableRow(children: [
                          Text('Caipiroshka', textAlign: TextAlign.center),
                          Text('ks', textAlign: TextAlign.center),
                          Text('80', textAlign: TextAlign.center),
                          TextField(
                              controller: initialAmountController,
                              onChanged: (text) {
                                _recalculateTotalInStock();
                                setState(() {});
                              }), // zadat zacatek
                          TextField(
                              controller: addedAmountController,
                              onChanged: (String text) {
                                _recalculateTotalInStock();
                                setState(() {});
                              }), // zadat dodano
                          Text(totalInStockController.text), // spocitat celkem
                          TextField(
                              controller: afterShiftController,
                              onChanged: (String text) {
                                // _recalculateTotalInStock(); // todo kaspar
                                setState(() {});
                              }), // zadat konec
                          Text(totalSoldController.text), // spocitat prodano
                          Text(totalMarketController.text), // spocitat trzba
                        ]),

                        TableRow(children: [
                          Text('Chupito', textAlign: TextAlign.center),
                          Text('ks', textAlign: TextAlign.center),
                          Text('45', textAlign: TextAlign.center),
                          TextField(
                              controller: initialAmountController,
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                _recalculateTotalInStock();
                                setState(() {});
                              }), // zadat zacatek
                          TextField(
                              controller: addedAmountController,
                              keyboardType: TextInputType.number,
                              onChanged: (String text) {
                                _recalculateTotalInStock();
                                setState(() {});
                              }), // zadat dodano
                          Text(totalInStockController.text), // spocitat celkem
                          TextField(
                              controller: afterShiftController,
                              keyboardType: TextInputType.number,
                              onChanged: (String text) {
                                // _recalculateTotalInStock(); // todo kaspar
                                setState(() {});
                              }), // zadat konec
                          Text(totalSoldController.text), // spocitat prodano
                          Text(totalMarketController.text), // spocitat trzba
                        ]),

                        TableRow(children: [
                          Text('Chameleon', textAlign: TextAlign.center),
                          Text('ks', textAlign: TextAlign.center),
                          Text('50', textAlign: TextAlign.center),
                          Text('', textAlign: TextAlign.center),
                          Text('', textAlign: TextAlign.center),
                          Text('', textAlign: TextAlign.center),
                          Text('', textAlign: TextAlign.center),
                          Text('', textAlign: TextAlign.center),
                          Text('', textAlign: TextAlign.center),
                        ]),
                      ],
                    ),
                  ),
                ]),
            // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            const Center(









              child: Text("It's rainy here"),
            ),
            // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 10,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      // crossAxisCount: 1,
                      // crossAxisSpacing: 15,
                      // mainAxisSpacing: 15,
                      padding: const EdgeInsets.all(8),
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(220, 155, 200, 255),
                                ),
                              ),
                              child: Text("Zboží"),
                            ),
                            Text("MJ"),
                            Text("Cena"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Caipiroshka"),
                            Text("ks"),
                            Text("80"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("c1"),
                            Text("c2"),
                            Text("c3"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("c1"),
                            Text("c2"),
                            Text("c3"),
                          ],
                        ),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        /* ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: entries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              color: Colors.amber[colorCodes[index]],
                              child: Center(
                                  child: Text('Entry ${entries[index]}')),

                              */ /*child: Column(
                                children: [
                                  Text('Entry ${entries[index]}'),
                                  Text('Entry ${entries[index]}'),
                                ],
                              ),*/ /*
                            );
                          },
                        ),*/

                        /*TextButton(
                        style: getButtonStyle(
                            backgroundColor:
                                const Color.fromARGB(255, 225, 225, 225)),
                        onPressed: () {
                          var sum =
                              (int.tryParse(textEditingController1.text) ?? 0) +
                                  5;
                          textEditingController1.text = sum.toString();
                          setState(() {});
                        },
                        child: Text(
                          '5',
                          style: TextStyle(fontSize: width * 0.12),
                        ),
                      ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
