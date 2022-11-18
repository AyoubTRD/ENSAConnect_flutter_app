import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/core/form_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/text_form_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:validators/validators.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _fullName = '';
  String _password = '';
  String _avatar = '';
  List<String> _usedEmails = [];

  bool _isLoading = false;

  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final words = _fullName.split(' ');
      final userInput = UserInput(
          avatar: _avatar,
          email: _email,
          firstName: words[0],
          lastName: words.getRange(1, words.length).join(' '),
          password: _password);
      setState(() {
        _isLoading = true;
      });
      try {
        await userBloc.signUp(userInput);
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      } on EmailTakenError {
        setState(() {
          _usedEmails.add(_email);
          // _formKey.currentState!.validate();
        });
      } catch (e) {
        final snackBar = SnackBar(
          content: Text('Something went wrong!'),
          duration: Duration(milliseconds: 1500),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      final snackBar =
          SnackBar(content: Text('Please enter valid information'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

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
              onChanged: (v) {
                setState(() {
                  _fullName = v;
                });
              },
              validator: (String? value) {
                if (value == null || value == '') {
                  return 'This field is required';
                }
                value = value.trim();
                if (value.split(' ').length < 2 ||
                    value.split(' ').contains('') ||
                    value.length < 5) {
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
              onChanged: (v) {
                setState(() {
                  _email = v;
                });
              },
              validator: (String? value) {
                if (value == null || value == '') {
                  return 'Please enter an email';
                }
                if (!isEmail(value)) {
                  return 'Please enter a valid email';
                }
                if (_usedEmails.contains(value)) {
                  return 'This email has already been taken';
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
              onChanged: (v) {
                setState(() {
                  _password = v;
                });
              },
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
                onPressed: _isLoading ? null : handleSubmit,
                child: _isLoading
                    ? SizedBox(
                        width: 19.0,
                        height: 19.0,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text('Sign up'),
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
