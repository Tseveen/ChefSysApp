import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chefsysproject/pages/menu/menupage.dart';
import 'package:chefsysproject/pages/staff/staff.dart';
import 'package:chefsysproject/pages/userinfo/user_info.dart';

class UIParameters {
  static const double cardBorderRadius = 30.0;
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  late String currentStaffLastName = '';
  late String currentStaffRole = '';
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
          currentStaffLastName = currentStaffData['lastName'] ?? '';
          currentStaffRole = currentStaffData['roll'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching current staff data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 65),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  title: Text(
                    'Сайн уу! $currentStaffLastName',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                  subtitle: Text(
                    'Ажлын зэрэг: $currentStaffRole',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInfoScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: currentStaffProfilePictureUrl.isNotEmpty
                          ? NetworkImage(currentStaffProfilePictureUrl)
                          : AssetImage("assets/logo.png")
                              as ImageProvider<Object>,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 10,
                ),
                children: [
                  _buildAnimatedContainer(
                    context,
                    'Ажилчид',
                    'assets/employees.png',
                    StaffsScreen(),
                  ),
                  _buildAnimatedContainer(
                    context,
                    'Цэс',
                    'assets/menu.png',
                    MenuPage(),
                  ),
                  _buildAnimatedContainer(
                    context,
                    'Хэрэглэгчид',
                    'assets/users.png',
                    Home(),
                  ),
                  _buildAnimatedContainer(
                    context,
                    'Агуулах',
                    'assets/fridge.png',
                    Home(),
                  ),
                  _buildAnimatedContainer(
                    context,
                    'Цагийн хуваарь',
                    'assets/time.png',
                    Home(),
                  ),
                  _buildAnimatedContainer(
                    context,
                    'Нийлүүлэгч',
                    'assets/van.png',
                    Home(),
                  ),
                  _buildAnimatedContainer(
                    context,
                    'Төлбөр тооцоо',
                    'assets/calculator.png',
                    Home(),
                  ),
                  _buildAnimatedContainer(
                    context,
                    'Захиалга',
                    'assets/restaurant.png',
                    Home(),
                  ),
                  _buildAnimatedContainer(
                    context,
                    'Урсгал зардал',
                    'assets/tax.png',
                    Home(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedContainer(
    BuildContext context,
    String label,
    String imagePath,
    Widget destination,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIParameters.cardBorderRadius),
          color: Theme.of(context).colorScheme.secondary,
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
            width: 2.0,
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(imagePath),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
