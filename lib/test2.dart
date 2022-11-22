import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

import 'add_product_dialog.dart';
import 'app_data.dart';
import 'data_object.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppStatefulWidgetState();
}

class _MyAppStatefulWidgetState extends State<MyApp> {
  static String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: MyStatefulWidget(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed:  () => dialogBuilder(context),
        //   child: const Text('Open Dialog'),
        // ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  void initState() {
    super.initState();
  }

  // final List<DataObject> _dataObjectList = List.generate(1000, (index) {
  //   return DataObject(item: '');
  // });

  void _recalculate(int rowNum) {
    var item = listProducts[rowNum];
    // recalculate total amount in stock by initial amount plus newly added amount
    item.totalInStock = item.initialAmount + item.addedAmount;

    // recalculate total sold amount by total in stock amount minus amount after shift
    item.totalSold = item.totalInStock - item.afterShift;

    // recalculate total market by product price and total amount sold
    item.totalMarket = item.price * item.totalSold;
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(
            children: [
              DataTable(
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
                rows: List<DataRow>.generate(listProducts.length, (int index) {
                  var product = listProducts[index];

                  return DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // All rows will have the same selected color.
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      }
                      // Even rows will have a grey color.
                      if (index.isEven) {
                        return Colors.lightBlueAccent.withOpacity(0.1);
                      }
                      return null; // Use default value for other states and odd rows.
                    }),
                    cells: <DataCell>[
                      DataCell(Text(product.item)),
                      DataCell(Text(product.measurementUnit)),
                      DataCell(Text(product.price.toString())),
                      DataCell(
                        TextField(
                          readOnly: product.selected,
                          keyboardType: TextInputType.number,
                          onChanged: (String text) {
                            product.initialAmount = int.tryParse(text) ?? 0;
                            _recalculate(index);
                            setState(() {});
                          },
                        ),
                      ),
                      DataCell(
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (String text) {
                            product.addedAmount = int.tryParse(text) ?? 0;
                            _recalculate(index);
                            setState(() {});
                          },
                        ),
                      ),
                      DataCell(Text(product.totalInStock.toString())),
                      DataCell(
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (String text) {
                            product.afterShift = int.tryParse(text) ?? 0;
                            _recalculate(index);
                            setState(() {});
                          },
                        ),
                      ),
                      DataCell(Text(product.totalSold.toString())),
                      DataCell(Text(product.totalMarket.toString())),
                    ],
                    selected: product.selected,
                    onSelectChanged: (bool? value) {
                      product.selected = value!;
                      setState(() {
                        // selected[index] = value!;
                      });
                    },
                  );
                }),
              ),
              Positioned(
                top: 10,
                right: 20,
                child: OutlinedButton(
                  onPressed: () =>
                      dialogBuilder(context, (DataObject dataObject) {
                        listProducts.add(dataObject);
                        setState(() {});
                      }),
                  child: const Text('Open Dialog'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
