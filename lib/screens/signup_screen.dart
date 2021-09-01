import 'package:ensa/screens/form_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/text_form_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:validators/validators.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: 'Sign Up',
      subtitle:
          'Please enter your valid information in order to create your account',
      bottomText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2,
          text: 'Already have an account? ',
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: kPrimaryColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed('/signin');
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
              labelText: 'Full name',
              hintText: 'John Smith',
              textCapitalization: TextCapitalization.words,
              icon: Icon(
                Ionicons.person_outline,
              ),
              validator: (String? value) {
                if (value == null || value == '') {
                  return 'This field is required';
                }
                value = value.trim();
                if (value.indexOf(' ') == -1 || value.length < 5) {
                  return 'Please enter the full name';
                }
              },
            ),
            SizedBox(height: 25.0),
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
                child: Text('Sign up'),
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
