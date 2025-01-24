import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sub100daysofcode/pages/day15/data/cartItems.dart';
import 'package:sub100daysofcode/pages/day15/data/groceryData.dart';
import 'package:sub100daysofcode/pages/day15/data/wishListItems.dart';
import 'package:sub100daysofcode/pages/day15/features/home/models/homeProductsDataModel.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
    on<HomeProductsWishListButtonClickedEvent>(homeProductsWishListButtonClickedEvent);
    on<HomeProductsCartButtonClickedEvent>(homeProductsCartButtonClickedEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialFetchEvent(HomeInitialFetchEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(HomeLoadingSuccessState(products: Grocerydata.groceryProducts.map((e) => ProductsDataModel(id: e['id'], name: e['name'], description: e['description'], price: e['price'], imageUrl: e['imageUrl']),).toList()));
  }

  FutureOr<void> homeProductsWishListButtonClickedEvent(HomeProductsWishListButtonClickedEvent event, Emitter<HomeState> emit) {
    wishListItems.add(event.productsDataModel);
    emit(HomeProductsWishListAddedActionState());
  }

  FutureOr<void> homeProductsCartButtonClickedEvent(HomeProductsCartButtonClickedEvent event, Emitter<HomeState> emit) {
    cartListItems.add(event.productsDataModel);
    emit(HomeProductsCartAddedActionState());
  }

  FutureOr<void> homeWishListButtonNavigateEvent(HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit){
    emit(HomeToWishLishListPageNavigationActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(HomeCartButtonNavigateEvent event, Emitter<HomeState> emit){
    emit(HomeToCartListPageNavigationActionState());
  }


}
