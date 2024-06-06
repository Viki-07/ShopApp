import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_example/providers/user_profile_provider.dart';
import 'package:shop_example/screens/LikedScreen.dart';
import 'package:shop_example/screens/auth_screen.dart';
import 'package:shop_example/screens/cards_screen.dart';
import 'package:shop_example/screens/edit_profile_screen.dart';
import 'package:shop_example/screens/home_screen.dart';
import 'package:shop_example/screens/order_screen.dart';
import 'package:shop_example/screens/shipping_add_screen.dart';

final firebaseInst = FirebaseAuth.instance;

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Future<void> logout() async {
    await firebaseInst.signOut();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Logged out')));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthScreen()));
  }
@override
  
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, userData, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: kcontentColor,
          title: const Text(
            "My Profile",
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
          actions: [
            InkWell(
              onTap: () => logout(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    // alignment: Alignment.bottomRight,
                    children: [
                       Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: userData.userProfile['imageUrl'] != ''
    ? Image.network( userData.userProfile['imageUrl']).image
    : Image.network(
        'https://med.gov.bz/wp-content/uploads/2020/08/dummy-profile-pic.jpg',
      ).image,

                  ),
                ),
              ),
                      
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    userData.userProfile['userName'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userData.userProfile['email'],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 30),
                  buildMenuTile(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () {
                      // Add functionality for editing profile
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfile()));
                    },
                  ),
                  buildMenuTile(
                    icon: Icons.location_on,
                    title: 'Shopping Address',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShippingAddressScreen()));
                    },
                  ),
                  buildMenuTile(
                    icon: Icons.favorite,
                    title: 'Wishlist',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LikedScreen()));

                    },
                  ),
                  buildMenuTile(
                    icon: Icons.history,
                    title: 'Order History',
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderScreen()));
                    },
                  ),
                  buildMenuTile(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () {
                    },
                  ),
                  buildMenuTile(
                    icon: Icons.credit_card,
                    title: 'Cards',
                    onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CardsScreen()));                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 30),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
