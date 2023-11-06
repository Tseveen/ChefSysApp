import 'package:chefsysproject/signup.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChefSys Devs'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 150,
              ),
            ),
            Text(
              'ChefSys',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1), // Add vertical spacing

            Container(
              width: 300,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Нэвтрэх нэр',
                ),
              ),
            ),

            Container(
              width: 300,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Нууц үг',
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your login logic here
                    },
                    child: Text('Нэвтрэх'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add some spacing between the buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUp()));
                    },
                    child: Text('Бүртгүүлэх'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
