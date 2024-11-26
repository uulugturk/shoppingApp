import 'package:bitirme_projesi/data/entity/productsCart.dart';

class ProductsCartAnswer {
  List<ProductsCart> productsCart;
  int success;

  ProductsCartAnswer({required this.productsCart, required this.success});

  factory ProductsCartAnswer.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["urunler_sepeti"] as List;
    int success = json["success"] as int;
    var productsCart = jsonArray
        .map((jsonProductObject) => ProductsCart.fromJson(jsonProductObject))
        .toList();
    return ProductsCartAnswer(productsCart: productsCart, success: success);
  }
}
