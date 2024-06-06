import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:shop_example/providers/order_provider.dart';
import 'package:shop_example/screens/Order_detail.dart';

class OrderTile extends StatefulWidget {
  OrderTile(
      {super.key,
      required this.orderID,
      required this.paidStatus,
      required this.totalAmt,
      required this.dateOfOrder});
  String orderID;
  bool paidStatus;
  String totalAmt;
  String dateOfOrder;
  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Order No. #" + widget.orderID,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kprimaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return OrderDetail(
                                      orderId: widget.orderID,
                                    );
                                  });
                            },
                            child: Text(
                              'Details',
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(widget.dateOfOrder),
                    ),
                    Container(
                      child: Text("Total Price ₹" + widget.totalAmt),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
