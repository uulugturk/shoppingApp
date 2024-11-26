import 'dart:convert';
import 'package:bitirme_projesi/data/entity/userManager.dart';
import 'package:http/http.dart' as http;
import 'package:bitirme_projesi/data/entity/products.dart';
import 'package:bitirme_projesi/data/entity/productsAnswer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitirme_projesi/data/entity/productsCart.dart';
import 'package:bitirme_projesi/data/entity/productsCartAnswer.dart';

class ProductsDaoRepository {
  List<Products> parseProductsAnswer(String answer) {
    return ProductsAnswer.fromJson(json.decode(answer)).products;
  }

  List<ProductsCart> parseProductsCartAnswer(String cartAnswer) {
    return ProductsCartAnswer.fromJson(json.decode(cartAnswer)).productsCart;
  }

  Future<List<Products>> uploadProducts() async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php");
    var answer = await http.get(url);
    return parseProductsAnswer(answer.body);
  }

  Future<void> addToCart(
      String productCartName,
      String productCartPicture,
      String productCartCategory,
      String productCartPrice,
      String productCartBrand,
      String orderQuantity) async {
    final prefs = await SharedPreferences.getInstance();
    final userManager = UserManager();
    String? userName = await userManager.getUserName();

    if (userName == null) {
      throw Exception("Kullanıcı Adı Bulunamadı");
    }

    var url = Uri.parse("http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php");
    var data = {
      "ad": productCartName,
      "resim": productCartPicture,
      "kategori": productCartCategory,
      "fiyat": productCartPrice,
      "marka": productCartBrand,
      "siparisAdeti": orderQuantity,
      "kullaniciAdi": userName,
    };
    var cartAnswer = await http.post(url, body: data);
  }

  Future<List<ProductsCart>> getCart() async {
    final userManager = UserManager();
    String? userName = await userManager.getUserName();

    if (userName == null) {
      throw Exception("Kullanıcı adı bulunamadı!");
    }

    var url = Uri.parse(
        "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php");
    var data = {"kullaniciAdi": userName};

    try {
      var cartAnswer = await http.post(url, body: data);

      return parseProductsCartAnswer(cartAnswer.body);
    } catch (e) {
      return [];
    }
  }

  Future<void> delete(
    int cartId,
  ) async {
    final userManager = UserManager();
    String? userName = await userManager.getUserName();

    if (userName == null) {
      throw Exception("Kullanıcı adı bulunamadı!");
    }

    var url = Uri.parse("http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php");
    var data = {
      "sepetId": cartId.toString(),
      "kullaniciAdi": userName,
    };
    var response = await http.post(url, body: data);
  }
}
