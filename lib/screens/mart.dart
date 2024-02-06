import 'package:demo_test/screens/martlist.dart';
import 'package:flutter/material.dart';
import 'package:demo_test/helper/databasehelper.dart';
import 'package:demo_test/screens/employyeelist.dart';
import 'package:demo_test/screens/mart.dart';
import 'package:demo_test/model/dbmodel.dart';
import 'package:demo_test/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer';


class Mart extends StatefulWidget {
  @override
  State<Mart> createState() => _MartState();
  String mename;
  Mart(this.mename);
}

class _MartState extends State<Mart> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _mnameController = TextEditingController();
  TextEditingController _mpnameController = TextEditingController();
  TextEditingController _menameController = TextEditingController();

  DatabaseHelper dbhealper = new DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _menameController.text = widget.mename;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _mnameController,
              decoration: InputDecoration(
                  labelText: 'Enter Mart name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _mpnameController,
              decoration: InputDecoration(
                  labelText: 'Enter product name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _menameController,
              decoration: InputDecoration(
                  labelText: 'Enter employee name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    save();
                    _mnameController.clear();
                    _mpnameController.clear();
                    _menameController.clear();
                  });
                },
                child: Text('Save')),
          ],
        ),
      ),
    );
  }

  save() async {
    int result;
    result = await dbhealper.insert(
        _mnameController.text, _mpnameController.text, _menameController.text);
    if (result != 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MartList()));
    }
  }
}