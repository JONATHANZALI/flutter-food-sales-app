import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/services/auth.dart';
import 'package:food_app/services/cloudinary.dart';
import 'package:image_picker/image_picker.dart';
import '../const/colors.dart';
import '../screens/loginScreen.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUpScreen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cPasswordController = TextEditingController();
  File? _profileImage;
  XFile? _image;
  bool _isLoading = false;

  // Method that handles the registration
  void register() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        // Upload profile picture to cloudinary
        String? profilePicUrl;
        String? error;

        if (_profileImage != null) {
          var uploadResult = await CloudinaryService()
              .uploadImage(_profileImage!, imagePath: "food_profile_images");
          if (uploadResult['success'] == false) {
            throw Exception(uploadResult['value']);
          }
          profilePicUrl = uploadResult['value'];
        }
        error = await AuthService().registerUser(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phoneNumber: _phoneNumberController.text.trim(),
          address: _addressController.text.trim(),
          profileImage: profilePicUrl!,
        );

        if (error == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Registration Successful")));
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        } else {
          throw Exception(error);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      // terminate the loading bar
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        style: Helper.getTheme(context).titleLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Add your details to sign up",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextInput(
                          hintText: "Enter your Full names",
                          controller: _nameController,
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Name cannot be empty'
                              : null),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextInput(
                        hintText: "Enter your email",
                        controller: _emailController,
                        validator: (value) {
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value!)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextInput(
                        hintText: "Mobile Number",
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        validator: (value) => value!.length != 9
                            ? 'Phone number must be 9 digits'
                            : null,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextInput(
                        hintText: "Address",
                        controller: _addressController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextInput(
                        hintText: "Password",
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) =>
                            value!.length < 5 ? 'password too short' : null,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextInput(
                        hintText: "Confirm Password",
                        obscureText: true,
                        controller: _cPasswordController,
                        validator: (value) {
                          return (value != _passwordController.text)
                              ? 'passwords do not match'
                              : null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () async {
                          XFile? image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          File? imagePath =
                              image != null ? File(image.path) : null;
                          setState(() {
                            _image = image;
                            _profileImage = imagePath;
                          });
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                          child: _profileImage == null
                              ? Icon(Icons.camera_alt, size: 50)
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _isLoading
                          ? SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: register,
                                child: Text("Sign Up"),
                              ),
                            ),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an Account?"),
                            Text(
                              "Login",
                              style: TextStyle(
                                color: AppColor.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
