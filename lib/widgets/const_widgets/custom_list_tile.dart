import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final VoidCallback? onPress;
  final IconData leadingIcon;
  final String title;
  final String? subTitle;
  final IconData? trailingIcon;
  const CustomListTile({
    Key? key,
    this.onPress,
    required this.leadingIcon,
    required this.title,
    this.subTitle = "",
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      contentPadding: const EdgeInsets.all(0.0),
      leading: Icon(
        leadingIcon,
        size: 30,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ).tr(),
      subtitle: Text(
        subTitle!,
        style: Theme.of(context).textTheme.labelMedium,
      ).tr(),
      trailing: Icon(trailingIcon),
    );
  }
}
