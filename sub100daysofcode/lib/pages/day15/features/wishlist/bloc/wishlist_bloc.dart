import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sub100daysofcode/pages/day15/data/wishListItems.dart';
import 'package:sub100daysofcode/pages/day15/features/home/models/homeProductsDataModel.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitionEvent>(wishlistInitionEvent);
    on<WishListRemoveFromWishListEvent>(wishListRemoveFromWishListEvent);
  }

  FutureOr<void> wishlistInitionEvent(WishlistInitionEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishLists: wishListItems));
  }
  FutureOr<void> wishListRemoveFromWishListEvent(WishListRemoveFromWishListEvent event, Emitter<WishlistState> emit) {
    wishListItems.remove(event.productsDataModel);
    emit(WishlistSuccessState(wishLists: wishListItems));
  }
}
