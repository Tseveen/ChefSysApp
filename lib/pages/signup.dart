import 'package:chefsysproject/reusables/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chefsysproject/pages/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Бүртгүүлэх'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            children: [
              reusableTextField('Цахим хаяг', Icons.email_outlined, false,
                  _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField('Нууц үг', Icons.password_outlined, true,
                  _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              button(context, ButtonType.SignUp, () {
                showDialog(context: context,
                 builder: (context){
                  return Center(child: CircularProgressIndicator());
                 }
                 );
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Шинэ хаяг үүслээ")));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Амжилтгүй")));
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
