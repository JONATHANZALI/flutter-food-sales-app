import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/screens/forgetPwScreen.dart';
import 'package:food_app/screens/homeScreen.dart';
import 'package:food_app/services/auth.dart';
import 'package:food_app/utils/userProvider.dart';
import 'package:provider/provider.dart';
import '../const/colors.dart';
import '../screens/signUpScreen.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void login() async {
    // Activate the progress indicator
    setState(() {
      _isLoading = true;
    });
    //   sign in the user
    try {
      User? firebaseUser = await AuthService().signInWithEmailPassword(
          _emailController.text, _passwordController.text);
      if (firebaseUser == null) {
        throw Exception("Incorrect email or password");
      }
      //   Retrieve the user information
      UserModel? myUser = await AuthService().fetchUserModel(firebaseUser.uid);
      if (myUser == null) {
        throw Exception("Incorrect email or password");
      }
      // Update the provider with user data.
      Provider.of<UserProvider>(context, listen: false).setUser(myUser);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      //   Stop the loader
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: Helper.getTheme(context).titleLarge,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text('Add your details to login'),
                      const SizedBox(
                        height: 18,
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
                        height: 18,
                      ),
                      CustomTextInput(
                        hintText: "Password",
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) =>
                            value!.length < 5 ? 'password too short' : null,
                      ),
                      const SizedBox(
                        height: 18,
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
                                onPressed: login,
                                child: Text("Login"),
                              ),
                            ),
                      const SizedBox(
                        height: 18,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(ForgetPwScreen.routeName);
                        },
                        child: Text("Forget your password?"),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Text("or Login With"),
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(
                                0xFF367FC0,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Helper.getAssetName(
                                  "fb.png",
                                  "virtual",
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text("Login with Facebook")
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(
                                0xFFDD4B39,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Helper.getAssetName(
                                  "google.png",
                                  "virtual",
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text("Login with Google")
                            ],
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignUpScreen.routeName);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an Account?"),
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                color: AppColor.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            )
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
    );
  }
}
