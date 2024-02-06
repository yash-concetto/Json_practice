import 'package:demo_test/screens/employee.dart';
import 'package:flutter/material.dart';
import 'package:demo_test/helper/databasehelper.dart';
import 'package:demo_test/screens/employyeelist.dart';
import 'package:demo_test/screens/mart.dart';
import 'package:demo_test/model/dbmodel.dart';
import 'package:demo_test/utils/utils.dart';

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
      home: Employee(0 ,'' ,'', ''),
    );
  }
}

