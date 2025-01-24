part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitionEvent extends WishlistEvent{}

class WishListRemoveFromWishListEvent extends WishlistEvent{
  final ProductsDataModel productsDataModel;
  WishListRemoveFromWishListEvent({required this.productsDataModel});

}
