import 'package:flutter/material.dart';
import 'package:demo_test/helper/databasehelper.dart';
import 'package:demo_test/screens/employyeelist.dart';
import 'package:demo_test/screens/mart.dart';
import 'package:demo_test/model/dbmodel.dart';
import 'package:demo_test/utils/utils.dart';

class Employee extends StatefulWidget {

  int eid;
  String ename;
  String emobile;
  String eemail;
  Employee(this.eid, this.ename,this.eemail, this.emobile);

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {

  TextEditingController _enameController = TextEditingController();
  TextEditingController _emobileController = TextEditingController();
  TextEditingController _eemailController = TextEditingController();

  DatabaseHelper dbhelper = new DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _enameController.text = widget.ename;
    _emobileController.text = widget.emobile;
    _eemailController.text = widget.eemail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _enameController,
              decoration: (InputDecoration(
                  labelText: "Enter your name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emobileController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: (InputDecoration(
                  labelText: "Enter your mobile-number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _eemailController,
              keyboardType: TextInputType.emailAddress,
              decoration: (InputDecoration(
                  labelText: "Enter your email-id",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)))),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  save();
                  _eemailController.clear();
                  _emobileController.clear();
                  _enameController.clear();
                });
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Dbmodel model = Dbmodel(_enameController.text,
                    _emobileController.text, _eemailController.text);
                update(widget.eid, model);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void save() async {
    int result;
    var nc = _enameController.text;
    var numc = _emobileController.text;
    if (nc == "" || numc == "") {
      Utlis.toastMessage('Please enter Name and Number');
    } else if (numc.length < 10) {
      Utlis.toastMessage('Number should contain 10 Characters');
      } else {
        result = await dbhelper.insert(_enameController.text,
          _emobileController.text, _eemailController.text);
      if (result != 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EmployeeList()));
      }
    }
  }

  void update(int id, Dbmodel model) async {
    int result;
    result = await dbhelper.updateNotes(id, model);
    if (result != 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EmployeeList()));
    }
  }
}
