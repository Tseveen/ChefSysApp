import 'package:chefsysproject/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Хэрэглэгчийн мэдээлэл'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),

      //image edit
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
                        color: Theme.of(context).scaffoldBackgroundColor,
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
                        image: AssetImage("assets/logo.png"),
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
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: Colors.blueAccent,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_a_photo),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //edit address etc..
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [                   
                    const SizedBox(height: 20),
                    itemProfile('Овог', 'Амгалан', CupertinoIcons.person),
                    const SizedBox(height: 10),
                    itemProfile('Нэр', 'Цэвээнравдан', CupertinoIcons.person),
                    const SizedBox(height: 10),
                    itemProfile('Email', 'tseveenbna@gmail.com', CupertinoIcons.mail),
                    const SizedBox(height: 10),
                    itemProfile('Утас', '80745008', CupertinoIcons.phone),
                    const SizedBox(height: 10),
                    itemProfile('Хаяг', '3-4 хороолол', CupertinoIcons.home),
                    const SizedBox(height: 10),
                    itemProfile('Ажлын үүрэг', 'Тогооч', CupertinoIcons.bag),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//logout ask
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
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Үгүй'),
            ),
            TextButton(
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()),
                );
                print('Хэрэглэгч гарлаа');
              },
              child: Text('Гарах'),
            ),
          ],
        );
      },
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            print('Edit button pressed');
          },
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
