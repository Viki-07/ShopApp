import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:shop_example/models/cart_item.dart';
import 'package:shop_example/models/likedProduct.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/providers/like_product_provider.dart';
import 'package:shop_example/providers/product_provider.dart';

class LikedTile extends StatefulWidget {
  final String item;
  final int mode;
  const LikedTile({
    super.key,
    required this.item,
    required this.mode,
  });

  @override
  State<LikedTile> createState() => _LikedTileState();
}

class _LikedTileState extends State<LikedTile> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        Provider.of<ProductProvider>(context, listen: false)
        .products.firstWhere((element) => element.id == widget.item);
    return Consumer<LikedProductProvider>(
        builder: (context, likeproductprovider, child) => Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          color: kcontentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          product.image,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "\₹${product.price}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if(widget.mode==0)Positioned(
                  top: 5,
                  right: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          likeproductprovider.removeLikedProduct(widget.item);
                        },
                        icon: const Icon(
                          Ionicons.trash_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                      // Container(
                      //   height: 40,
                      //   decoration: BoxDecoration(
                      //     color: kcontentColor,
                      //     border: Border.all(
                      //       color: Colors.grey.shade200,
                      //       width: 2,
                      //     ),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       IconButton(
                      //         onPressed: widget.onRemove,
                      //         iconSize: 18,
                      //         icon: const Icon(
                      //           Ionicons.remove_outline,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       Text(
                      //         widget.item.quantity.toString(),
                      //         style: const TextStyle(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //       IconButton(
                      //         onPressed: widget.onAdd,
                      //         iconSize: 18,
                      //         icon: const Icon(
                      //           Ionicons.add_outline,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                )
              ]
            ));
  }
}
