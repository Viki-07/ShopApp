import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:shop_example/models/cart_item.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/providers/cart_product_provider.dart';
import 'package:shop_example/widgets/cart_tile.dart';
import 'package:shop_example/widgets/check_out_box.dart';
import 'package:shop_example/models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  
    Provider.of<CartProductProvider>(context, listen: false)
        .fetchCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProductProvider>(
      builder: (context, cartProductProvider, child) {
        return Scaffold(
          backgroundColor: kcontentColor,
          appBar: AppBar(
            backgroundColor: kcontentColor,
            title: const Text(
              "My Cart",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: IconButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                icon: const Icon(Ionicons.chevron_back),
              ),
            ),
          ),
          bottomSheet: CheckOutBox(),
          body: _buildBody(cartProductProvider),
        );
      },
    );
  }

  Widget _buildBody(CartProductProvider cartProductProvider) {
    if (cartProductProvider.isLoading) {
      // If data is still loading, show a circular progress indicator
      return Container(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      // If data is loaded, show the cart items
      return Container(
        height: 400,
        child:!cartProductProvider.cartProducts.isEmpty? ListView.separated(
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) => CartTile(
            productId: cartProductProvider.cartProducts[index]["productId"],
            onRemove: () {
              if (cartProductProvider.cartProducts[index]['quantity'] != 1) {
                setState(() {
                  cartProductProvider.updateCartProduct(
                    cartProductProvider.cartProducts[index]["productId"],
                    cartProductProvider.cartProducts[index]['quantity']--,
                  );
                });
              }
            },
            onAdd: () {
              setState(() {
                cartProductProvider.updateCartProduct(
                  cartProductProvider.cartProducts[index]["productId"],
                  cartProductProvider.cartProducts[index]['quantity']++,
                );
              });
            },
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: cartProductProvider.cartProducts.length,
        ):Center(child: Text('Cart is Empty'))
      );
    }
  }
}
