import 'package:chefsysproject/pages/signup.dart';
import 'package:chefsysproject/reusables/reusables.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _usernameTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.height * 0.2, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 150,
              ),
            ),
            const Text(
              'ChefSys',
              style: TextStyle(
                color: Colors.white54,
                fontFamily: 'Indie',
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10), // Add vertical spacing

            // Container(
            //   width: 300,
            //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //         border: OutlineInputBorder(),
            //         hintText: 'Нэвтрэх нэр',
            //         hintStyle: TextStyle(
            //           color: Colors.white,
            //         )),
            //   ),
            // ),
            reusableTextField("Нэвтрэх нэр", Icons.person_2_outlined, false, _usernameTextController),
            const SizedBox(
              height: 10.0,
            ),
            reusableTextField("Нууц үг", Icons.lock_outlined, true, _passwordTextController),
            // Container(
            //   width: 300,
            //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //         border: OutlineInputBorder(),
            //         hintText: 'Нууц үг',
            //         hintStyle: TextStyle(
            //           color: Colors.white,
            //         )),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),

            button(context, true, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
            }),
            signUp(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         Navigator.of(context)
            //             .push(MaterialPageRoute(builder: (context) => const Home()));
            //       },
            //       style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 10, vertical: 10),
            //       ),
            //       child: const Expanded(
            //         child: Text('Нэвтрэх'),
            //       ),
            //     ),
            //     const SizedBox(
            //         width: 40), // Add some spacing between the buttons
            //     ElevatedButton(
            //       onPressed: () {
            //         Navigator.of(context).push(
            //             MaterialPageRoute(builder: (context) => SignUp()));
            //       },
            //       style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 10, vertical: 10),
            //       ),
            //       child: const Expanded(
            //         child: Text('Бүртгүүлэх'),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
  Padding signUp() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have account?",
              style: TextStyle(color: Colors.white54)),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: const Text(
              " Sign Up",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}