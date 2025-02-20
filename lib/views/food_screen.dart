import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho_aplicativo_comida/views/cart_screen.dart';
import '../manager/cart_manager.dart';
import '../model/food_model.dart';
import '../model/cart_item_model.dart';

class FoodScreen extends StatefulWidget {
  final FoodModel food;

  const FoodScreen({
    super.key,
    required this.food,
  });

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  // Mapa para controlar o estado de seleção de cada adicional
  final Map<String, bool> _selectedAdicionais = {
    'Bacon Extra': false,
    'Queijo Adicional': false,
    'Molho Especial': false,
  };

  Widget _buildAdicional(String nome, String valor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAdicionais[nome] = !(_selectedAdicionais[nome] ?? false);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade900,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    valor,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: _selectedAdicionais[nome],
              onChanged: (bool? value) {
                setState(() {
                  _selectedAdicionais[nome] = value ?? false;
                });
              },
              fillColor: MaterialStateProperty.all(Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagem do alimento
                Image.asset(
                  widget.food.imagePath,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome do alimento
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Preço
                      Text(
                        widget.food.price,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Descrição
                      Text(
                        widget.food.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Seção de Adicionais
                      const Text(
                        'Adicionais',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Container principal dos adicionais
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade900,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildAdicional('Bacon Extra', 'R\$ 5,90'),
                            _buildAdicional('Queijo Adicional', 'R\$ 4,90'),
                            _buildAdicional('Molho Especial', 'R\$ 3,90'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Botão de voltar
          Positioned(
            top: 40,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Botão Adicionar ao Carrinho
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  final cartItem = CartItemModel(
                    food: widget.food,
                    selectedAdicionais: _selectedAdicionais.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList(),
                  );

                  // Adicionar ao carrinho usando o CartManager
                  context.read<CartManager>().addItem(cartItem);

                  // Navegar para o carrinho
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A2A2A),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  minimumSize: const Size.fromHeight(65),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
                child: const Text(
                  'Adicionar ao Carrinho',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
