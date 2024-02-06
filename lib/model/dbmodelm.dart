class Dbmodelm{

  int? _id;
  String? _mart_name;
  String? _product_name;
  String? _employee_name;

  int? get id => _id;

  String? get mart_name => _mart_name;

  String? get product_name => _product_name;

  String? get employee_name => _employee_name;

  Dbmodelm.friomMap(Map<String, dynamic> res) {
      _id = res['id'];
      _mart_name = res['martname'];
      _product_name = res['productname'];
      _employee_name = res['employeename'];
    }

    Map<String, Object> toMap() {
    return{
      'martname' : mart_name!,
      'productname' : product_name!,
      'employeename' : employee_name!,
     };
  }
}