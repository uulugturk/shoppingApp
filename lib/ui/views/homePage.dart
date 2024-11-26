import 'package:bitirme_projesi/data/entity/products.dart';
import 'package:bitirme_projesi/ui/cubit/homePageCubit.dart';
import 'package:bitirme_projesi/ui/cubit/cartPageCubit.dart';
import 'package:bitirme_projesi/ui/views/categoriesPage.dart';
import 'package:bitirme_projesi/ui/views/detailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/ui/views/cartPage.dart';
import 'package:bitirme_projesi/data/entity/productsCart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;

  void _searchProducts(String query) {
    context.read<HomePageCubit>().filterProducts(query);
  }

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().uploadProducts();
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
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartPage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CategoriesPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: Color(0xFF4335A7),
        toolbarHeight: -8,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                    height: 90,
                    width: 150,
                    child: Image.asset("pictures/logo.png")),
                SizedBox(height: 7),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Color(0xFF4335A7),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: CupertinoSearchTextField(
                    placeholder: "Ara",
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    prefixInsets: EdgeInsets.symmetric(vertical: 10.0),
                    onChanged: (query) {
                      _searchProducts(query);
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: BlocBuilder<HomePageCubit, List<Products>>(
                    builder: (context, productsList) {
                      if (productsList.isNotEmpty) {
                        return GridView.builder(
                          itemCount: productsList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.75,
                            mainAxisSpacing: 16.0,
                            crossAxisSpacing: 16.0,
                          ),
                          itemBuilder: (context, indeks) {
                            var product = productsList[indeks];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(product: product),
                                  ),
                                ).then((value) {
                                  context
                                      .read<HomePageCubit>()
                                      .uploadProducts();
                                });
                              },
                              child: Card(
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Image.network(
                                          'http://kasimadalan.pe.hu/urunler/resimler/${product.productPicture}',
                                          height: 120,
                                          width: double.infinity,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              product.productBrand,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF4335A7),
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                            Text(
                                              product.productName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            Text(
                                              product.productCategory,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: List.generate(
                                                    5,
                                                    (index) => Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                          size: 16.0,
                                                        )),
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                '${product.productPrice} TL',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              ProductsCart productsCart =
                                                  ProductsCart(
                                                cartId: 1,
                                                productCartName:
                                                    product.productName,
                                                productCartPicture:
                                                    product.productPicture,
                                                productCartCategory:
                                                    product.productCategory,
                                                productCartPrice:
                                                    product.productPrice,
                                                productCartBrand:
                                                    product.productBrand,
                                                orderQuantity: "1",
                                                userName: "",
                                              );
                                              context
                                                  .read<CartPageCubit>()
                                                  .addToCart(
                                                    productsCart
                                                        .productCartName,
                                                    productsCart
                                                        .productCartPicture,
                                                    productsCart
                                                        .productCartCategory,
                                                    productsCart
                                                        .productCartPrice,
                                                    productsCart
                                                        .productCartBrand,
                                                    productsCart.orderQuantity,
                                                  );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "${product.productBrand} ${product.productName} sepete eklendi."),
                                                  duration: Duration(
                                                      milliseconds: 700),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFF4335A7),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
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
                  onTap: () {},
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
