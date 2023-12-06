import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
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
  final TextEditingController _confirmpasswordTextController =
      TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _passwordTextController.dispose();
    _confirmpasswordTextController.dispose();
    _emailTextController.dispose();
    _firstNameController.dispose();
    _ageController.dispose();
    _lastNameController.dispose();
    _numberController.dispose();
    _addressController.dispose();
    _rollController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        // Create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text.trim(),
        );

        addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _emailTextController.text.trim(),
          int.parse(
              _ageController.text.trim()), // Assuming 'age' is an integer field
          int.parse(_numberController.text
              .trim()), // Assuming 'phone' is an integer field
          _addressController.text.trim(),
          _rollController.text.trim(),
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Шинэ хаяг үүслээ")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } catch (e) {
        // Handle errors during user creation
        print('Error during user creation: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Амжилтгүй")));
      }
    }
  }

  Future addUserDetails(
    String firstName,
    String lastName,
    String email,
    int age,
    int phone,
    String address,
    String roll,
  ) async {
    // Add user details to Firestore
    await FirebaseFirestore.instance.collection('staffs').add({
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'phone': phone,
      'address': address,
      'roll': roll,
      'email': email,
      // Add other fields as needed
    });
  }

  bool passwordConfirmed() {
    return _passwordTextController.text.trim() ==
        _confirmpasswordTextController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: const Text('Бүртгүүлэх'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          color: Theme.of(context).colorScheme.background,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.10,
              20,
              0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  reusableTextField(context, 'Овог', Icons.people, false,
                      _firstNameController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                      context, 'Нэр', Icons.people, false, _lastNameController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(context, 'Нас', Icons.people, false,
                      _ageController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(context, 'Утасны дугаар',
                      Icons.phone, false, _numberController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(context, 'Хаяг', Icons.home,
                      false, _addressController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(context, 'Ажлын үүрэг',
                      Icons.badge, false, _rollController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(context, 'Цахим хаяг', Icons.email,
                      false, _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(context, 'Нууц үг', Icons.password_outlined,
                      true, _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    context,
                    'Нууц үгээ дахин хийнэ үү?',
                    Icons.password_outlined,
                    true,
                    _confirmpasswordTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  button(context, ButtonType.SignUp, () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );
                    signUp();
                  }),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
