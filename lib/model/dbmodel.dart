class Dbmodel {

  String? _employee_name;
  int? _employee_id;
  String? _employee_mobile;
  String? _employee_email;

  Dbmodel(this._employee_name, this._employee_mobile, this._employee_email);

  String? get employee_name => _employee_name;

  int? get employee_id => _employee_id;

  String? get employee_mobile => _employee_mobile;

  String? get employee_email => _employee_email;

  Dbmodel.fromMap(Map<String, dynamic> res) {
    _employee_id = res['employeeid'];
    _employee_name = res['employeename'];
    _employee_mobile = res['employeemobile'];
    _employee_email = res['employeemail'];
  }

  Map<String, Object> toMap() {
    return{
      'employeename' : _employee_name!,
      'employeemobile' : _employee_mobile!,
      'employeemail' : _employee_email!,
    };
  }
}