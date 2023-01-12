import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SettingsItem extends StatelessWidget {
  final Widget title;
  final IconData icon;
  final bool hideChevron;
  final bool dense;
  final bool danger;
  final void Function()? onTap;
  final Widget? suffix;
  final bool forceDarkText;

  const SettingsItem({
    required this.title,
    required this.icon,
    this.hideChevron = false,
    this.onTap,
    this.dense = true,
    this.danger = false,
    this.suffix,
    this.forceDarkText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: dense ? 10.0 : 14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(
                  icon,
                  color: danger
                      ? Colors.red.shade400
                      : Theme.of(context).primaryColor,
                  size: 25.0,
                ),
              ),
              Transform.translate(
                offset: const Offset(0.0, 2.0),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: danger
                            ? Colors.red
                            : forceDarkText
                                ? Colors.grey.shade900
                                : null,
                      ),
                  child: title,
                ),
              ),
              if (!hideChevron || suffix != null) ...[
                Expanded(child: Container()),
                suffix != null
                    ? suffix!
                    : Icon(
                        Ionicons.chevron_forward_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                SizedBox(width: 12.0),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
