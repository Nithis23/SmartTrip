import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartrip/utils/theme.dart';

@RoutePage()
class PassportKycScreen extends StatefulWidget {
  const PassportKycScreen({super.key});

  @override
  State<PassportKycScreen> createState() => _PassportKycScreenState();
}

class _PassportKycScreenState extends State<PassportKycScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passportNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _nationalityController = TextEditingController();

  File? _passportFront;
  File? _passportBack;

  final picker = ImagePicker();

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _passportFront = File(pickedFile.path);
        } else {
          _passportBack = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Passport KYC", style: AppTheme.headingStyle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Complete Your Passport KYC",
                  style: AppTheme.bodyTitle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "To join international trips, please provide your passport details.",
                  style: AppTheme.bodycontentStyle.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Full Name
                _buildTextField(
                  controller: _fullNameController,
                  label: "Full Name (As per Passport)",
                  icon: Icons.person_outline,
                  validator:
                      (v) => v!.isEmpty ? "Please enter your full name" : null,
                ),
                const SizedBox(height: 16),

                // Passport Number
                _buildTextField(
                  controller: _passportNumberController,
                  label: "Passport Number",
                  icon: Icons.card_travel_outlined,
                  validator:
                      (v) => v!.isEmpty ? "Please enter passport number" : null,
                ),
                const SizedBox(height: 16),

                // Expiry Date
                _buildTextField(
                  controller: _expiryDateController,
                  label: "Expiry Date (DD/MM/YYYY)",
                  icon: Icons.date_range_outlined,
                  validator:
                      (v) => v!.isEmpty ? "Please enter expiry date" : null,
                ),
                const SizedBox(height: 16),

                // Nationality
                _buildTextField(
                  controller: _nationalityController,
                  label: "Nationality",
                  icon: Icons.flag_outlined,
                  validator:
                      (v) =>
                          v!.isEmpty ? "Please enter your nationality" : null,
                ),
                const SizedBox(height: 24),

                // Upload Passport Images
                Text(
                  "Upload Passport Pages",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildUploadCard(
                      "Front Page",
                      _passportFront,
                      () => _pickImage(true),
                    ),
                    const SizedBox(width: 12),
                    _buildUploadCard(
                      "Back Page",
                      _passportBack,
                      () => _pickImage(false),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _passportFront != null &&
                          _passportBack != null) {
                        // TODO: Call API here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Passport KYC Submitted ✅"),
                          ),
                        );

                        context.router.pop(); // go back or navigate forward
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please complete all details"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF99431),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          prefixIcon: Icon(icon, color: const Color(0xFFF99431)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFF99431), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard(String title, File? file, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          height: 150,
          decoration: BoxDecoration(
            gradient:
                file == null
                    ? LinearGradient(
                      colors: [Colors.grey.shade100, Colors.grey.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : null,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border:
                file == null
                    ? Border.all(
                      color: Colors.grey.shade400,
                      width: 1.2,
                      style: BorderStyle.solid,
                    )
                    : null,
          ),
          child:
              file == null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 42,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        title,
                        style: AppTheme.bodyTitle.copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Tap to upload",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                  : Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(file, fit: BoxFit.cover),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          radius: 18,
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
