import 'package:flutter/material.dart';

class AjilchidPage extends StatefulWidget {
  const AjilchidPage({super.key});

  @override
  State<AjilchidPage> createState() => _AjilchidPageState();
}

class _AjilchidPageState extends State<AjilchidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
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
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/user.jpg'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ]
      ),
    );
  }
}









