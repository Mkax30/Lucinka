import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Lucinka 1.0';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // themeMode: ,
      title: _title,
      theme: ThemeData.dark(),
      home: const MyStatefulWidget(),
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

    int totalSold;
    int market;
    if (_afterShiftControllerField[rowNum].text == "") {
      totalSold = 0;
      market = 0;
    } else {
      // recalculate total sold amount by total in stock amount minus amount after shift
      totalSold =
          (int.tryParse(_totalInStockControllerField[rowNum].text) ?? 0) -
              (int.tryParse(_afterShiftControllerField[rowNum].text) ?? 0);
      // recalculate total market by product price and total amount sold
      market = _listProducts[rowNum].price * totalSold;
    }
    _totalSoldControllerField[rowNum].text = totalSold.toString();
    _totalMarketControllerField[rowNum].text = market.toString();
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromRGBO(50, 48, 66, 255),
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
              Center(
                child: Stack(
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
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
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
                                  DataCell(
                                    Text(
                                      _listProducts[index].item,
                                    ),
                                    /*onLongPress: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Upozornění'),
                                        content:
                                            const Text('Založit nový produkt?'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Zrušit'),
                                            child: const Text('Zrušit'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                  ),
                                  DataCell(Text(
                                      _listProducts[index].measurementUnit)),
                                  DataCell(Text(
                                      _listProducts[index].price.toString())),
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
                                      controller:
                                          _addedAmountControllerField[index],
                                      keyboardType: TextInputType.number,
                                      onChanged: (String text) {
                                        setState(() {
                                          _recalculate(index);
                                        });
                                      },
                                      readOnly: selected[index],
                                    ),
                                  ),
                                  DataCell(Text(
                                      _totalInStockControllerField[index]
                                          .text)),
                                  DataCell(
                                    TextField(
                                      controller:
                                          _afterShiftControllerField[index],
                                      keyboardType: TextInputType.number,
                                      onChanged: (String text) {
                                        setState(() {
                                          _recalculate(index);
                                        });
                                      },
                                      readOnly: selected[index],
                                    ),
                                  ),
                                  DataCell(Text(
                                      _totalSoldControllerField[index].text)),
                                  DataCell(Text(
                                      _totalMarketControllerField[index].text)),
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
                    const Text("O KURWA!")
                  ],
                ),
              ),
              Center(
                child: ListView(
                  children: const [
                    Text("Marťas "),
                    Text("Terka "),
                    Text("Eva "),
                  ],
                ),
              ),
              /*Center(
                child: */
              Stack(
                children: [
                  Positioned(
                    top: 200,
                    left: 340,
                    child: TextButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(200)),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(15)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlue),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(50, 48, 66, 255)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.lightBlue)))),
                      onPressed: () => const AlertDialog(
                        title: Text('Kurva'),
                        content: Text('just dialog kurva'),
                      ),
                      child:
                          const Text("Marťas", style: TextStyle(fontSize: 26)),
                    ),
                  ),
                  Positioned(
                    top: 262,
                    left: 340,
                    child: TextButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(200)),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(15)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.lightBlue)))),
                      onPressed: () {},
                      child:
                          const Text("Terka", style: TextStyle(fontSize: 26)),
                    ),
                  ),
                  Positioned(
                    top: 324,
                    left: 340,
                    child: TextButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromWidth(200)),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(15)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.lightBlue)))),
                      onPressed: () {},
                      child: const Text("Eva", style: TextStyle(fontSize: 26)),
                    ),
                  ),
                ],
              ),
              // ),
              // Center(
              //   child: Column(
              //     children: <Widget>[
              /*GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,*/
              Stack(
                children: <Widget>[
                  Positioned(
                    top: 70,
                    left: 200,
                    height: 55,
                    width: 250,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 5,
                        ),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "Název produktu",
                            hintStyle: TextStyle(color: Colors.lightBlue)),
                        onChanged: (String text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 460,
                    height: 55,
                    width: 250,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 5,
                        ),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "MJ",
                            hintStyle: TextStyle(color: Colors.lightBlue)),
                        onChanged: (String text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 720,
                    height: 55,
                    width: 250,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 5,
                        ),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "Cena",
                            hintStyle: TextStyle(color: Colors.lightBlue)),
                        keyboardType: TextInputType.number,
                        onChanged: (String text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 135,
                    left: 720,
                    height: 55,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Upozornění'),
                          content: const Text('Založit nový produkt?'),
                          actions: <Widget>[
                            /*Positioned(
                              top: 50,
                              left: 20,
                              height: 30,
                              width: 60,
                              child: */
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, 'Zrušit'),
                              child: const Text('Zrušit'),
                              // ),
                            ),
                            /*Positioned(
                              top: 50,
                              right: 20,
                              height: 30,
                              width: 60,
                              child: */
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                            // ),
                          ],
                        ),
                      ),
                      child: const Text('Uložit'),
                    ),
                  ),
                ],
              ),
              /*Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Název produktu',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'název produktu';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Název produktu2',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'název produktu2';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (_formKey.currentState!.validate()) {
                                  // Process data.
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),*/
              // ],
              // ),
              // ),

              /*Stack(
                  children: const [
                    Text("O KURWA!"),
                    Text("O KURccccWA!"),
                    Positioned(
                      top: 324,
                      left: 340,
                      child: Text("O ddddddddd!")

                    ),


                  ],

              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
