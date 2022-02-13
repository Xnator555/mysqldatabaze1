import 'package:flutter/material.dart';
import 'package:mysqldatabaze/mysql.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter and Mysql Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var db = new Mysql();
  var mail = '';

  void _getCustomer() {
    db.getConnection().then((conn) {
      String sql = 'select mail from company.people where id = 1;';
      conn.query(sql).then((results) {
        for(var row in results){
          setState(() {
            mail = row[0];
          });
        }
      });
      conn.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'mail:',
            ),
            Text(
              '$mail',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCustomer,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}