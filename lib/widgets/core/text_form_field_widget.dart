import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.autofocus = false,
    this.autocorrect = false,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.helperText,
    this.onChanged,
    this.enabled = true,
    this.initialValue,
  }) : super(key: key);

  final String labelText;
  final String? hintText;
  final String? helperText;
  final TextInputAction textInputAction;
  final Icon? icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool autofocus;
  final bool autocorrect;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool enabled;
  final String? initialValue;

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        SizedBox(height: 6.0),
        TextFormField(
          initialValue: widget.initialValue,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          autofocus: widget.autofocus,
          autocorrect: widget.autocorrect,
          textCapitalization: widget.textCapitalization,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.obscureText && _obscureText,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            helperText: widget.helperText,
            labelText: widget.hintText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            disabledBorder:
                Theme.of(context).inputDecorationTheme.border?.copyWith(
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade900
                            : Colors.grey.shade400,
                      ),
                    ),
            fillColor: widget.enabled
                ? null
                : Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800.withOpacity(0.5)
                    : Colors.grey.shade200,
            filled: widget.enabled ? null : true,
            prefixIcon: widget.icon == null
                ? null
                : Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: widget.icon,
                  ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Ionicons.eye_off_outline
                          : Ionicons.eye_outline,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
