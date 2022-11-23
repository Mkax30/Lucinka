import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Lucinka 1.0';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class DataObject {
  String item;
  String measurementUnit;
  int price;

  DataObject(
      {required this.item, required this.measurementUnit, required this.price});
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const int numItems = 16;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  final List<TextEditingController> _initialAmountControllerField =
      List.generate(numItems, (i) => TextEditingController());
  final List<TextEditingController> _addedAmountControllerField =
      List.generate(numItems, (i) => TextEditingController());
  final List<TextEditingController> _totalInStockControllerField =
      List.generate(numItems, (i) => TextEditingController());
  final List<TextEditingController> _afterShiftControllerField =
      List.generate(numItems, (i) => TextEditingController());
  final List<TextEditingController> _totalSoldControllerField =
      List.generate(numItems, (i) => TextEditingController());
  final List<TextEditingController> _totalMarketControllerField =
      List.generate(numItems, (i) => TextEditingController());

  // final List<DataObject> _dataObjectList = List.generate(1000, (index) {
  //   return DataObject(item: '');
  // });

  final _listProducts = <DataObject>[
    DataObject(item: "Caipiroshka", measurementUnit: "ks", price: 80),
    DataObject(item: "Chupito", measurementUnit: "ks", price: 45),
    DataObject(item: "Chameleon", measurementUnit: "ks", price: 50),
    DataObject(item: "Virgin chameleon", measurementUnit: "ks", price: 45),
    DataObject(item: "Džbánky XL", measurementUnit: "ks", price: 330),
    DataObject(item: "XL Maxi kýbl", measurementUnit: "ks", price: 999),
    DataObject(item: "Morgan s colou", measurementUnit: "ks", price: 5),
    DataObject(item: "Tuzemák s colou", measurementUnit: "ks", price: 60),
    DataObject(item: "Gin s tonicem", measurementUnit: "ks", price: 60),
    DataObject(item: "Bavorák", measurementUnit: "ks", price: 24),
    DataObject(item: "Vodka s džusem", measurementUnit: "ks", price: 25),
    DataObject(item: "Beton", measurementUnit: "ks", price: 10),
    DataObject(item: "Železobeton", measurementUnit: "ks", price: 26),
    DataObject(item: "Záloha lahev", measurementUnit: "ks", price: 3),
    DataObject(item: "Doplatek", measurementUnit: "kč", price: 1),
    DataObject(item: "Gril", measurementUnit: "kč", price: 1),
  ];

  /*void _initializeValues(int rowNum){
    _totalInStockControllerField[rowNum].text = "0";
    _totalSoldControllerField[rowNum].text = "0";
    _totalMarketControllerField[rowNum].text = "0";
  }*/
  void _recalculate(int rowNum) {
    // recalculate total amount in stock by initial amount plus newly added amount
    var sum = (int.tryParse(_initialAmountControllerField[rowNum].text) ?? 0) +
        (int.tryParse(_addedAmountControllerField[rowNum].text) ?? 0);
    _totalInStockControllerField[rowNum].text = sum.toString();

    // recalculate total sold amount by total in stock amount minus amount after shift
    var total = (int.tryParse(_totalInStockControllerField[rowNum].text) ?? 0) -
        (int.tryParse(_afterShiftControllerField[rowNum].text) ?? 0);
    _totalSoldControllerField[rowNum].text = total.toString();

    // recalculate total market by product price and total amount sold
    var market = _listProducts[rowNum].price *
        (int.tryParse(_totalSoldControllerField[rowNum].text) ?? 0);
    _totalMarketControllerField[rowNum].text = market.toString();
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              bottom: const TabBar(
                tabs: [
                  SizedBox(
                    height: 60.0,
                    child: Center(
                      child: Text("TRŽBA"),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                    child: Center(
                      child: Text("PŘEPNOUT UŽIVATELE"),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                    child: Center(
                      child: Text("ADMINISTRACE"),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                    child: Center(
                      child: Text("NÁPOVĚDA"),
                    ),
                  ),
                ],
              ),
              title: const Text('Lucinka Beta 0.1'),
            ),
          ),
          body: TabBarView(
            children: [
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      horizontalMargin: 100,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Zboží')),
                        DataColumn(label: Text('MJ')),
                        DataColumn(label: Text('Cena')),
                        DataColumn(label: Text('Začátek')),
                        DataColumn(label: Text('Dodáno')),
                        DataColumn(label: Text('Celkem')),
                        DataColumn(label: Text('Konec')),
                        DataColumn(label: Text('Prodáno')),
                        DataColumn(label: Text('Tržba'))
                      ],
                      rows: List<DataRow>.generate(
                        numItems,
                        (int index) => DataRow(
                          color: MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                            // All rows will have the same selected color.
                            if (states.contains(MaterialState.selected)) {
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(1);
                            }
                            // Even rows will have a grey color.
                            if (index.isEven) {
                              return Colors.blueAccent.withOpacity(0.1);
                            }
                            return null; // Use default value for other states and odd rows.
                          }),
                          cells: <DataCell>[
                            DataCell(Text(_listProducts[index].item)),
                            DataCell(
                                Text(_listProducts[index].measurementUnit)),
                            DataCell(
                                Text(_listProducts[index].price.toString())),
                            DataCell(
                              TextField(
                                controller:
                                    _initialAmountControllerField[index],
                                keyboardType: TextInputType.number,
                                onChanged: (String text) {
                                  setState(() {
                                    _recalculate(index);
                                  });
                                },
                                readOnly: selected[index],
                              ),
                            ),
                            DataCell(
                              TextField(
                                controller: _addedAmountControllerField[index],
                                keyboardType: TextInputType.number,
                                onChanged: (String text) {
                                  setState(() {
                                    _recalculate(index);
                                  });
                                },
                                readOnly: selected[index],
                              ),
                            ),
                            DataCell(
                                Text(_totalInStockControllerField[index].text)),
                            DataCell(
                              TextField(
                                controller: _afterShiftControllerField[index],
                                keyboardType: TextInputType.number,
                                onChanged: (String text) {
                                  setState(() {
                                    _recalculate(index);
                                  });
                                },
                                readOnly: selected[index],
                              ),
                            ),
                            DataCell(
                                Text(_totalSoldControllerField[index].text)),
                            DataCell(
                                Text(_totalMarketControllerField[index].text)),
                          ],
                          selected: selected[index],
                          onSelectChanged: (bool? value) {
                            setState(() {
                              // _recalculate(index);
                              selected[index] = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Icon(Icons.directions_transit),
              const Icon(Icons.directions_bike),
              const Text("no fuj"),
            ],
          ),
        ),
      ),
    );
  }
}
