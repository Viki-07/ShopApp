import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/providers/order_provider.dart';
import 'package:shop_example/widgets/LikedTile.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    final all_orderList = Provider.of<OrderProvider>(context).orderProduct;
    final requiredOrderList =
        all_orderList.firstWhere((element) => element['orderId'] == widget.orderId)['orderItems'];
    print(requiredOrderList);

    return Consumer<OrderProvider>(
      builder: (context, orderprovider, child) => AlertDialog(
        title: Text('Order Detail'), 
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var orderItem in requiredOrderList)
                  LikedTile(
                    item: orderItem["productId"],
                    mode: 1,
                  ),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
