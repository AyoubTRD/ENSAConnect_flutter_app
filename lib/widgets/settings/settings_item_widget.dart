import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool hideChevron;
  final bool dense;
  final void Function()? onTap;

  const SettingsItem({
    required this.title,
    required this.icon,
    this.hideChevron = false,
    this.onTap,
    this.dense = true,
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
                  color: Theme.of(context).primaryColor,
                  size: 25.0,
                ),
              ),
              Transform.translate(
                offset: Offset(0.0, 2.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              if (!hideChevron) ...[
                Expanded(child: Container()),
                Icon(
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
