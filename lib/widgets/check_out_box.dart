import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/providers/cart_product_provider.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/providers/order_provider.dart';
import 'package:shop_example/providers/product_provider.dart';

class CheckOutBox extends StatefulWidget {
  @override
  State<CheckOutBox> createState() => _CheckOutBoxState();
}

class _CheckOutBoxState extends State<CheckOutBox> {
   static const snackBar1 = SnackBar(
    duration: Duration(milliseconds: 600),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(10),
    backgroundColor: Colors.green,
    content: Text('Ordered Successfully'),);
  @override
  Widget build(BuildContext context) {
    return Consumer3<CartProductProvider,OrderProvider,ProductProvider>(
      builder: (context, cartProvider,orderProvider,productProvider, child) {
        List<Map<String, dynamic>> cartProducts = cartProvider.cartProducts;
        double subtotal = calculateSubtotal(cartProducts, productProvider.products);
        double total = calculateTotal(cartProducts, productProvider.products);

        return Container(
          height: 300,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  filled: true,
                  fillColor: kcontentColor,
                  hintText: "Enter Discount Code",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        color: kprimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Subtotal",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "\₹$subtotal",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\₹$total",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()async {
                  // Access CartProductProvider methods here
                  if(cartProvider.cartProducts.isNotEmpty)
                  {
                  // await cartProvider.checkoutCartProduct(generateOrderId().toString(),context,total.toString());
                    orderProvider.addOrderProduct(generateOrderId().toString(), cartProvider.cartProducts, total.toString(),getCurrentDate());
                    cartProvider.checkoutCartProduct();
                    print(orderProvider.orderProduct);
                    ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar1);

                  }
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimaryColor,
                  minimumSize: const Size(double.infinity, 55),
                ),
                child: const Text(
                  "Check out",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to calculate subtotal
  double calculateSubtotal(List<Map<String, dynamic>> cartProducts, List<Product> products) {
    double subtotal = 0;
    for (Map<String, dynamic> cartProduct in cartProducts) {
      Product product = products.firstWhere((p) => p.id == cartProduct['productId']);
      subtotal += cartProduct['quantity'] * product.price;
    }
    return subtotal;
  }

  int generateOrderId() {
  final random = Random();
  return 100 + random.nextInt(999 - 100 + 1);
}

  // Function to calculate total
  double calculateTotal(List<Map<String, dynamic>> cartProducts, List<Product> products) {
    return calculateSubtotal(cartProducts, products);
    // You can add additional logic for discounts, taxes, etc., if needed
  }
  String getCurrentDate()
  {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    print(formattedDate);
    return formattedDate;
  }
}
