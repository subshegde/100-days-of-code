import 'package:flutter/material.dart';
import 'package:sub100daysofcode/pages/day15/features/home/models/homeProductsDataModel.dart';
import 'package:sub100daysofcode/pages/day15/features/wishlist/bloc/wishlist_bloc.dart';

class WishListTile extends StatelessWidget {
  final ProductsDataModel productsDataModel;
  final WishlistBloc wishlistBloc;

  const WishListTile({super.key, required this.productsDataModel, required this.wishlistBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 245, 245),
        border: Border.all(width: 1, color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
      padding: const EdgeInsets.only(left:10,top: 10,bottom: 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${productsDataModel.name}',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      '${productsDataModel.description}',
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      "\$ ${productsDataModel.price}",
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 7),
                width: 80,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          productsDataModel.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              wishlistBloc.add(WishListRemoveFromWishListEvent(productsDataModel: productsDataModel));
                            },
                            icon: const Icon(Icons.favorite),
                          ),
                          IconButton(
                            onPressed: () {
                            },
                            icon: const Icon(Icons.shopping_bag_outlined),
                          ),
                        ],
                      ),
        ],
      ),
    );
  }
}
