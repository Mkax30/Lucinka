import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

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
                      child: Text("1"),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                    child: Center(
                      child: Text("2"),
                    ),
                  ),
                ],
              ),
              title: const Text('Database Test'),
            ),
          ),
          backgroundColor: Colors.black38,
          body: TabBarView(
            children: [
              Center(
                child: Stack(
                  children: [
                    // Text(),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: AppBar(bottom: const TabBar(
            tabs: [
              SizedBox(
                height: 60.0,
                child: Center(
                  child: Text("1"),
                ),
              ),
              SizedBox(
                height: 60.0,
                child: Center(
                  child: Text("2"),
                ),
              ),
            ],
          ),),
        ),
      ),
    );
  }
}
