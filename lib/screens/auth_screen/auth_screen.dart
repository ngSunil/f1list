import 'package:f1list/screens/auth_screen/auth_widgets/sign_in_form.dart';
import 'package:f1list/screens/auth_screen/auth_widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _showSignInForm = true;
  void _toggleState() {
    setState(() {
      _showSignInForm = !_showSignInForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                  onPressed: _toggleState,
                  icon: const Icon(Icons.person),
                  label: Text(_showSignInForm ? 'Sign Up' : 'Sign In')),
            ),
            Text('F1list',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.orange[900])),
            Text('<Your ultimate To Do List/>',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.blue[300])),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            _showSignInForm ? SignInForm() : SignUpForm()
          ]),
        ),
      ),
    );
  }
}
