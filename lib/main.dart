import 'package:flutter/material.dart';
import 'package:hack_mobility/components/spark.dart';
import 'package:hack_mobility/model/app_state.dart';
import 'package:hack_mobility/screen/home.dart';
import 'package:hack_mobility/screen/rank.dart';
import 'package:hack_mobility/screen/together.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppState>(
      model: AppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green
        ),
        home: MyHomePage(title: 'GreenGo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> telas = [
    HomeScreen(),
    Together(),
    Rank(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: telas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            title: new Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.people),
            title: new Text('Ranking'),
          ),
        ],
      ),
    );
  }
}
