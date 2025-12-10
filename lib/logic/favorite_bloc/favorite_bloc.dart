import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitialState()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> storedIds =
        prefs.getStringList(AppConstants.favoritesPrefsKey) ?? [];
    emit(FavoriteLoadedState(storedIds.toSet()));
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final currentState = state;

    if (currentState is FavoriteLoadedState) {
      final updatedFavorites = Set<String>.from(currentState.favoriteIds);

      if (updatedFavorites.contains(event.productId)) {
        updatedFavorites.remove(event.productId);
      } else {
        updatedFavorites.add(event.productId);
      }

      emit(FavoriteLoadedState(updatedFavorites));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        AppConstants.favoritesPrefsKey,
        updatedFavorites.toList(),
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      final storedIds =
          prefs.getStringList(AppConstants.favoritesPrefsKey) ?? [];
      final updatedFavorites = storedIds.toSet();

      if (updatedFavorites.contains(event.productId)) {
        updatedFavorites.remove(event.productId);
      } else {
        updatedFavorites.add(event.productId);
      }

      emit(FavoriteLoadedState(updatedFavorites));

      await prefs.setStringList(
        AppConstants.favoritesPrefsKey,
        updatedFavorites.toList(),
      );
    }
  }
}
