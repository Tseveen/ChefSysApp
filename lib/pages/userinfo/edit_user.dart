import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserInfoScreen extends StatefulWidget {
  final String currentStaffFirstName;
  final String currentStaffLastName;
  final String currentStaffEmail;
  final String currentStaffAddress;
  final String currentStaffRole;
  final String currentStaffPhone;
  final String currentStaffAge;

  const EditUserInfoScreen({
    Key? key,
    required this.currentStaffFirstName,
    required this.currentStaffLastName,
    required this.currentStaffEmail,
    required this.currentStaffAddress,
    required this.currentStaffRole,
    required this.currentStaffPhone,
    required this.currentStaffAge,
  }) : super(key: key);

  @override
  _EditUserInfoScreenState createState() => _EditUserInfoScreenState();
}

class _EditUserInfoScreenState extends State<EditUserInfoScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _roleController;
  late TextEditingController _phoneController;
  late TextEditingController _ageController;

  late String editedStaffFirstName;
  late String editedStaffLastName;
  late String editedStaffEmail;
  late String editedStaffAddress;
  late String editedStaffRole;
  late String editedStaffPhone;
  late String editedStaffAge;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.currentStaffFirstName);
    _lastNameController =
        TextEditingController(text: widget.currentStaffLastName);
    _emailController = TextEditingController(text: widget.currentStaffEmail);
    _addressController =
        TextEditingController(text: widget.currentStaffAddress);
    _roleController = TextEditingController(text: widget.currentStaffRole);
    _phoneController = TextEditingController(text: widget.currentStaffPhone);
    _ageController = TextEditingController(text: widget.currentStaffAge);

    // Initialize the edited values with the current values
    editedStaffFirstName = widget.currentStaffFirstName;
    editedStaffLastName = widget.currentStaffLastName;
    editedStaffEmail = widget.currentStaffEmail;
    editedStaffAddress = widget.currentStaffAddress;
    editedStaffRole = widget.currentStaffRole;
    editedStaffPhone = widget.currentStaffPhone;
    editedStaffAge = widget.currentStaffAge;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _roleController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'Овог'),
              onChanged: (value) {
                setState(() {
                  editedStaffFirstName = value;
                });
              },
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Нэр'),
              onChanged: (value) {
                setState(() {
                  editedStaffLastName = value;
                });
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Цахим хаяг'),
              onChanged: (value) {
                setState(() {
                  editedStaffEmail = value;
                });
              },
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Гэрийн хаяг'),
              onChanged: (value) {
                setState(() {
                  editedStaffAddress = value;
                });
              },
            ),
            TextFormField(
              controller: _roleController,
              decoration: InputDecoration(labelText: 'Үүрэг'),
              onChanged: (value) {
                setState(() {
                  editedStaffRole = value;
                });
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Утас'),
              onChanged: (value) {
                setState(() {
                  editedStaffPhone = value;
                });
              },
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Нас'),
              onChanged: (value) {
                setState(() {
                  editedStaffAge = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _updateUserInfo();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, 
              ),
              child: Text('Өөрчлөх'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUserInfo() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('staffs')
          .where('email', isEqualTo: user!.email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          await FirebaseFirestore.instance
              .collection('staffs')
              .doc(doc.id)
              .update({
            'firstName': editedStaffFirstName,
            'lastName': editedStaffLastName,
            'email': editedStaffEmail,
            'address': editedStaffAddress,
            'roll': editedStaffRole,
            'phone': int.tryParse(editedStaffPhone) ?? 0,
            'age': int.tryParse(editedStaffAge) ?? 0,
          });
        });
      });

      print('User information updated successfully');
    } catch (e) {
      print('Error updating user information: $e');
    }
  }
}
