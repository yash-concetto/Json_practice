class DbModelp {

  int? _product_id;
  String? _product_name;
  String? _product_price;

  int? get product_id => _product_id;

  String? get product_name => _product_name;

  String? get product_price => _product_price;

  DbModelp.fromMap(Map<String, dynamic> res) {
    _product_id = res['productid'];
    _product_name = res['productname'];
    _product_price = res['price'];
  }

  Map<String , Object> toMap() {
    return {
      'productname' : _product_name!,
      'price' : _product_price!,
    };
  }
}