import 'package:flutter/material.dart';
import 'package:sqf_lite/dbhelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final dbHelper = DataBaseHelper.instance;

  void insertData() async{
    Map<String,dynamic> row = {
      DataBaseHelper.columnName : "Nisha",
      DataBaseHelper.columnAge : '20',
    };
    final id = await dbHelper.insert(row);
    print(id);
  }

  void queryAll() async {
    var allrows = await dbHelper.queryall();
    allrows.forEach((row) {
      print(row);
    });
  }

  void querySpecific() async {
    var allrows = await dbHelper.queryspecific(18);
    print(allrows);
  }
  
  void delete() async {
    var id = await dbHelper.deletedata(2);
    print(id);
  }

  void update() async {
    var id = await  dbHelper.update(1);
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFLite'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: insertData, child: Text('Insert')),
              ElevatedButton(onPressed: queryAll, child: Text('Query')),
              ElevatedButton(onPressed: querySpecific, child: Text('Query specific')),
              ElevatedButton(onPressed: update, child: Text('Update')),
              ElevatedButton(onPressed: delete, child: Text('Delete')),
            ],
          ),
        ),
      ),
    );
  }
}

