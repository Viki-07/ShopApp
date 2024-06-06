import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/constants.dart';
import 'package:shop_example/providers/user_profile_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class EditProfile extends StatefulWidget {
const EditProfile({super.key});

   @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    uname.text=Provider.of<UserProfileProvider>(context, listen: false).userProfile['userName'];
    email.text=Provider.of<UserProfileProvider>(context, listen: false).userProfile['email'];
  }
  var uname = TextEditingController();
  var email = TextEditingController();
  XFile? file;
  ImagePicker imagePicker = ImagePicker();
  Future<void> pickimg(source) async {
    file = await imagePicker.pickImage(source: source, imageQuality: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, userData, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: kcontentColor,
          title: const Text(
            "Edit Profile",
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
                Navigator.of(context).pop();
              },
              icon: const Icon(Ionicons.chevron_back),
            ),
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: userData.userProfile['imageUrl'] != ''
                        ? Image.network(userData.userProfile['imageUrl']).image
                        : Image.network(
                            'https://med.gov.bz/wp-content/uploads/2020/08/dummy-profile-pic.jpg',
                          ).image,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('Choose from Gallery'),
                            onTap: () {
                              Navigator.pop(context);
                              pickimg(ImageSource.gallery);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('Use Camera'),
                            onTap: () {
                              Navigator.pop(context);
                              pickimg(ImageSource.camera);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Change Profile Picture'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: uname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text('UserName'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text('E-mail'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (file == null) return;
                    print('hdasfhakjhfkjdshfakjhfkjdshfkjahdkjfhdskjfahds');
                    print(file!.path);
                    String imgUrl =
                        await userData.uploadProfileImage(file!.path);
                    if (uname.text.isNotEmpty || email.text.isNotEmpty) {
                      await userData.updateUserData(
                        uname.text,
                        email.text,
                        imgUrl,
                      );
                    }
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Ionicons.save_outline),
                  label: Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
