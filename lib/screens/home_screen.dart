import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:shop_example/models/product.dart';
import 'package:shop_example/providers/card_provider.dart';
import 'package:shop_example/providers/like_product_provider.dart';
import 'package:shop_example/providers/product_provider.dart';
import 'package:shop_example/providers/shipping_add_provider.dart';
import 'package:shop_example/providers/user_profile_provider.dart';
import 'package:shop_example/widgets/categories.dart';
import 'package:shop_example/widgets/home_appbar.dart';
import 'package:shop_example/widgets/home_slider.dart';
import 'package:shop_example/widgets/product_card.dart';
import 'package:shop_example/widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    liked_userData();
    super.initState();
  }

  Future<void> liked_userData() async {
    await Provider.of<UserProfileProvider>(context, listen: false)
        .fetchUserData();
    final userData =
        Provider.of<UserProfileProvider>(context, listen: false).userProfile;
    if (userData.isEmpty) {
      await Provider.of<UserProfileProvider>(context, listen: false)
          .addUserData('Vivek Maurya', 'vikim9045@gmail.com', '');
    }
    Provider.of<ProductProvider>(context, listen: false).changeCategory("All");
    await Provider.of<LikedProductProvider>(context, listen: false)
        .fetchLikedProducts();

    await Provider.of<ShippingAddProvider>(context, listen: false)
        .fetchAddress();
    final shipAdd =
        Provider.of<ShippingAddProvider>(context, listen: false).shippingAdd;
    if (shipAdd.isEmpty) {
      await Provider.of<ShippingAddProvider>(context, listen: false).addAddress(
          'Suite 382 4459',
          'Lyndon Heights',
          'West Marionview',
          'Caloifornia',
          'USA',
          '51849');
    }
    await Provider.of<CardProvider>(context, listen: false).fetchCardData();
    final userCard = Provider.of<CardProvider>(context, listen: false).userCard;
    if (userCard.isEmpty) {
      await Provider.of<CardProvider>(context, listen: false)
          .addCard('765489071234', 'Vivek Maurya', '06/2024', '234');
    }
  }

  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) => Scaffold(
        backgroundColor: kscaffoldColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeAppBar(),
                  const SizedBox(height: 10),
                  // const SearchField(),
                  // const SizedBox(height: 20),
                  HomeSlider(
                    onChange: (value) {
                      setState(() {
                        currentSlide = value;
                      });
                    },
                    currentSlide: currentSlide,
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: Container(
                          alignment: Alignment.center,
                          child: const Categories())),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Special For You",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("See all"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: productProvider.tempProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                          product: productProvider.tempProducts[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
