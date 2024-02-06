import 'package:demo_test/screens/employee.dart';
import 'package:flutter/material.dart';
import 'package:demo_test/helper/databasehelper.dart';
import 'package:demo_test/screens/employyeelist.dart';
import 'package:demo_test/screens/mart.dart';
import 'package:demo_test/model/dbmodel.dart';
import 'package:demo_test/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  int count = 0;
  List<Dbmodel> noteList = [];
  DatabaseHelper dbhelper = new DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper = DatabaseHelper();
    loadData();
  }

  loadData() async {
    dbhelper.getNoteList().then((value) {
      log('VAL ::: ${value.length}');
      value.forEach((element) {
        log('element ::: ${element.employee_id}');
        setState(() {
          noteList.add(element);
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('List of Employee'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: noteList.length,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                child: ListTile(
                  trailing: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Mart(noteList[position].employee_name!)));
                        },
                        child: Text(
                          'Go to mart',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: () {
                          setState(() {
                            _deleteNotes(noteList.removeAt(position));
                          });
                        },
                      ),
                    ],
                  ),
                  title: Center(
                      child: Text(noteList[position].employee_name.toString())),
                  subtitle: Container(
                    child: Column(
                      children: [
                        Text(noteList[position].employee_mobile.toString()),
                        Text(noteList[position].employee_email.toString()),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Employee(
                              noteList[position].employee_id!,
                              noteList[position].employee_name!,
                              noteList[position].employee_mobile!,
                              noteList[position].employee_email!,
                            )));
                  },
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Employee(0, '', '', '')));
        },
        child: Center(
            child: Text(
              '+',
            )),
      ),
    );
  }

  void _deleteNotes(Dbmodel model) async {
    int result = await dbhelper!.delete(model.employee_id!);
    if (result != 0) {
      Utlis.toastMessage("Note Deleted Successfully");
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = dbhelper.initDatabase();
    dbFuture.then((dataBase) {
      Future<List> noteListFuture = dbhelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          var noteList = this.noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
