import 'dart:io';
import 'package:chefsysproject/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chefsysproject/pages/userinfo/edit_user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late String currentStaffFirstName = '';
  late String currentStaffLastName = '';
  late String currentStaffEmail = '';
  late String currentStaffAddress = '';
  late String currentStaffRole = '';
  late String currentStaffPhone = '';
  late String currentStaffAge = '';
  late String currentStaffProfilePictureUrl = '';

  @override
  void initState() {
    super.initState();
    fetchCurrentStaffData();
    fetchProfilePicture();
  }

  void fetchProfilePicture() async {
    try {
      String userId = user.uid;
      String profilePicturePath = 'user_images/$userId.jpg';

      String downloadUrl = await FirebaseStorage.instance
          .ref(profilePicturePath)
          .getDownloadURL();

      setState(() {
        currentStaffProfilePictureUrl = downloadUrl;
      });
    } catch (e) {
      print('Error fetching profile picture: $e');
    }
  }

  void fetchCurrentStaffData() async {
    try {
      final staffSnapshot = await FirebaseFirestore.instance
          .collection('staffs')
          .where('email', isEqualTo: user.email)
          .get();

      if (staffSnapshot.docs.isNotEmpty) {
        final currentStaffData = staffSnapshot.docs.first.data();

        setState(() {
          currentStaffFirstName = currentStaffData['firstName'] ?? '';
          currentStaffLastName = currentStaffData['lastName'] ?? '';
          currentStaffAddress = currentStaffData['address'] ?? '';
          currentStaffEmail = currentStaffData['email'] ?? '';
          currentStaffRole = currentStaffData['roll'] ?? '';
          currentStaffPhone = currentStaffData['phone'].toString();
          currentStaffAge = currentStaffData['age'].toString();
        });
      }
    } catch (e) {
      print('Error fetching current staff data: $e');
    }
  }

  void changeProfilePicture() async {
    try {
      final picker = ImagePicker();
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        String userId = user.uid;
        String imagePath = 'user_images/$userId.jpg';

        await FirebaseStorage.instance.ref(imagePath).putFile(File(pickedImage.path));

        String downloadUrl = await FirebaseStorage.instance.ref(imagePath).getDownloadURL();

        setState(() {
          currentStaffProfilePictureUrl = downloadUrl;
        });

        // Update the profile picture URL in Firestore (Optional)
        await FirebaseFirestore.instance
            .collection('staffs')
            .doc(user.uid)
            .update({'profilePictureUrl': downloadUrl});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Амжилтгүй")));
      }
    } catch (e) {
      print('Error changing profile picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Амжилттай солилоо")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Хэрэглэгчийн мэдээлэл'),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 20,
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUserInfoScreen(
                        currentStaffFirstName: currentStaffFirstName,
                        currentStaffLastName: currentStaffLastName,
                        currentStaffEmail: currentStaffEmail,
                        currentStaffAddress: currentStaffAddress,
                        currentStaffRole: currentStaffRole,
                        currentStaffPhone: currentStaffPhone,
                        currentStaffAge: currentStaffAge,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                onPressed: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.blueAccent.withOpacity(0.1),
                          offset: const Offset(0, 10),
                        )
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: currentStaffProfilePictureUrl.isNotEmpty
                            ? NetworkImage(currentStaffProfilePictureUrl)
                            : AssetImage("assets/logo.png") as ImageProvider,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: IconButton(
                        onPressed: changeProfilePicture,
                        icon: const Icon(Icons.add_a_photo),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    itemProfile(
                      context,
                      'Овог',
                      currentStaffFirstName,
                      CupertinoIcons.person,
                    ),
                    const SizedBox(height: 10),
                    itemProfile(
                      context,
                      'Нэр',
                      currentStaffLastName,
                      CupertinoIcons.person,
                    ),
                    const SizedBox(height: 10),
                    itemProfile(
                      context,
                      'Цахим хаяг',
                      currentStaffEmail,
                      CupertinoIcons.mail,
                    ),
                    const SizedBox(height: 10),
                    itemProfile(
                      context,
                      'Утас',
                      currentStaffPhone.toString(),
                      CupertinoIcons.phone,
                    ),
                    const SizedBox(height: 10),
                    itemProfile(
                      context,
                      'Гэрийн хаяг',
                      currentStaffAddress,
                      CupertinoIcons.home,
                    ),
                    const SizedBox(height: 10),
                    itemProfile(
                      context,
                      'Ажлын үүрэг',
                      currentStaffRole,
                      CupertinoIcons.bag,
                    ),
                    const SizedBox(height: 10),
                    itemProfile(
                      context,
                      'Нас',
                      currentStaffAge.toString(),
                      CupertinoIcons.list_number,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Гарах'),
          content: Text('Та гарахдаа итгэлтэй байна уу ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Үгүй',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()),
                );
                print('Хэрэглэгч гарлаа');
              },
              child: Text(
                'Тийм',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget itemProfile(
    BuildContext context,
    title,
    String subtitle,
    IconData iconData,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.blueAccent.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
      ),
    );
  }
}
