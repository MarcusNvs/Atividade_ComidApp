import 'food_model.dart';

class CartItemModel {
  final FoodModel food;
  final List<String> selectedAdicionais;
  int quantity;

  CartItemModel({
    required this.food,
    required this.selectedAdicionais,
    this.quantity = 1,
  });

  double getTotal() {
    // Converte o preço de String para double
    double basePrice =
        double.parse(food.price.replaceAll('R\$ ', '').replaceAll(',', '.'));
    // Adiciona R$ 5,90 para cada adicional
    double adicionaisPrice = selectedAdicionais.length * 5.90;
    // Multiplica pelo quantidade e retorna o total
    return (basePrice + adicionaisPrice) * quantity;
  }
}
