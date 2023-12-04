import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chefsysproject/pages/staffdetailscreen.dart';

class StaffsScreen extends StatefulWidget {
  const StaffsScreen({Key? key}) : super(key: key);

  @override
  State<StaffsScreen> createState() => _StaffsScreenState();
}

class _StaffsScreenState extends State<StaffsScreen> {
  void _showDeleteConfirmationDialog(String staffId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this staff member?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (isValidStaffId(staffId)) {
                  print('Deleting staff with ID: $staffId');
                  _deleteStaffMember(staffId);
                } else {
                  // Handle the case where staffId is invalid
                  print('Invalid staff ID: $staffId');
                }
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  bool isValidStaffId(String staffId) {
    return staffId.isNotEmpty;
  }

  void _deleteStaffMember(String staffId) async {
    try {
      print('Attempting to delete staff with ID: $staffId');
      await FirebaseFirestore.instance
          .collection('staffs')
          .doc(staffId)
          .delete();
      print('Staff member deleted successfully.');
    } catch (e) {
      print('Error deleting staff member: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ажилчид'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('staffs').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('Мэдээлэл алга'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic>? data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>?;

                if (data != null) {
                  final String staffId = snapshot.data!.docs[index].id;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text('${data['firstName']} ${data['lastName']}'),
                        subtitle: Text('Утасны дугаар: ${data['phone']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StaffDetailsScreen(
                                      staffData: data,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                _showDeleteConfirmationDialog(staffId);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
