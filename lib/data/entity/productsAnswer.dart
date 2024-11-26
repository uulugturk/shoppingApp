import 'package:bitirme_projesi/data/entity/products.dart';

class ProductsAnswer {
  List<Products> products;
  int success;

  ProductsAnswer({required this.products, required this.success});

  factory ProductsAnswer.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["urunler"] as List;
    int success = json["success"] as int;
    var products = jsonArray
        .map((jsonProductObject) => Products.fromJson(jsonProductObject))
        .toList();
    return ProductsAnswer(products: products, success: success);
  }
}
