import 'package:ensa/screens/form_screen.dart';
import 'package:ensa/widgets/text_form_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:validators/validators.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: 'Sign In',
      subtitle:
          'Please enter your valid information below in order to login to your account',
      bottomText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2,
          text: 'Don\'t have an account? ',
          children: [
            TextSpan(
              text: 'Create One',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pop();
                },
            ),
          ],
        ),
      ),
      form: Form(
        key: _formKey,
        child: Column(
          children: [
            MyTextFormField(
              labelText: 'Email address',
              hintText: 'name@example.com',
              keyboardType: TextInputType.emailAddress,
              icon: Icon(Ionicons.mail_outline),
              validator: (String? value) {
                if (value == null || value == '') {
                  return 'Please enter an email';
                }
                if (!isEmail(value)) {
                  return 'Please enter a valid email';
                }
              },
            ),
            SizedBox(height: 25.0),
            MyTextFormField(
              textInputAction: TextInputAction.go,
              labelText: 'Password',
              hintText: '∗∗∗∗∗∗∗∗',
              obscureText: true,
              icon: Icon(
                Ionicons.lock_closed_outline,
              ),
              validator: (String? value) {
                if (value == null || value == '') {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'This password is too short';
                }
                if (value.length > 32) {
                  return 'This password is too long';
                }
              },
            ),
            SizedBox(height: 25.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
                child: Text('Sign in'),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
