import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Бүртгүүлэх'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Овог',  // Add a comma here
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              width: 300,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Овог',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
