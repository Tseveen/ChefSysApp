import 'package:chefsysproject/pages/signup.dart';
import 'package:chefsysproject/reusables/reusables.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
        
              reusableTextField("Цахим хаяг", Icons.person_2_outlined, false,
                  _emailTextController),
              const SizedBox(
                height: 10.0,
              ),
              reusableTextField(
        
                  "Нууц үг", Icons.lock_outlined, true, _passwordTextController),
        
              const SizedBox(
                height: 20,
              ),
        
              button(context, ButtonType.Login, () {
                //loading circle
                showDialog(context: context,
                 builder: (context){
                  return Center(child: CircularProgressIndicator());
                 }
                 );
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Амжилттай нэвтэрлээ")));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Бүртгэлгүй хаяг байна")));
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Нэвтрэх нэр нууц үг буруу байна.")));
                  });
                }),
              burtguuleh(),
        
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding burtguuleh() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Шинээр бүртгүүлэх үү?",
              style: TextStyle(color: Colors.white54)),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
            child: const Text(
              " Бүртгүүлэх",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
