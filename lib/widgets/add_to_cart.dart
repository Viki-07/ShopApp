import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';

import 'package:shop_example/models/product.dart';
import 'package:shop_example/providers/cart_product_provider.dart';

class AddToCart extends StatefulWidget {
  final Function() onAdd;
  final Function() onRemove;
  const AddToCart({
    super.key,
    required this.productNo,
    required this.currentNumber,
    required this.onAdd,
    required this.onRemove,
  });
  final Product productNo;

  final int currentNumber;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool _isAddingToCart = false;
  static const snackBar1 = SnackBar(
    duration: Duration(milliseconds: 600),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(10),
    backgroundColor: Colors.redAccent,
    content: Text('Product already in Cart!'),
  );
  static const snackBar2 = SnackBar(
    duration: Duration(milliseconds: 600),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(10),
    backgroundColor: Colors.green,
    content: Text('Product added in Cart!'),
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProductProvider>(
      builder: (BuildContext context, CartProductProvider cartProductProvider,
              Widget? child) =>
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: widget.onRemove,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.remove_outline,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.currentNumber.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: widget.onAdd,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.add_outline,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  // margin: EdgeInsets.all(15),
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                // Add this variable

                onPressed: () async {
                  if (!_isAddingToCart &&
                      !cartProductProvider.cartProducts.any((element) =>
                          element['productId'] == widget.productNo.id)) {
                    try {
                      _isAddingToCart =
                          true; // Set the flag to indicate an add-to-cart operation is in progress
                      await cartProductProvider.addCartProduct(
                          widget.productNo.id, widget.currentNumber);

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                    } finally {
                      _isAddingToCart =
                          false; // Reset the flag after the operation is complete
                    }
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                  }
                },

                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Add to Cart",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
