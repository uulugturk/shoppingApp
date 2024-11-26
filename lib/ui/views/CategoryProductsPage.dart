import 'package:flutter/material.dart';
import 'package:bitirme_projesi/data/entity/products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/ui/cubit/homePageCubit.dart';
import 'package:bitirme_projesi/ui/views/detailPage.dart';
import 'package:bitirme_projesi/data/entity/productsCart.dart';
import 'package:bitirme_projesi/ui/cubit/cartPageCubit.dart';

class CategoryProductsPage extends StatefulWidget {
  final String category;

  const CategoryProductsPage({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  TextEditingController searchController = TextEditingController();
  List<Products> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filterCategoryProducts('');
  }

  void _filterCategoryProducts(String query) {
    final homePageCubit = context.read<HomePageCubit>();
    final productsList = homePageCubit.state;

    setState(() {
      filteredProducts = productsList
          .where((product) =>
              product.productCategory == widget.category &&
              (product.productName
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  product.productBrand
                      .toLowerCase()
                      .contains(query.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF4335A7),
        title: Text(
          widget.category,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Josefin Sans",
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
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
          Positioned(
            top: 20,
            left: 70,
            right: 16,
            child: Container(
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
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Ara",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                ),
                onChanged: (query) {
                  _filterCategoryProducts(query);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 16.0, right: 16.0),
            child: BlocBuilder<HomePageCubit, List<Products>>(
              builder: (context, productsList) {
                List<Products> categoryProducts = filteredProducts;

                if (categoryProducts.isNotEmpty) {
                  return GridView.builder(
                    itemCount: categoryProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.75,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                    ),
                    itemBuilder: (context, indeks) {
                      var product = categoryProducts[indeks];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(product: product),
                            ),
                          ).then((value) {
                            context.read<HomePageCubit>().uploadProducts();
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
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
                                          color: Color.fromARGB(255, 0, 0, 0),
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
                                          productCartName: product.productName,
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
                                        context.read<CartPageCubit>().addToCart(
                                              productsCart.productCartName,
                                              productsCart.productCartPicture,
                                              productsCart.productCartCategory,
                                              productsCart.productCartPrice,
                                              productsCart.productCartBrand,
                                              productsCart.orderQuantity,
                                            );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "${product.productName} sepete eklendi."),
                                            duration:
                                                Duration(milliseconds: 700),
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
                  return Center(
                    child: Text(
                      'Bu kategoride ürün bulunmamaktadır.',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
