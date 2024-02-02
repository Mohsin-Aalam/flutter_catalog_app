import 'package:flutter/material.dart';
import 'package:flutter_catalog/core/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/Welcoming.png"),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: "Enter your email"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email can't be empty";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Enter your Password",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter password";
                        } else if (value.length < 6) {
                          return 'at least 6 character';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, MyRoutes.homeRoute);
                        }
                      },
                      icon: const Icon(Icons.login),
                      style: TextButton.styleFrom(
                          minimumSize: const Size(150, 40)),
                      label: const Text("Login"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
