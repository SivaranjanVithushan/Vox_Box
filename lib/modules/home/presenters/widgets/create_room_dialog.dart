import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vox_box/core/theme_data/text_theme.dart';
import 'package:vox_box/modules/home/presenters/chatroom_contoller.dart';

class CreateRoomDialog extends ConsumerStatefulWidget {
  @override
  _CreateRoomDialogState createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends ConsumerState<CreateRoomDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Room'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: textTheme.labelMedium,
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Room Name',
              errorText: _errorMessage,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final errorMessage = await ref
                .read(chatRoomViewModelProvider)
                .createRoom(_controller.text.trim());
            if (errorMessage != null) {
              setState(() {
                _errorMessage = errorMessage;
              });
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}
