import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'manager/cart_manager.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartManager(),
      child: MaterialApp(
        title: 'ComidApp',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1A1A1A), // Cinza quase preto
          colorScheme: ColorScheme.dark(
            background: const Color(0xFF1A1A1A),
            surface: const Color(0xFF1A1A1A),
            primary: Colors.deepOrange,
            secondary: Colors.deepOrangeAccent,
            onBackground: Colors.white,
            onSurface: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1A1A1A),
            foregroundColor: Colors.white,
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
          ),
          cardTheme: CardTheme(
            color: const Color(0xFF2A2A2A), // Um pouco mais claro que o fundo
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.white,
          ),
        ),
        home: const MyHomePage(title: 'ComidApp'),
      ),
    );
  }
}
