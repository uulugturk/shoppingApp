import 'package:bitirme_projesi/data/entity/products.dart';
import 'package:bitirme_projesi/ui/cubit/cartPageCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  final Products product;
  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: Color(0xFF4335A7),
        centerTitle: true,
        toolbarHeight: -8,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      'http://kasimadalan.pe.hu/urunler/resimler/${product.productPicture}',
                      width: double.infinity,
                      height: 400,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Kategori: ${product.productCategory}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        product.productBrand,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4335A7),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        product.productName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 23.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        "1316 Değerlendirme",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26.0),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hızlı Teslimat: ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        TextSpan(
                          text: "2 gün içinde kargoda",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove,
                            color: Color(0xFF4335A7), size: 28),
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        '$_quantity',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.add, color: Color(0xFF4335A7), size: 28),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${product.productPrice} TL",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4335A7),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4335A7),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          context.read<CartPageCubit>().addToCart(
                                product.productName,
                                product.productPicture,
                                product.productCategory,
                                product.productPrice,
                                product.productBrand,
                                _quantity.toString(),
                              );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "${product.productBrand} ${product.productName} sepete eklendi."),
                              duration: Duration(milliseconds: 700),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.shopping_cart, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Sepete Ekle",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 16,
            child: ClipOval(
              child: Material(
                color: Color(0xFF4335A7),
                child: InkWell(
                  splashColor: Colors.white.withOpacity(0.2),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
