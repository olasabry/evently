import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/ui_utlis.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Logo.png",
                height: MediaQuery.sizeOf(context).height * 0.2,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 24),

              DefaultTextFormField(
                hintText: "Name",
                controller: nameController,
                prefixIconImageName: "name",
              ),

              SizedBox(height: 16),
              DefaultTextFormField(
                hintText: "Email",
                controller: emailController,
                prefixIconImageName: "email",

                validator: (value) {
                  if (value == null || value.length < 5) {
                    return "Invalid Email";
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              DefaultTextFormField(
                hintText: "Password",
                controller: passwordController,
                prefixIconImageName: "password",

                validator: (value) {
                  if (value == null || value.length < 8) {
                    return "Password must be at least 8 charaters";
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),

              DefaultElevatedButton(
                label: "Create Account",
                onPressed: register,
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have Account ?",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  TextButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pushReplacementNamed(LoginScreen.routeName),
                    child: Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formkey.currentState!.validate()) {
      FirebaseService.register(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          )
          .then((user) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          })
          .catchError((error) {
            String? errorMessage;
            if (error is FirebaseAuthException) {
              errorMessage = error.message;
            }
            UiUtlis.showErrorMessage(errorMessage);
          });
    }
  }
}
