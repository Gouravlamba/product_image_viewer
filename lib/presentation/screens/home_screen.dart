import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_image_viewer_app/presentation/widgets/app_drawer.dart';

import '../../data/models/product_model.dart';
import '../../logic/favorite_bloc/favorite_bloc.dart';
import '../../logic/favorite_bloc/favorite_state.dart';
import '../../logic/product_bloc/product_bloc.dart';
import '../../logic/product_bloc/product_state.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openDetail(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Products'), centerTitle: true),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, productState) {
          if (productState is ProductLoadingState ||
              productState is ProductInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (productState is ProductErrorState) {
            return Center(
              child: Text(
                'Error: ${productState.message}',
                textAlign: TextAlign.center,
              ),
            );
          } else if (productState is ProductLoadedState) {
            final products = productState.products;

            return BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, favoriteState) {
                Set<String> favoriteIds = {};

                if (favoriteState is FavoriteLoadedState) {
                  favoriteIds = favoriteState.favoriteIds;
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final isFavorite = favoriteIds.contains(product.id);

                    return ProductCard(
                      product: product,
                      isFavorite: isFavorite,
                      onTap: () => _openDetail(context, product),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
