import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../../logic/favorite_bloc/favorite_bloc.dart';
import '../../logic/favorite_bloc/favorite_event.dart';
import '../../logic/favorite_bloc/favorite_state.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  void _toggleFavorite(BuildContext context) {
    context.read<FavoriteBloc>().add(ToggleFavoriteEvent(product.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title), centerTitle: true),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, favoriteState) {
          final isFavorite =
              favoriteState is FavoriteLoadedState &&
              favoriteState.favoriteIds.contains(product.id);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'product-image-${product.id}',
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton.icon(
                    onPressed: () => _toggleFavorite(context),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    label: Text(
                      isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
