import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:shop_example/models/cart_item.dart';
import 'package:shop_example/models/likedProduct.dart';
import 'package:shop_example/providers/like_product_provider.dart';
import 'package:shop_example/widgets/LikedTile.dart';
import 'package:shop_example/widgets/cart_tile.dart';
import 'package:shop_example/widgets/check_out_box.dart';
import 'package:shop_example/services/firestore_service.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LikedProductProvider>(context, listen: false)
        .fetchLikedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LikedProductProvider>(
      builder: (context, likeProductProvider, child) {
        if (likeProductProvider.isLoading) {
          return Scaffold(
            backgroundColor: kcontentColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: kcontentColor,
            appBar: AppBar(
              backgroundColor: kcontentColor,
              title: const Text(
                "Liked Products",
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
            body: !likeProductProvider.likedProducts.isEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) => LikedTile(
                      item: likeProductProvider.likedProducts[index]
                          ["productId"],
                          mode: 0,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: likeProductProvider.likedProducts.length,
                  )
                : Center(child: Text("No product is liked")),
          );
        }
      },
    );
  }
}
