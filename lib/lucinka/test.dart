import 'package:flutter/material.dart';
import 'package:test1/lucinka/dbprovider.dart';
import 'package:test1/lucinka/product_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const int numItems = 16;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  final List<TextEditingController> _productTitleControllerField =
      List.generate(numItems, (i) => TextEditingController());
  final List<TextEditingController> _productPriceControllerField =
      List.generate(numItems, (i) => TextEditingController());
  final List<TextEditingController> _measureUnitControllerField =
      List.generate(numItems, (i) => TextEditingController());
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

  // final List<TextEditingController> _descriptionControllerField =
  //     List.generate(numItems, (i) => TextEditingController());
  // final List<TextEditingController> _description2ControllerField =
  //     List.generate(numItems, (i) => TextEditingController());

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
      market = (int.tryParse(_productPriceControllerField[rowNum].text) ?? 0) *
          totalSold;
    }
    _totalSoldControllerField[rowNum].text = totalSold.toString();
    _totalMarketControllerField[rowNum].text = market.toString();
  }

  final ThemeData _themeData = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Hint',
    primaryColor: Colors.deepPurple,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 58.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 18.0),
      displaySmall: TextStyle(fontSize: 14.0),
      bodyLarge: TextStyle(fontSize: 58.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 18.0),
      bodySmall: TextStyle(fontSize: 14.0),
    ),
    primarySwatch: Colors.deepPurple,
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Colors.deepPurple,
            Colors.deepPurpleAccent,
            Colors.deepPurple
          ]),
          color: Colors.deepPurple[400],
          border: Border(
              top: BorderSide(color: Colors.deepPurple[300]!, width: 1))),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      color: Colors.deepPurple,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  final TextStyle _tabTextStyle = const TextStyle(
    // height: 60,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.white,
  );

  final TextStyle _headerTextStyle = const TextStyle(
    // height: 60,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    // color: Colors.white,
  );

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.orange,
            onPressed: () async {
              await ProductDbProvider.instance.addItem(
                ProductModel(
                  productTitle: _productTitleControllerField[0].text,
                  measureUnit: _measureUnitControllerField[0].text,
                  price:
                      int.tryParse(_productPriceControllerField[0].text) ?? 0,
                  initialAmount:
                      int.tryParse(_initialAmountControllerField[0].text) ?? 0,
                  addedAmount:
                      int.tryParse(_addedAmountControllerField[0].text) ?? 0,
                  totalInStock:
                      int.tryParse(_totalInStockControllerField[0].text) ?? 0,
                  afterShift:
                      int.tryParse(_afterShiftControllerField[0].text) ?? 0,
                  totalSold:
                      int.tryParse(_totalSoldControllerField[0].text) ?? 0,
                  totalMarket:
                      int.tryParse(_totalMarketControllerField[0].text) ?? 0,
                  // description: _descriptionControllerField[0].text,
                  // description2: _description2ControllerField[0].text,
                ),
              );
              setState(() {});
            },
            label: const Text("Přidat Produkt",
                style: TextStyle(color: Colors.black, fontSize: 26)),
            icon: const Icon(Icons.add, color: Colors.black),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              title: const Text('Lucinka 1.0'),
              shape: const Border(
                bottom: BorderSide(color: Colors.white, width: 4),
              ),
              elevation: 8,
              bottom: TabBar(
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                tabs: [
                  Tab(
                    child: Text("TRŽBA", style: _tabTextStyle),
                  ),
                  Tab(
                    child: Text("TRŽBA", style: _tabTextStyle),
                  ),
                  Tab(
                    child: Text("SPRÁVA PRODUKTŮ", style: _tabTextStyle),
                  ),
                  Tab(
                    child: Text("ADMINISTRACE", style: _tabTextStyle),
                  ),
                  Tab(
                    child: Text("NÁPOVĚDA", style: _tabTextStyle),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              // ///////////////////////////////////////////////////////////////
              // tab bar 1
              // ///////////////////////////////////////////////////////////////
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
                            // horizontalMargin: 100,
                            columns: <DataColumn>[
                              DataColumn(
                                  label:
                                      Text("Zboží", style: _headerTextStyle)),
                              DataColumn(
                                  label: Text('MJ', style: _headerTextStyle)),
                              DataColumn(
                                  label: Text('Cena', style: _headerTextStyle)),
                              DataColumn(
                                  label:
                                      Text('Začátek', style: _headerTextStyle)),
                              DataColumn(
                                  label:
                                      Text('Dodáno', style: _headerTextStyle)),
                              DataColumn(
                                  label:
                                      Text('Celkem', style: _headerTextStyle)),
                              DataColumn(
                                  label:
                                      Text('Konec', style: _headerTextStyle)),
                              DataColumn(
                                  label:
                                      Text('Prodáno', style: _headerTextStyle)),
                              DataColumn(
                                  label:
                                      Text('Tržba', style: _headerTextStyle)),
                            ],
                            rows: List<DataRow>.generate(
                              numItems,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(
                                      _productTitleControllerField[index]
                                          .text)),
                                  DataCell(Text(
                                      _measureUnitControllerField[index].text)),
                                  DataCell(Text(
                                      _productPriceControllerField[index]
                                          .text)),
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
                                        setState(
                                          () {
                                            _recalculate(index);
                                          },
                                        );
                                      },
                                      readOnly: selected[index],
                                    ),
                                  ),
                                  DataCell(
                                    Text(_totalSoldControllerField[index].text),
                                  ),
                                  DataCell(
                                    Text(_totalMarketControllerField[index]
                                        .text),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ///////////////////////////////////////////////////////////////
              // tab bar 2
              // ///////////////////////////////////////////////////////////////
              Center(
                child: Column(
                  children: [
                    // Stack(
                    //   children: [
                    FutureBuilder(
                      future: ProductDbProvider.instance.fetchProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ProductModel>> snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: [
                                    // const DataColumn(label: Text('UID')),
                                    DataColumn(
                                        label: Text('Zboží',
                                            style: _headerTextStyle)),
                                    DataColumn(
                                        label: Text('MJ',
                                            style: _headerTextStyle)),
                                    DataColumn(
                                        label: Text('Cena',
                                            style: _headerTextStyle)),
                                    DataColumn(
                                        label: Text('Začátek',
                                            style: _headerTextStyle)),
                                    DataColumn(
                                        label: Text('Dodáno',
                                            style: _headerTextStyle)),
                                    DataColumn(
                                        label: Text('Celkem',
                                            style: _headerTextStyle)),
                                    DataColumn(
                                        label: Text('Konec',
                                            style: _headerTextStyle)),
                                    DataColumn(
                                        label: Text('Prodáno',
                                            style: _headerTextStyle)),
                                    DataColumn(
                                        label: Text('Tržba',
                                            style: _headerTextStyle)),
                                    const DataColumn(label: Text('')
                                        /*label: Row(
                                  children: const <Widget>[
                                    Text("Smazat"),
                                    Icon(Icons.delete_forever),
                                  ],
                                ),*/
                                        ),
                                  ],
                                  rows: List<DataRow>.generate(
                                    snapshot.data!.length,
                                    (int index) => DataRow(
                                      color: MaterialStateProperty.resolveWith<
                                          Color?>((Set<MaterialState> states) {
                                        // Even rows will have a grey color.
                                        if (index.isEven) {
                                          return Colors.deepPurple
                                              .withOpacity(0.07);
                                        }
                                        return null; // Use default value for other states and odd rows.
                                      }),
                                      cells: [
                                        /*DataCell(
                                    SizedBox(
                                      width: 20,
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                        ),
                                        child: Text(snapshot.data![index].id
                                            .toString()),
                                      ),
                                    ),
                                  ),*/
                                        DataCell(
                                          SizedBox(
                                              // width: 20,
                                              child: Text(snapshot
                                                  .data![index].productTitle)),
                                        ),
                                        DataCell(
                                          SizedBox(
                                              // width: 20,
                                              child: Text(snapshot
                                                  .data![index].measureUnit)),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            // width: 20,
                                            child: Text(snapshot
                                                .data![index].price
                                                .toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            // width: 20,
                                            child: Text(snapshot
                                                .data![index].initialAmount
                                                .toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            // width: 20,
                                            child: Text(snapshot
                                                .data![index].addedAmount
                                                .toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            // width: 20,
                                            child: Text(snapshot
                                                .data![index].totalInStock
                                                .toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            // width: 20,
                                            child: Text(snapshot
                                                .data![index].afterShift
                                                .toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            // width: 20,
                                            child: Text(snapshot
                                                .data![index].totalSold
                                                .toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            // width: 20,
                                            child: TextFormField(
                                              controller:
                                                  _totalMarketControllerField[
                                                      index],

                                              // snapshot
                                              // .data![index].totalMarket
                                              // .toString()),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          ElevatedButton(
                                            onPressed: () => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                shadowColor: Colors.deepPurple,
                                                elevation: 8,
                                                backgroundColor:
                                                    Colors.deepPurple[50],
                                                title: const Text('Upozornění'),
                                                content: const Text(
                                                    'Smazat produkt?'),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        30,
                                                                    vertical:
                                                                        10),
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        22)),
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Zrušit'),
                                                    child: const Text('Zrušit'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.red[900],
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 30,
                                                                vertical: 10),
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 22)),
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      await ProductDbProvider
                                                          .instance
                                                          .deleteProductById(
                                                              snapshot
                                                                  .data![index]
                                                                  .id);
                                                      setState(() {});
                                                    },
                                                    child: const Text('Smazat'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            child: Row(
                                              children: const <Widget>[
                                                Text("Smazat"),
                                                Icon(Icons.delete_forever),
                                              ],
                                            ),
                                          ),
                                          onLongPress: () async {
                                            await ProductDbProvider.instance
                                                .deleteProductById(
                                                    snapshot.data![index].id);
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(child: Text("No Data Found."));
                        }
                      },
                    ),
                    // ],
                    // ),
                  ],
                ),
              ),
              // ///////////////////////////////////////////////////////////////
              // tab bar 2a
              // ///////////////////////////////////////////////////////////////
              FutureBuilder(
                future: ProductDbProvider.instance.fetchProducts(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductModel>> snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              // const DataColumn(label: Text('UID')),
                              DataColumn(label: Text('Zboží')),
                              DataColumn(label: Text('MJ')),
                              DataColumn(label: Text('Cena')),
                              DataColumn(label: Text('Začátek')),
                              DataColumn(label: Text('Dodáno')),
                              DataColumn(label: Text('Celkem')),
                              DataColumn(label: Text('Konec')),
                              DataColumn(label: Text('Prodáno')),
                              DataColumn(label: Text('Tržba')),
                              DataColumn(label: Text('')
                                  /*label: Row(
                                  children: const <Widget>[
                                    Text("Smazat"),
                                    Icon(Icons.delete_forever),
                                  ],
                                ),*/
                                  ),
                            ],
                            rows: List<DataRow>.generate(
                              snapshot.data!.length,
                              (int index) => DataRow(
                                cells: [
                                  /*DataCell(
                                    SizedBox(
                                      width: 20,
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                        ),
                                        child: Text(snapshot.data![index].id
                                            .toString()),
                                      ),
                                    ),
                                  ),*/
                                  DataCell(
                                    SizedBox(
                                        // width: 20,
                                        child: Text(snapshot
                                            .data![index].productTitle)),
                                  ),
                                  DataCell(
                                    SizedBox(
                                        // width: 20,
                                        child: Text(
                                            snapshot.data![index].measureUnit)),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      // width: 20,
                                      child: Text(snapshot.data![index].price
                                          .toString()),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      // width: 20,
                                      child: Text(snapshot
                                          .data![index].initialAmount
                                          .toString()),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      // width: 20,
                                      child: Text(snapshot
                                          .data![index].addedAmount
                                          .toString()),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      // width: 20,
                                      child: Text(snapshot
                                          .data![index].totalInStock
                                          .toString()),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      // width: 20,
                                      child: Text(snapshot
                                          .data![index].afterShift
                                          .toString()),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      // width: 20,
                                      child: Text(snapshot
                                          .data![index].totalSold
                                          .toString()),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      // width: 20,
                                      child: Text(snapshot
                                          .data![index].totalMarket
                                          .toString()),
                                    ),
                                  ),
                                  DataCell(
                                    ElevatedButton(
                                      onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Upozornění'),
                                          content:
                                              const Text('Smazat produkt?'),
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
                                            ElevatedButton(
                                                onPressed: () async {
                                                  await ProductDbProvider
                                                      .instance
                                                      .deleteProductById(
                                                          snapshot
                                                              .data![index].id);
                                                  setState(() {});
                                                },
                                                child: const Text('Smazat1'))
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                        children: const <Widget>[
                                          Text("Smazat"),
                                          Icon(Icons.delete_forever),
                                        ],
                                      ),
                                    ),
                                    onLongPress: () async {
                                      await ProductDbProvider.instance
                                          .deleteProductById(
                                              snapshot.data![index].id);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: Text("No Data Found."));
                  }
                },
              ),
              // ///////////////////////////////////////////////////////////////
              // tab bar 3
              // ///////////////////////////////////////////////////////////////
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
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                          // backgroundColor: MaterialStateProperty.all<Color>(
                          //     const Color.fromRGBO(50, 48, 66, 255)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.orange)))),
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
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.orange)))),
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
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.orange)))),
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
              // ///////////////////////////////////////////////////////////////
              // tab bar 4
              // ///////////////////////////////////////////////////////////////
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
                        // color: Colors.orange[200],
                        border: Border.all(
                          color: Colors.orange,
                          width: 5,
                        ),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "Název produktu",
                            hintStyle: TextStyle(color: Colors.orange)),
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
                        color: Colors.orange[200],
                        border: Border.all(
                          color: Colors.orange,
                          width: 5,
                        ),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "MJ",
                            hintStyle: TextStyle(color: Colors.orange)),
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
                        color: Colors.orange[200],
                        border: Border.all(
                          color: Colors.orange,
                          width: 5,
                        ),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "Cena",
                            hintStyle: TextStyle(color: Colors.orange)),
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
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, 'Zrušit'),
                              child: const Text('Zrušit'),
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
