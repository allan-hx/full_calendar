import 'package:flutter/material.dart';
import 'package:full_calendar/full_calendar.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Calendar(
            value: date,
            min: DateTime(2018),
            max: DateTime(2021),
            onChange: (value) {
              setState(() {
                date = value;
              });
            },
          ),
          // 按钮
          Container(
            padding: EdgeInsets.all(25),
            alignment: Alignment.center,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  date = DateTime(2020, 4, 11);
                });
              },
              child: Text('设置时间'),
            ),
          ),
        ],
      ),
    );
  }
}
