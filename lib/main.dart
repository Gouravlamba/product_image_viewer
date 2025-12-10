import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/product_repository.dart';
import 'data/services/api_service.dart';
import 'data/services/local_data_service.dart';

import 'logic/favorite_bloc/favorite_bloc.dart';
import 'logic/favorite_bloc/favorite_event.dart';

import 'logic/product_bloc/product_bloc.dart';
import 'logic/product_bloc/product_event.dart';

import 'logic/theme_bloc/theme_bloc.dart';
import 'logic/theme_bloc/theme_event.dart';
import 'logic/theme_bloc/theme_state.dart';

import 'presentation/screens/main_screen.dart';
import 'presentation/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService();
  final localDataService = LocalDataService();
  final productRepository = ProductRepository(
    apiService: apiService,
    localDataService: localDataService,
  );

  runApp(MyApp(productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository;

  const MyApp({super.key, required this.productRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// Product Bloc
        BlocProvider<ProductBloc>(
          create: (_) =>
              ProductBloc(productRepository: productRepository)
                ..add(LoadProductsEvent()),
        ),

        /// Favorites Bloc
        BlocProvider<FavoriteBloc>(
          create: (_) => FavoriteBloc()..add(LoadFavoritesEvent()),
        ),

        /// Theme Bloc
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc()..add(LoadThemeEvent()),
        ),
      ],

      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Product Image Viewer',

            /// Apply theme mode from ThemeBloc
            themeMode: themeState.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
