import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    final staffId = widget.staffData?['id'];

    if (staffId == null) {
      print('Error: Staff ID is null or not found.');
      print('widget.staffData: ${widget.staffData}');
      return;
    }

    try {
      await staffsCollection.doc(staffId).update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'age': int.tryParse(_ageController.text) ?? 0,
        'email': _emailController.text,
        'roll': _rollController.text,
      });

      // Update the local widget's data
      setState(() {
        widget.staffData?['firstName'] = _firstNameController.text;
        widget.staffData?['lastName'] = _lastNameController.text;
        widget.staffData?['phone'] = _phoneController.text;
        widget.staffData?['address'] = _addressController.text;
        widget.staffData?['age'] = int.tryParse(_ageController.text) ?? 0;
        widget.staffData?['email'] = _emailController.text;
        widget.staffData?['roll'] = _rollController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Амжилттай засагдлаа.'),
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
        title: Text('Ажилчдийн мэдээлэл засах'),
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
                onChanged: (value) {
                  _firstNameController.text = value;
                },
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Нэр'),
                onChanged: (value) {
                  _lastNameController.text = value;
                },
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Утасны дугаар'),
                onChanged: (value) {
                  _phoneController.text = value;
                },
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Гэрийн хаяг'),
                onChanged: (value) {
                  _addressController.text = value;
                },
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Нас'),
                onChanged: (value) {
                  _ageController.text = value;
                },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Цахим хаяг'),
                onChanged: (value) {
                  _emailController.text = value;
                },
              ),
              TextField(
                controller: _rollController,
                decoration: InputDecoration(labelText: 'Үүрэг'),
                onChanged: (value) {
                  _rollController.text = value;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _updateFirestoreData,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Хадгалах'),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
