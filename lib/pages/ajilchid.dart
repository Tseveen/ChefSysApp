import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({super.key});

  @override
  _StaffListScreenState createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _staffList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ажилчид'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ажилтан нэмэх:'),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Нэр'),
                ),
                TextField(
                  controller: _roleController,
                  decoration: InputDecoration(labelText: 'Үүрэг'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _addStaff,
                  child: Text('Нэмэх +'),
                ),
              ],
            ),
          ),
          Divider(),
          Text('Ажилтны жагсаалт:'),
          Expanded(
            child: ListView.builder(
              itemCount: _staffList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_staffList[index]['name']),
                  subtitle: Text(_staffList[index]['role']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => _editStaff(index),
                        child: Text('Өөрчлөх'),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () => _removeStaff(index),
                        child: Text('Хасах'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addStaff() {
    String name = _nameController.text.trim();
    String role = _roleController.text.trim();

    if (name.isNotEmpty && role.isNotEmpty) {
      setState(() {
        _staffList.add({'name': name, 'role': role});
      });

      _nameController.clear();
      _roleController.clear();

      // Automatically upload staff to the database
      _uploadStaffList();
    }
  }

  void _editStaff(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Мэдээлэл өөрчлөх'),
          content: Column(
            children: [
              TextField(
                controller:
                    TextEditingController(text: _staffList[index]['name']),
                decoration: InputDecoration(labelText: 'Нэр'),
              ),
              TextField(
                controller:
                    TextEditingController(text: _staffList[index]['role']),
                decoration: InputDecoration(labelText: 'Үүрэг'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Цуцлах'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _staffList[index]['name'] = _nameController.text.trim();
                  _staffList[index]['role'] = _roleController.text.trim();
                });

                Navigator.pop(context);

                _uploadStaffList();
              },
              child: Text('Хадгалах'),
            ),
          ],
        );
      },
    );
  }

  void _removeStaff(int index) {
    setState(() {
      _staffList.removeAt(index);
    });

    _uploadStaffList();
  }

  void _uploadStaffList() {
    _firestore.collection('staff').doc('staffList').set({'list': _staffList});
  }
}
