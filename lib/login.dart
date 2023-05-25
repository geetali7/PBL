import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  String email = '',
      pass = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 80, top: 100),
              child: const Text(
                  'Welcome\nback',
                  style: TextStyle(color: Colors.white, fontSize: 33)
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.5,
                      right: 35,
                      left: 35
                  ),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      TextField(
                        onChanged: (value) {
                          pass = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sign in',
                              style: TextStyle(
                                  color: Color(0xff4c505b),
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700)),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xff4c505b),
                            child: InkWell(
                              onTap: () async {
                                try {
                                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: email,
                                    password: pass,
                                  );
                                  Navigator.pushNamed(context, 'location');
                                } on FirebaseAuthException catch (e) {
                                  String errorMessage = '';
                                  if (e.code == 'user-not-found') {
                                    errorMessage = 'No user found f'
                                        'or that email.';
                                  } else if (e.code == 'wrong-password') {
                                    errorMessage = 'Wrong password provided for that user.';
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(errorMessage),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: const Icon(Icons.forward,
                                  size: 40.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'register');
                              },
                              child: const Text(
                                  'Not a user? Create an Account',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 18,
                                      color: Color(0xff4c505b)))),
                          // TextButton(
                          //     onPressed: () {
                          //       Navigator.pushNamed(context, 'forgot');
                          //     },
                          //     child: const Text('Forgot Password ? ',
                          //         style: TextStyle(
                          //             decoration: TextDecoration.underline,
                          //             fontSize: 18,
                          //             color: Color(0xff4c505b))))
                        ],
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}