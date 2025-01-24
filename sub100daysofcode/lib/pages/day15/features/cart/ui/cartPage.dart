import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub100daysofcode/pages/day15/features/cart/bloc/cart_bloc.dart';
import 'package:sub100daysofcode/pages/day15/features/cart/widgets/cartListTileWidget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();

  @override  
  void initState() {
    super.initState();
    cartBloc.add(CartInitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text(
          'Your Cart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is !CartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch(state.runtimeType){
            case CartSuccessState:
            final successState = state as CartSuccessState;
            return SafeArea(child: ListView.builder(
            itemCount: successState.cartItems.length,
            itemBuilder: (context,index){
            return CartListTile(cartBloc: cartBloc,productsDataModel: successState.cartItems[index],);
          }
          ));
          default : return const SizedBox();
          }
        },
      ),
    );
  }
}
