import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub100daysofcode/pages/day15/features/cart/ui/cartPage.dart';
import 'package:sub100daysofcode/pages/day15/features/home/bloc/home_bloc.dart';
import 'package:sub100daysofcode/pages/day15/features/home/widgets/productListTileWidget.dart';
import 'package:sub100daysofcode/pages/day15/features/wishlist/ui/wishListPage.dart';

class BlocHome extends StatefulWidget {
  const BlocHome({super.key});

  @override
  State<BlocHome> createState() => _BlocHomeState();
}

// Wrap the Scaffold with BlocConsumer , which listen to events as well as states that are being emitted

class _BlocHomeState extends State<BlocHome> {
  final HomeBloc homeBloc = HomeBloc();

  @override  
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is !HomeActionState,
      listener: (context, state) {
        if(state is HomeToCartListPageNavigationActionState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartPage()));
        }
        else if(state is HomeToWishLishListPageNavigationActionState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const WishListPage()));
        }
        else if(state is HomeProductsWishListAddedActionState){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.teal,
              content: Text('Item added to wish list',style: TextStyle(color: Colors.white),),
              behavior: SnackBarBehavior.floating,
              ));
        }
        else if(state is HomeProductsCartAddedActionState){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor:Colors.teal,
              content: Text('Item added to cart',style: TextStyle(color: Colors.white),),
              behavior: SnackBarBehavior.floating,
              ));
        }
      },
      builder: (context, state) {
        switch(state.runtimeType){
          case HomeLoadingState:
          return const Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator(color: Colors.black,),)),);
          case HomeLoadingSuccessState:
          final successState = state as HomeLoadingSuccessState;
          return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            title: const Text('Grocery App',style: TextStyle(color: Colors.white),),
            actions: [
              IconButton(onPressed: (){
                homeBloc.add(HomeWishListButtonNavigateEvent());
              },icon: const Icon(Icons.favorite_border,color: Colors.white,),),
              IconButton(onPressed: (){
                homeBloc.add(HomeCartButtonNavigateEvent());
              },icon: const Icon(Icons.shopping_bag_outlined,color: Colors.white,),)
            ],
            centerTitle: false,
          ),
          body: SafeArea(child: ListView.builder(
            itemCount: successState.products.length,
            itemBuilder: (context,index){
            return ProductListTile(homeBloc: homeBloc,productsDataModel: successState.products[index],);
          })),
        );
         case HomeLoadigFailureState:
         return const Scaffold(body: SafeArea(child: Center(child: Text('Error'),)),);
         default : return const SizedBox();
        }
      },
    );
  }
}

