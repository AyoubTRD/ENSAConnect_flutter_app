import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/settings/account_settings/account_settings_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/core/text_form_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PasswordSettingsScreen extends StatefulWidget {
  const PasswordSettingsScreen({Key? key}) : super(key: key);

  static const routeName = AccountSettingsScreen.routeName + '/password';

  @override
  State<PasswordSettingsScreen> createState() => _PasswordSettingsScreenState();
}

class _PasswordSettingsScreenState extends State<PasswordSettingsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _oldPassword;
  String? _newPassword;
  String? _confirmPassword;

  bool _isLoading = false;

  Future<void> handleSave() async {
    if (_newPassword != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords don\'t match'),
        ),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    try {
      await userBloc.updatePassword(_oldPassword!, _newPassword!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your password has been updated successfully!'),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pop();
    } on InvalidOldPasswordError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid old password'),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error has ocurred'),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: true,
        showBackButton: true,
        title: Text(
          'Change/Reset Password',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: StreamBuilder<UserMixin?>(
          stream: userBloc.currentUser,
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );

            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        labelText: 'Old Password',
                        obscureText: true,
                        validator: (String? val) {
                          if (val == null || val == '') {
                            return 'Please enter your old password';
                          }
                        },
                        onChanged: (String val) {
                          setState(() {
                            _oldPassword = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      MyTextFormField(
                        labelText: 'New Password',
                        obscureText: true,
                        validator: (String? val) {
                          if (val == null || val == '') {
                            return 'Please enter a password';
                          }
                          if (val.length < 6) {
                            return 'This password is too short';
                          }
                          if (val.length > 32) {
                            return 'This password is too long';
                          }
                        },
                        onChanged: (String val) {
                          setState(() {
                            _newPassword = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      MyTextFormField(
                        obscureText: true,
                        labelText: 'Confirm New Password',
                        onChanged: (String val) {
                          setState(() {
                            _confirmPassword = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: handleSave,
                          child: _isLoading
                              ? const SizedBox(
                                  width: 19.0,
                                  height: 19.0,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text('Update'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    text: 'Forgot your password? ',
                    children: [
                      TextSpan(
                        text: 'Reset it here.',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
