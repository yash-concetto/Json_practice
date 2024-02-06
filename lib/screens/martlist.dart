import 'package:demo_test/model/Dbmodelm.dart';
import 'package:flutter/material.dart';
import 'package:demo_test/helper/databasehelper.dart';
import 'package:demo_test/screens/employyeelist.dart';
import 'package:demo_test/screens/mart.dart';
import 'package:demo_test/model/dbmodel.dart';
import 'package:demo_test/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer';

class MartList extends StatefulWidget {
  const MartList({Key? key}) : super(key: key);

  @override
  State<MartList> createState() => _MartListState();
}

class _MartListState extends State<MartList> {
  int count = 0;
  List<Dbmodel> employeeList = [];
  List<Dbmodelm> martList = [];
  DatabaseHelper dbhelper = new DatabaseHelper();

  loadData() async {
    dbhelper.getEmployeeList().then((value) {
      log('VAL ::: ${value.length}');
      setState(() {
        employeeList = value;
      });
    });
  }

  loadMartData() {
    dbhelper.getMartList().then((value) {
      log('VAL ::::${value.length}');
      setState(() {
        martList = value.cast<Dbmodelm>();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper = DatabaseHelper();
    loadData();
    loadMartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mart-List'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: employeeList.length,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                child: ListTile(
                  title: Center(
                      child: Text(employeeList[position].employee_name!)),
                  subtitle: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(employeeList[position].employee_mobile!),
                        Text(employeeList[position].employee_email!),
                        Text(martList[position].mart_name!),
                        Text(martList[position].product_name!),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
