import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

class SignupPage extends ConsumerStatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
          backgroundColor: AppColors.lightBackground,
        title: Text(
          'Comments',
          style: TextStyle(
            fontFamily: 'PoppinsBold',
            fontSize: 16,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(fontFamily: 'PoppinsMedium'),
                        filled: true,
                        fillColor: Colors.white, 
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10), 
                          borderSide: BorderSide.none, 
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16), 
                      ),
                      onChanged: (value) => _name = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your name' : null,
                    ),
                    SizedBox(height: 16), 

                    
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontFamily: 'PoppinsMedium'),
                        filled: true,
                        fillColor: Colors.white, 
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10), 
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16),
                      ),
                      onChanged: (value) => _email = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your email' : null,
                    ),
                    SizedBox(height: 16),

                    
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontFamily: 'PoppinsMedium'),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                          borderSide: BorderSide.none, 
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16), 
                      ),
                      obscureText: true,
                      onChanged: (value) => _password = value,
                      validator: (value) => value!.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), 

            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await ref.read(authServiceProvider).signUp(
                          name: _name,
                          email: _email,
                          password: _password,
                        );
                   
                    Navigator.pushReplacementNamed(context, '/');
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    "Signup",
                    style: TextStyle(
                        fontFamily: 'PoppinsBold', color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    fontFamily: 'PoppinsMedium',
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      color: AppColors.primaryBlue,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
