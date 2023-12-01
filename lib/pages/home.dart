import 'package:chefsysproject/pages/user_info.dart';
import 'package:flutter/material.dart';
import 'ajilchid.dart'; // Import the AjilchidPage

class UIParameters {
  static const double cardBorderRadius = 30.0;
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 65),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  title: Text('Сайн уу! Хэрэглэгч',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('Ажлын зэрэг',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserInfoScreen()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 10)
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
                  _buildInkWell(
                    context,
                    'Ажилчид',
                    'assets/employees.png',
                    StaffListScreen(),
                  ),
                  _buildInkWell(
                    context,
                    'Цэс',
                    'assets/menu.png',
                    Home(),
                  ),
                  _buildInkWell(
                    context,
                    'Хэрэглэгчид',
                    'assets/users.png',
                    Home(),
                  ),
                  _buildInkWell(
                    context,
                    'Агуулах',
                    'assets/fridge.png',
                    Home(),
                  ),
                  _buildInkWell(
                    context,
                    'Цагийн хуваарь',
                    'assets/time.png',
                    Home(),
                  ),
                  _buildInkWell(
                    context,
                    'Нийлүүлэгч',
                    'assets/van.png',
                    Home(),
                  ),
                  _buildInkWell(
                    context,
                    'Төлбөр тооцоо',
                    'assets/calculator.png',
                    Home(),
                  ),
                  _buildInkWell(
                    context,
                    'Захиалга',
                    'assets/restaurant.png',
                    Home(),
                  ),
                  _buildInkWell(
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

  Widget _buildInkWell(
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIParameters.cardBorderRadius),
          color: Colors.blueAccent,
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
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
