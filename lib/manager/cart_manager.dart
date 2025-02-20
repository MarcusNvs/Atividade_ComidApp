import 'package:flutter/foundation.dart';
import '../model/cart_item_model.dart';

class CartManager extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  void addItem(CartItemModel item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void removeAllItems() {
    _items.clear();
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  double getCartTotal() {
    return _items.fold(0, (total, item) => total + item.getTotal());
  }
}
