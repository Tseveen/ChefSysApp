import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:chefsysproject/reusables/reusables.dart';
import 'package:chefsysproject/pages/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

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

  XFile? _image; // Variable to store the picked image file

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
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text.trim(),
        );

        // Upload the image to Firebase Storage
        if (_image != null) {
          String userId = userCredential.user?.uid ?? '';
          String imagePath = 'user_images/$userId.jpg';

          // Upload the image
          await FirebaseStorage.instance
              .ref(imagePath)
              .putFile(File(_image!.path));
        }

        addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _emailTextController.text.trim(),
          int.parse(_ageController.text.trim()),
          int.parse(_numberController.text.trim()),
          _addressController.text.trim(),
          _rollController.text.trim(),
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Шинэ хэрэглэгч үүслээ")));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
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

  Future getImage() async {
    final picker = ImagePicker();
    _image = await picker.pickImage(source: ImageSource.gallery);

    if (_image != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                  GestureDetector(
                    onTap: getImage,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                          _image != null ? FileImage(File(_image!.path)) : null,
                      child: _image == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Display the picked image
                  _image != null
                      ? Image.file(
                          File(_image!.path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : SizedBox.shrink(),
                  const SizedBox(height: 10),
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
                  reusableTextField(
                      context, 'Нас', Icons.people, false, _ageController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(context, 'Утасны дугаар', Icons.phone,
                      false, _numberController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                      context, 'Хаяг', Icons.home, false, _addressController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(context, 'Ажлын үүрэг', Icons.badge, false,
                      _rollController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(context, 'Цахим хаяг', Icons.email, false,
                      _emailTextController),
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
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
