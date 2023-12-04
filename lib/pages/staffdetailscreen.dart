import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StaffDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>? staffData;

  const StaffDetailsScreen({Key? key, required this.staffData})
      : super(key: key);

  @override
  _StaffDetailsScreenState createState() => _StaffDetailsScreenState();
}

class _StaffDetailsScreenState extends State<StaffDetailsScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.staffData?['firstName'] ?? '';
    _lastNameController.text = widget.staffData?['lastName'] ?? '';
    _phoneController.text = widget.staffData?['phone']?.toString() ?? '';
    _addressController.text = widget.staffData?['address'] ?? '';
    _ageController.text = widget.staffData?['age']?.toString() ?? '';
    _emailController.text = widget.staffData?['email'] ?? '';
    _rollController.text = widget.staffData?['roll'] ?? '';
  }

  void _updateFirestoreData() async {
    final CollectionReference staffsCollection =
        FirebaseFirestore.instance.collection('staffs');
    final userId = widget.staffData?['staffId']; // Change 'id' to 'userId'

    if (userId == null) {
      print('Error: User ID is null or not found.');
      print('widget.staffData: ${widget.staffData}');
      return;
    }

    try {
      await staffsCollection.doc(userId).update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'age': int.tryParse(_ageController.text) ?? 0,
        'email': _emailController.text,
        'roll': _rollController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Амжилттай хадгалагдлаа.'),
      ));
    } catch (e) {
      print('Error updating document: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Алдаа гарлаа'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ажилчны мэдээлэл засах'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Овог'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Нэр'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Утасны дугаар'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Гэрийн хаяг'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Нас'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Цахим хаяг'),
              ),
              TextField(
                controller: _rollController,
                decoration: InputDecoration(labelText: 'Үүрэг'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateFirestoreData,
                child: Text('Хадгалах'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
