part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

sealed class WishlistActionState {}

final class WishlistInitial extends WishlistState {}

final class WishlistSuccessState extends WishlistState{
  final List<ProductsDataModel> wishLists;
  WishlistSuccessState({required this.wishLists});
}

class WishListCartRemovedActionState extends WishlistActionState{}


