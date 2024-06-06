import 'package:flutter/material.dart';
import 'package:shop_example/models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> products = [
    Product(
      id: "1",
      title: "Wireless Headphones",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/wireless.png",
      price: 120,
      colors: [
        Colors.black,
        Colors.blue,
        Colors.orange,
      ],
      category: "Tech",
      rate: 4.8,
    ),
    Product(
      id: "2",
      title: "Woman Sweter",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/sweet.png",
      price: 120,
      colors: [
        Colors.brown,
        Colors.red,
        Colors.pink,
      ],
      category: "Beauty",
      rate: 4.8,
    ),
    Product(
      id: "3",
      title: "SmartBand",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/miband.jpg",
      price: 55,
      colors: [
        Colors.black,
      ],
      category: "Tech",
      rate: 4.8,
    ),
    Product(
      id: "4",
      title: "Nike Shoes",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/nike.png",
      price: 9999,
      colors: [
        Colors.black,
      ],
      category: "Shoes",
      rate: 4.8,
    ),
    Product(
      id: "5",
      title: "i7 Desktop",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/pc1.png",
      price: 19999,
      colors: [
        Colors.black,
      ],
      category: "Tech",
      rate: 4.8,
    ),
    Product(
      id: "6",
      title: "LG K42",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/smartphone.png",
      price: 19999,
      colors: [
        Colors.black,
      ],
      category: "Tech",
      rate: 4.8,
    ),
    Product(
      id: "7",
      title: "Diamond Ring",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/diamondring.png",
      price: 200000,
      colors: [
        Colors.black,
      ],
      category: "Beauty",
      rate: 4.8,
    ),
    Product(
      id: "8",
      title: "Gold chain",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/goldchain.png",
      price: 100000,
      colors: [
        Colors.black,
      ],
      category: "Beauty",
      rate: 4.8,
    ),
  ];
  List<Product> tempProducts = [];

  List<Product> get _tempProduct => tempProducts;

  void changeCategory(String category) {
    if (category == "All")
      tempProducts = products;
    else
      tempProducts =
          products.where((element) => element.category == category).toList();
    print(tempProducts.length);
    notifyListeners();
  }
}
