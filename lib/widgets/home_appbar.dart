import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shop_example/providers/user_profile_provider.dart';
import 'package:shop_example/screens/notification_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, userData, child) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle(
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
            child: Container(
              padding: EdgeInsets.only(left: 8),
              height: 30,
              width: 320,
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  RotateAnimatedText(
                      alignment: Alignment.centerLeft,
                      'Hello ' + userData.userProfile['userName'] + '!'),
                  RotateAnimatedText('Welcome !',
                      alignment: Alignment.centerLeft),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
            style: IconButton.styleFrom(
              backgroundColor: kcontentColor,
              padding: const EdgeInsets.all(15),
            ),
            iconSize: 20,
            icon: const Icon(Ionicons.notifications_outline),
          )
        ],
      ),
    );
  }
}
