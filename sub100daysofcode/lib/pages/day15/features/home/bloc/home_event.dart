part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent {}

class HomeProductsWishListButtonClickedEvent extends HomeEvent {
  final ProductsDataModel productsDataModel;
  HomeProductsWishListButtonClickedEvent({required this.productsDataModel});
}

class HomeProductsCartButtonClickedEvent extends HomeEvent {
  final ProductsDataModel productsDataModel;
  HomeProductsCartButtonClickedEvent({required this.productsDataModel});

}
class HomeWishListButtonNavigateEvent extends HomeEvent {}
class HomeCartButtonNavigateEvent extends HomeEvent {}

