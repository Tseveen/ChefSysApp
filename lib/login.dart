import 'package:flutter/material.dart';
import 'package:chefsysproject/signup.dart';
import 'package:chefsysproject/home.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        title: const Text('ChefSys Devs'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
                fontFamily: 'Indie',
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10), // Add vertical spacing

            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Нэвтрэх нэр',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),

            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Нууц үг',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                  ),
                  child: const Expanded(
                    child: Text('Нэвтрэх'),
                  ),
                ),
                const SizedBox(
                    width: 40), // Add some spacing between the buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                  ),
                  child: const Expanded(
                    child: Text('Бүртгүүлэх'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: ElevatedButton(
                        onPressed: () {}, child: Icon(Icons.flag)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Монгол',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
