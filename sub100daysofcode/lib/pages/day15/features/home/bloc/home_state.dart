part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

// creating a abstract class for action state
abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}

//home loading state
class HomeLoadingState extends HomeState{}

// home loading success state
class HomeLoadingSuccessState extends HomeState{
  final List<ProductsDataModel> products;
  HomeLoadingSuccessState({required this.products});
}

// home loading failure state
class HomeLoadigFailureState extends HomeState{}

// button clicking home action state ( homeToWishListPageActionState)
class HomeToWishLishListPageNavigationActionState extends HomeActionState{}

// button clicking home action state ( homeToCartPageActionState)
class HomeToCartListPageNavigationActionState extends HomeActionState{}


// on product added to cart
class HomeProductsCartAddedActionState extends HomeActionState{}

// on product added to wishlist
class HomeProductsWishListAddedActionState extends HomeActionState{}
