import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartrip/utils/theme.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  static const String _imagePathKey = 'profile_image_path';

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
  final prefs = await SharedPreferences.getInstance();
  final imagePath = prefs.getString(_imagePathKey);

  if (imagePath != null) {
    final imageFile = File(imagePath);

    // ✅ Check if file still exists
    final exists = await imageFile.exists();

    if (exists) {
      setState(() {
        _profileImage = imageFile;
      });
    } else {
      // 🧹 Clean up the stale path from SharedPreferences
      await prefs.remove(_imagePathKey);
    }
  }
}


  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    ); // or camera
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_imagePathKey, imageFile.path);

      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('My Profile', style: AppTheme.headingStyle),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: Colors.black),
            onPressed: () {
              // Navigate to edit profile screen
              // _pickImage();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Tappable Profile Image
            Stack(
              children: [
                GestureDetector(
                  onTap: null,
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundImage:
                        _profileImage != null
                            ? FileImage(_profileImage!)
                            : const AssetImage('assets/icons/profile.jpg')
                                as ImageProvider,
                  ),
                ),
                GestureDetector(
                  onTap: null,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50.r,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            // Navigate to edit profile screen
                            _pickImage();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            Text('Mohan', style: AppTheme.headingStyle),
            SizedBox(height: 4.h),
            Text('mohan@example.com', style: AppTheme.bodycontentStyle),

            SizedBox(height: 24.h),
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 16.h),

            ProfileTile(title: 'Mobile Number', value: '+91 98765 43210'),
            ProfileTile(title: 'Date of Birth', value: '12 Aug 2000'),
            ProfileTile(title: 'Address', value: '123, Anna Nagar, Chennai'),
            ProfileTile(title: 'Proof Type', value: 'Aadhar'),
            ProfileTile(title: 'Proof Number', value: 'XXXX-XXXX-1234'),

            SizedBox(height: 32.h),
            SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Edit or logout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(249, 148, 49, 1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text('Edit Profile', style: AppTheme.buttonTextStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String title;
  final String value;

  const ProfileTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTheme.bodyTitle),
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(value, style: AppTheme.bodycontentStyle),
          ),
        ],
      ),
    );
  }
}
