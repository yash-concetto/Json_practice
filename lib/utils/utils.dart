import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:demo_test/helper/databasehelper.dart';
import 'package:demo_test/screens/employyeelist.dart';
import 'package:demo_test/screens/mart.dart';
import 'package:demo_test/model/dbmodel.dart';
import 'package:demo_test/utils/utils.dart';


class Utlis {
static toastMessage(String message) {
  Fluttertoast.showToast(msg: message, backgroundColor: Colors.teal);
}
}