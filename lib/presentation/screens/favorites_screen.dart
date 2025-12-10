import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../../logic/favorite_bloc/favorite_bloc.dart';
import '../../logic/favorite_bloc/favorite_state.dart';
import '../../logic/product_bloc/product_bloc.dart';
import '../../logic/product_bloc/product_state.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _openDetail(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), centerTitle: true),
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
            return BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, favoriteState) {
                if (favoriteState is! FavoriteLoadedState) {
                  return const Center(child: CircularProgressIndicator());
                }

                final favoriteIds = favoriteState.favoriteIds;

                final favoriteProducts = productState.products
                    .where((product) => favoriteIds.contains(product.id))
                    .toList();

                if (favoriteProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      'No favorites yet.\nTap the heart icon on a product to add it.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return ProductCard(
                      product: product,
                      isFavorite: true,
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
