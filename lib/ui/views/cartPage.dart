import 'package:bitirme_projesi/data/entity/products.dart';
import 'package:bitirme_projesi/data/entity/productsCart.dart';
import 'package:bitirme_projesi/ui/cubit/cartPageCubit.dart';
import 'package:bitirme_projesi/ui/views/categoriesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitirme_projesi/data/repo/productsDaoRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homePage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var prepo = ProductsDaoRepository();
  List<ProductsCart> _cartItems = [];
  int _currentIndex = 3;

  final List<Widget> _pages = [
    HomePage(),
    CartPage(),
    CategoriesPage(),
  ];

  @override
  void initState() {
    _loadCart();
    super.initState();
  }

  Future<void> _loadCart() async {
    try {
      List<ProductsCart> cartItems = await prepo.getCart();
      setState(() {
        _cartItems = cartItems;
      });
    } catch (e) {
      print("Sepet yüklenemedi: $e");
    }
  }

  void removeCartItem(int cartId) {
    setState(() {
      _cartItems.removeWhere((item) => item.cartId == cartId);
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CategoriesPage()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CartPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: Color(0xFF4335A7),
        automaticallyImplyLeading: false,
        title: const Text(
          "Sepetim",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Josefin Sans",
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
      ),
      body: _cartItems.isNotEmpty
          ? ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                var product = _cartItems[index];
                return Dismissible(
                  key: Key(product.cartId.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Sil",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    context
                        .read<CartPageCubit>()
                        .deleteCartItem(product.cartId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "${product.productCartBrand} ${product.productCartName} sepetten silindi."),
                        duration: Duration(milliseconds: 700),
                      ),
                    );
                    removeCartItem(product.cartId);
                  },
                  child: Card(
                    color: Color(0xFFF7F7F8),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              'http://kasimadalan.pe.hu/urunler/resimler/${product.productCartPicture}',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${product.productCartBrand} ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF4335A7),
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 8,
                                            )),
                                            TextSpan(
                                              text: product.productCartName,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey[900],
                                              ),
                                            ),
                                          ],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Sipariş Adeti: ${product.orderQuantity}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hızlı Teslimat',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${int.parse(product.orderQuantity) * double.parse(product.productCartPrice)} TL',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4335A7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "Sepetinizde ürün bulunmamaktadır.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF4335A7),
        unselectedItemColor: Color(0xFF4335A7),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1 ? Icons.category : Icons.category_outlined,
            ),
            label: 'Kategoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2 ? Icons.favorite : Icons.favorite_border,
            ),
            label: 'Favoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 3
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined,
            ),
            label: 'Sepetim',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 4
                  ? Icons.account_circle
                  : Icons.account_circle_outlined,
            ),
            label: 'Hesabım',
          ),
        ],
      ),
    );
  }
}
