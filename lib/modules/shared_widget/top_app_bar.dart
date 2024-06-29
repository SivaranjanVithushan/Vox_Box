// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:vox_box/core/theme_data/colour_scheme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLeftArrowPressed;
  final VoidCallback? onRightArrowPressed;

  const CustomAppBar({
    required this.title,
    this.onLeftArrowPressed,
    this.onRightArrowPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      foregroundColor: secondarybackground,
      backgroundColor: Colors.green,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: secondarybackground),
      ),
      actions: [
        Visibility(
          visible: onRightArrowPressed != null,
          child: IconButton(
            icon: Icon(
              Icons.copy,
              color: secondarybackground,
            ),
            onPressed: onRightArrowPressed,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
