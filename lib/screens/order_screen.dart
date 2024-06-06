import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:shop_example/providers/cart_product_provider.dart';
import 'package:shop_example/providers/order_provider.dart';
import 'package:shop_example/widgets/order_tile.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch cart products when the screen is first loaded
    Provider.of<OrderProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kcontentColor,
            title: const Text(
              "Orders",
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
          body: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) => OrderTile(
              orderID: orderProvider.orderProduct[index]['orderId'],
              paidStatus: true,
              totalAmt: orderProvider.orderProduct[index]['orderPrice'],
              dateOfOrder: orderProvider.orderProduct[index]['orderDate'],
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: orderProvider.orderProduct.length,
          ),
        ),
      ),
    );
  }
}
