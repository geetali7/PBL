import 'package:flutter/material.dart';

class MyForgot extends StatefulWidget {
  MyForgot({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  State<MyForgot> createState() => _MyForgotState();
}

class _MyForgotState extends State<MyForgot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Forgot Password')),
        body: Column(
            children: [
              TextField(
                controller: widget.emailController,
                decoration: InputDecoration(hintText: 'Email'),
          )
        ]
        ),
    );
  }
}
