class ProductsCart {
  int cartId;
  String productCartName;
  String productCartPicture;
  String productCartCategory;
  String productCartPrice;
  String productCartBrand;
  String orderQuantity;
  String userName;

  ProductsCart({
    required this.cartId,
    required this.productCartName,
    required this.productCartPicture,
    required this.productCartCategory,
    required this.productCartPrice,
    required this.productCartBrand,
    required this.orderQuantity,
    required this.userName,
  });

  factory ProductsCart.fromJson(Map<String, dynamic> json) {
    return ProductsCart(
      cartId: json["sepetId"],
      productCartName: json["ad"] as String,
      productCartPicture: json["resim"] as String,
      productCartCategory: json["kategori"] as String,
      productCartPrice: json["fiyat"].toString(),
      productCartBrand: json["marka"] as String,
      orderQuantity: json["siparisAdeti"].toString(),
      userName: json["kullaniciAdi"].toString(),
    );
  }

  @override
  String toString() {
    return 'ProductsCart(cartId: $cartId, name: $productCartName, picture: $productCartPicture, category: $productCartCategory, price: $productCartPrice, brand: $productCartBrand, quantity: $orderQuantity, user: $userName)';
  }
}
