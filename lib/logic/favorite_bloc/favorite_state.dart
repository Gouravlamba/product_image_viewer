import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadedState extends FavoriteState {
  final Set<String> favoriteIds;

  FavoriteLoadedState(this.favoriteIds);

  @override
  List<Object?> get props => [favoriteIds];
}
