import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_example/firebase_options.dart';
import 'package:shop_example/providers/card_provider.dart';
import 'package:shop_example/providers/cart_product_provider.dart';
import 'package:shop_example/providers/like_product_provider.dart';
import 'package:shop_example/providers/order_provider.dart';
import 'package:shop_example/providers/product_provider.dart';
import 'package:shop_example/providers/shipping_add_provider.dart';
import 'package:shop_example/providers/user_profile_provider.dart';
import 'package:shop_example/screens/auth_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LikedProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProductProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider()),
        ChangeNotifierProvider(create: (context) => ShippingAddProvider()),
        ChangeNotifierProvider(create: (context) => CardProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce-Store',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
          // textTheme: TextTheme(titleMedium: TextStyle(color: Colors.black)),
        ),
        home: AuthScreen(),
      ),
    );
  }
}
