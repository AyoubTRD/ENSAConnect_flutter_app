import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/settings/account_settings/account_settings_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/core/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NameSettingsScreen extends StatefulWidget {
  const NameSettingsScreen({Key? key}) : super(key: key);

  static const routeName = AccountSettingsScreen.routeName + '/name';

  @override
  State<NameSettingsScreen> createState() => _NameSettingsScreenState();
}

class _NameSettingsScreenState extends State<NameSettingsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _firstName;
  String? _lastName;

  bool _isLoading = false;

  bool hasChanged() {
    return _firstName?.toLowerCase() !=
            userBloc.currentUser.value?.firstName.toLowerCase() ||
        _lastName?.toLowerCase() !=
            userBloc.currentUser.value?.lastName.toLowerCase();
  }

  bool canSave() {
    return hasChanged() && _formKey.currentState!.validate();
  }

  void confirmSave() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm name change'),
        content: Text(
          'You will not be able to change your name again until ' +
              DateFormat().add_yMMMMEEEEd().format(
                    DateTime.now().add(
                      const Duration(days: 30),
                    ),
                  ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              handleSave();
            },
            child: Text(
              'Update',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleSave() async {
    if (!canSave()) return;
    setState(() {
      _isLoading = true;
    });

    try {
      await userBloc.updateName(_firstName!, _lastName!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your name has been updated successfully'),
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
          'Change First & Last Name',
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

            if (_firstName == null && _lastName == null) {
              _firstName = snapshot.data!.firstName;
              _lastName = snapshot.data!.lastName;
            }

            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        labelText: 'First Name',
                        hintText: 'John',
                        initialValue: _firstName,
                        enabled: snapshot.data!.canUpdateName,
                        textCapitalization: TextCapitalization.words,
                        validator: (String? val) {
                          if (val == null || val.length < 2)
                            return 'Please enter a valid first name';
                        },
                        onChanged: (String val) {
                          setState(() {
                            _firstName = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      MyTextFormField(
                        labelText: 'Last Name',
                        hintText: 'Doe',
                        initialValue: _lastName,
                        enabled: snapshot.data!.canUpdateName,
                        textCapitalization: TextCapitalization.words,
                        validator: (String? val) {
                          if (val == null || val.length < 2)
                            return 'Please enter a valid last name';
                        },
                        onChanged: (String val) {
                          setState(() {
                            _lastName = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: canSave() ? confirmSave : null,
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
                if (snapshot.data!.canUpdateName)
                  Text(
                    "You won't be able to change your name again for 30 days.",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                else
                  Text(
                    "You won't be able to change your name again until " +
                        DateFormat().add_yMMMMEEEEd().format(
                              snapshot.data!.lastUpdatedName!.add(
                                const Duration(days: 30),
                              ),
                            ) +
                        ".",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.red.shade400,
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
