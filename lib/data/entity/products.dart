class Products {
  String productId;
  String productName;
  String productPicture;
  String productCategory;
  String productPrice;
  String productBrand;
  String orderQuantity;
  String userName;

  Products({
    required this.productId,
    required this.productName,
    required this.productPicture,
    required this.productCategory,
    required this.productPrice,
    required this.productBrand,
    required this.orderQuantity,
    required this.userName,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      productId: json["id"].toString(),
      productName: json["ad"] as String,
      productPicture: json["resim"] as String,
      productCategory: json["kategori"] as String,
      productPrice: json["fiyat"].toString(),
      productBrand: json["marka"] as String,
      orderQuantity: json["siparisAdeti"].toString(),
      userName: json["kullaniciAdi"].toString(),
    );
  }
}
