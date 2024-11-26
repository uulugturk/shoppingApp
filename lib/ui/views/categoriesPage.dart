import 'package:bitirme_projesi/data/entity/products.dart';
import 'package:bitirme_projesi/ui/views/CategoryProductsPage.dart';
import 'package:bitirme_projesi/ui/views/cartPage.dart';
import 'package:bitirme_projesi/ui/views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/ui/cubit/homePageCubit.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _currentIndex = 1;

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

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'teknoloji':
        return Icons.computer;
      case 'aksesuar':
        return Icons.watch;
      case 'kozmetik':
        return Icons.brush;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF4335A7),
        title: Text(
          'Kategoriler',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Josefin Sans",
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: BlocBuilder<HomePageCubit, List<Products>>(
          builder: (context, productsList) {
            Set<String> categories =
                productsList.map((p) => p.productCategory).toSet();

            if (categories.isNotEmpty) {
              return GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                itemBuilder: (context, index) {
                  String category = categories.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryProductsPage(category: category),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getCategoryIcon(category),
                            size: 50,
                            color: Color(0xFF4335A7),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4335A7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'Hiç kategori bulunamadı.',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              );
            }
          },
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
