import 'package:bitirme_projesi/data/entity/productsCart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/data/entity/products.dart';
import 'package:bitirme_projesi/data/repo/productsDaoRepository.dart';

class CartPageCubit extends Cubit<List<ProductsCart>> {
  CartPageCubit() : super([]);

  var prepo = ProductsDaoRepository();

  Future<void> getCartItems() async {
    try {
      List<ProductsCart> cartItems = await prepo.getCart();
      emit(cartItems);
    } catch (e) {
      print("Sepet yüklenemedi: $e");
    }
  }

  Future<void> addToCart(
      String productCartName,
      String productCartPicture,
      String productCartCategory,
      String productCartPrice,
      String productCartBrand,
      String orderQuantity) async {
    List<ProductsCart> cartItems = await prepo.getCart();

    ProductsCart? existingItem;
    for (var item in cartItems) {
      if (item.productCartName == productCartName &&
          item.productCartBrand == productCartBrand) {
        existingItem = item;
        break;
      }
    }

    if (existingItem != null) {
      int updatedQuantity =
          int.parse(existingItem.orderQuantity) + int.parse(orderQuantity);
      await prepo.delete(existingItem.cartId);
      await prepo.addToCart(
          existingItem.productCartName,
          existingItem.productCartPicture,
          existingItem.productCartCategory,
          existingItem.productCartPrice,
          existingItem.productCartBrand,
          updatedQuantity.toString());
    } else {
      await prepo.addToCart(
          productCartName,
          productCartPicture,
          productCartCategory,
          productCartPrice,
          productCartBrand,
          orderQuantity);
    }

    getCartItems();
  }

  Future<void> deleteCartItem(int cartId) async {
    await prepo.delete(cartId);
    getCartItems();
  }
}
