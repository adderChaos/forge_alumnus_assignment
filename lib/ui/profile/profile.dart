import 'package:flutter/material.dart';
import 'package:forge_alumnus_assignment/constants/constants.dart';
import 'package:forge_alumnus_assignment/ui/custom_widgets/theme_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _skillsTextController = TextEditingController();
  String name = '';
  String email = '';
  String phoneNumber = '';
  String bio = '';
  List<String> skills = [];
  String linkedIn = '';
  String twitter = '';
  bool _isEditing = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profile saved!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please give valid inputs!')));
    }
  }

  @override
  void dispose() {
    _skillsTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveProfile();
              } else {
                _isEditing = true;
                setState(() {});
              }
            },
          ),
          IconButton(
            icon: Icon(
              context.watch<ThemeNotifier>().isDarkMode
                  ? Icons.wb_sunny
                  : Icons.nights_stay,
            ),
            onPressed: () {
              context.read<ThemeNotifier>().toggleTheme();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.camera_alt, size: 50)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                  label: 'Name',
                  onChanged: (value) => name = value,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Enter your name' : null),
              _buildTextField(
                  label: 'Email',
                  onChanged: (value) => email = value,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) =>
                      !AppConstants.emailRegex.hasMatch(value!)
                          ? 'Please enter a valid email'
                          : null),
              _buildTextField(
                  label: 'Phone Number',
                  onChanged: (value) => phoneNumber = value,
                  textInputType: TextInputType.phone,
                  validator: (value) =>
                      !AppConstants.phoneRegex.hasMatch(value!)
                          ? 'Enter a valid phone number'
                          : null),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bio'),
                maxLines: 3,
                onChanged: (value) => bio = value,
                enabled: _isEditing,
              ),
              const SizedBox(height: 20),
              _buildSkillsField(),
              _buildTextField(
                  label: 'LinkedIn',
                  onChanged: (value) => linkedIn = value,
                  textInputType: TextInputType.url),
              _buildTextField(
                  label: 'Twitter',
                  onChanged: (value) => twitter = value,
                  textInputType: TextInputType.url),
              const SizedBox(height: 20),
              if (_isEditing)
                ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Save Profile'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required Function(String) onChanged,
      TextInputType textInputType = TextInputType.text,
      String? Function(String?)? validator}) {
    return TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      validator: validator,
      enabled: _isEditing,
    );
  }

  Widget _buildSkillsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Skills/Interests'),
        Wrap(
          runSpacing: 8,
          spacing: 10,
          children: skills.map((skill) => Chip(label: Text(skill))).toList(),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _skillsTextController,
          onSubmitted: (value) {
            setState(() {
              if (value.isNotEmpty) {
                skills.add(value);
                _skillsTextController.clear();
              }
            });
          },
          enabled: _isEditing,
          decoration: const InputDecoration(labelText: 'Add a skill'),
        ),
      ],
    );
  }
}
