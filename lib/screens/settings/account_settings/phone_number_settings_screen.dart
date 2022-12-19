import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/settings/account_settings/account_settings_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/core/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class PhoneNumberSettingsScreen extends StatefulWidget {
  const PhoneNumberSettingsScreen({Key? key}) : super(key: key);

  static const routeName = AccountSettingsScreen.routeName + '/phone-number';

  @override
  State<PhoneNumberSettingsScreen> createState() =>
      _PhoneNumberSettingsScreenState();
}

class _PhoneNumberSettingsScreenState extends State<PhoneNumberSettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _phoneNumber;
  bool _isLoading = false;

  Future<void> handleSave() async {
    late final formattedPhoneNumber;
    try {
      final phoneNumber =
          await FlutterLibphonenumber().parse(_phoneNumber!, region: 'MA');

      formattedPhoneNumber = phoneNumber['international'];
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number'),
        ),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await userBloc.updatePhoneNumber(formattedPhoneNumber);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your phone number has been updated successfully!'),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
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
        title: Text(
          'Add/Update Phone Number',
          style: Theme.of(context).textTheme.headline4,
        ),
        showBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: StreamBuilder<UserMixin?>(
          stream: userBloc.currentUser,
          builder: (BuildContext context, AsyncSnapshot<UserMixin?> snapshot) {
            if (!snapshot.hasData) return Container();

            if (_phoneNumber == null) {
              if (snapshot.data!.phoneNumber == null)
                _phoneNumber = '+212';
              else
                _phoneNumber = snapshot.data!.phoneNumber;
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextFormField(
                    initialValue: _phoneNumber,
                    labelText: 'Phone Number',
                    onChanged: (String val) {
                      setState(() {
                        _phoneNumber = val;
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
                          ? SizedBox(
                              height: 18.0,
                              width: 18.0,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text('Save'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
