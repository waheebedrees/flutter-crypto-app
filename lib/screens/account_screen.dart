import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  User? _user;
  String _name = "";
  String _email = "";
  String? _profileImageUrl;
  bool _darkMode = false;
  bool _notifications = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      var userDoc = await _firestore.collection('users').doc(_user!.uid).get();
      setState(() {
        _name = userDoc['name'] ?? "User";
        _email = _user!.email ?? "";
        _profileImageUrl = userDoc['profileImage'] ?? null;
        _darkMode = userDoc['darkMode'] ?? false;
        _notifications = userDoc['notifications'] ?? true;
      });
    }
  }

  Future<void> _updateUserData() async {
    await _firestore.collection('users').doc(_user!.uid).set({
      'name': _name,
      'profileImage': _profileImageUrl,
      'darkMode': _darkMode,
      'notifications': _notifications,
    }, SetOptions(merge: true));
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String fileName = 'profile_${_user!.uid}.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref('profiles/$fileName').putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _profileImageUrl = downloadUrl;
      });
      _updateUserData();
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(
        context, '/login'); // Redirect to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImageUrl != null
                    ? NetworkImage(_profileImageUrl!)
                    : null,
                child: _profileImageUrl == null
                    ? Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: "Name"),
              onChanged: (value) {
                setState(() => _name = value);
              },
            ),
            SizedBox(height: 10),
            Text("Email: $_email", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text("Dark Mode"),
              value: _darkMode,
              onChanged: (value) {
                setState(() => _darkMode = value);
                _updateUserData();
              },
            ),
            SwitchListTile(
              title: Text("Notifications"),
              value: _notifications,
              onChanged: (value) {
                setState(() => _notifications = value);
                _updateUserData();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
