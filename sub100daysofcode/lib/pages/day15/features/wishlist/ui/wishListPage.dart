import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub100daysofcode/pages/day15/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:sub100daysofcode/pages/day15/features/wishlist/widgets/wishListTileWidget.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override  
  void initState() {
    super.initState();
    wishlistBloc.add(WishlistInitionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text(
          'Your WishList',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listener: (context, state) {
          
        },
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is !WishlistActionState,
        builder: (context, state) {
          switch(state.runtimeType){
            case WishlistSuccessState:
            final successState = state as WishlistSuccessState;
            return SafeArea(child: ListView.builder(
            itemCount: successState.wishLists.length,
            itemBuilder: (context,index){
            return WishListTile(wishlistBloc: wishlistBloc,productsDataModel: successState.wishLists[index],);
          }
          ));
          default : return const SizedBox();
          }
        },
      ),
    );
  }
}
