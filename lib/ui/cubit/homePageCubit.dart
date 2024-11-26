import 'package:bitirme_projesi/data/entity/products.dart';
import 'package:bitirme_projesi/data/repo/productsDaoRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<List<Products>> {
  HomePageCubit() : super(<Products>[]);

  var prepo = ProductsDaoRepository();

  List<Products> allProducts = [];

  Future<void> uploadProducts() async {
    var list = await prepo.uploadProducts();
    allProducts = list;
    emit(list);
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      emit(allProducts);
    } else {
      final filteredProducts = allProducts.where((product) {
        return product.productName
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            product.productBrand.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(filteredProducts);
    }
  }
}
