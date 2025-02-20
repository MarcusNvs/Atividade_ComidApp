import 'package:flutter/material.dart';
import '../components/food_tile.dart';
import '../components/food_carrosel.dart';
import '../model/food_model.dart';
import '../views/cart_screen.dart';
import 'package:provider/provider.dart';
import '../manager/cart_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text('ComidApp'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              Consumer<CartManager>(
                builder: (context, cartManager, child) {
                  return cartManager.items.isNotEmpty
                      ? Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cartManager.items.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const FoodCarousel(),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Hambúrguer'),
              Tab(text: 'Pizza'),
              Tab(text: 'Bebida'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductList('Hambúrguer'),
                _buildProductList('Pizza'),
                _buildProductList('Bebida'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(String category) {
    final List<FoodModel> products = _getProductsByCategory(category);

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: products.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
        height: 1,
        thickness: 0.5,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        return FoodTile(food: products[index]);
      },
    );
  }

  List<FoodModel> _getProductsByCategory(String category) {
    switch (category) {
      case 'Hambúrguer':
        return [
          const FoodModel(
            name: 'Hambúrguer 1',
            price: 'R\$ 25,90',
            description: 'Delicioso hambúrguer artesanal com queijo e bacon',
            imagePath: 'assets/images/hamburguer1.jpg',
          ),
          const FoodModel(
            name: 'Hambúrguer 2',
            price: 'R\$ 28,90',
            description: 'Hambúrguer duplo com cheddar e cebola caramelizada',
            imagePath: 'assets/images/hamburguer2.jpg',
          ),
          const FoodModel(
            name: 'Hambúrguer 3',
            price: 'R\$ 32,90',
            description: 'Hambúrguer especial da casa com molho secreto',
            imagePath: 'assets/images/hamburguer3.jpg',
          ),
        ];
      case 'Pizza':
        return [
          const FoodModel(
            name: 'Pizza 1',
            price: 'R\$ 45,90',
            description: 'Pizza de mussarela com borda recheada',
            imagePath: 'assets/images/pizza1.jpg',
          ),
          const FoodModel(
            name: 'Pizza 2',
            price: 'R\$ 49,90',
            description: 'Pizza de calabresa com cebola',
            imagePath: 'assets/images/pizza2.jpg',
          ),
          const FoodModel(
            name: 'Pizza 3',
            price: 'R\$ 52,90',
            description: 'Pizza quatro queijos especial',
            imagePath: 'assets/images/pizza3.jpg',
          ),
        ];
      case 'Bebida':
        return [
          const FoodModel(
            name: 'Bebida 1',
            price: 'R\$ 8,90',
            description: 'Refrigerante 350ml',
            imagePath: 'assets/images/refrigerante1.jpg',
          ),
          const FoodModel(
            name: 'Bebida 2',
            price: 'R\$ 12,90',
            description: 'Suco natural 500ml',
            imagePath: 'assets/images/refrigerante2.jpg',
          ),
          const FoodModel(
            name: 'Bebida 3',
            price: 'R\$ 15,90',
            description: 'Milk-shake especial 400ml',
            imagePath: 'assets/images/refrigerante3.jpg',
          ),
        ];
      default:
        return [];
    }
  }
}
