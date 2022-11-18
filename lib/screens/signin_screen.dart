import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/form_screen.dart';
import 'package:ensa/widgets/core/text_form_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:validators/validators.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = '/signin';
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  bool _isLoading = false;

  List<String> _invalidEmails = [];

  Future<void> handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      const snackBar =
          SnackBar(content: Text('Please enter valid information'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      final credentials = Credentials(email: _email, password: _password);
      await userBloc.signIn(credentials);
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } on InvalidEmailError {
      const snackBar = SnackBar(
        content: Text('The email you have entered does not exist'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _invalidEmails.add(_email);
      });
    } on InvalidPasswordError {
      const snackBar = SnackBar(
        content: Text('The credentials you have entered are incorrect'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
      const snackBar = SnackBar(
        content: Text('Something went wrong'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      _isLoading = false;
    });
  }

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
                if (_invalidEmails.contains(value)) {
                  return 'This email is not valid';
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
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text('Sign in'),
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
