import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vox_box/modules/home/presenters/chatroom_contoller.dart';

class JoinRoomDialog extends ConsumerStatefulWidget {
  @override
  _JoinRoomDialogState createState() => _JoinRoomDialogState();
}

class _JoinRoomDialogState extends ConsumerState<JoinRoomDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Join Room'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Room ID',
              errorText: _errorMessage,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final errorMessage = await ref
                .read(chatRoomViewModelProvider)
                .joinRoom(_controller.text.trim());
            if (errorMessage != null) {
              setState(() {
                _errorMessage = errorMessage;
              });
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text('Join'),
        ),
      ],
    );
  }
}
