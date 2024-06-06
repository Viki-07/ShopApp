import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/providers/like_product_provider.dart';

class ProductAppBar extends StatefulWidget {
  const ProductAppBar({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  State<ProductAppBar> createState() => _ProductAppBarState();
}
class _ProductAppBarState extends State<ProductAppBar> {
  @override
  Widget build(BuildContext context) {
bool isLiked=Provider.of<LikedProductProvider>(context).likedProducts.any((element) => element['productId']==widget.product.id);
    
    return Consumer<LikedProductProvider>(
      builder: (context, likeproductprovider, child) => Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              icon: const Icon(Ionicons.chevron_back),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              icon: const Icon(Ionicons.share_social_outline),
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: () async{
            
               if(isLiked==false)
                await likeproductprovider.addLikedProduct(widget.product.id);
               else
                await likeproductprovider.removeLikedProduct(widget.product.id);
               
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              icon: isLiked?(Icon(Ionicons.heart)):(Icon(Ionicons.heart_outline)),
            ),
          ],
        ),
      ),
    );
  }
}
