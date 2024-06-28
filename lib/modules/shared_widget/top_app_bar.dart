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
      backgroundColor: Colors.green,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: secondarybackground),
        onPressed: onLeftArrowPressed,
      ),
      title: Center(
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: secondarybackground),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.arrow_forward,
            color: Colors.transparent,
          ),
          onPressed: onRightArrowPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
