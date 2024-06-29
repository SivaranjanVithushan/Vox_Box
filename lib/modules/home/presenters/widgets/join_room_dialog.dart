import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vox_box/core/theme_data/text_theme.dart';
import 'package:vox_box/modules/home/presenters/chatroom_contoller.dart';

class JoinRoomDialog extends ConsumerStatefulWidget {
  @override
  _JoinRoomDialogState createState() => _JoinRoomDialogState();
}

class _JoinRoomDialogState extends ConsumerState<JoinRoomDialog> {
  final _formKey = GlobalKey<FormState>();
  String _boxId = '';

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(chatRoomViewModelProvider);

    return AlertDialog(
      titlePadding: EdgeInsets.only(bottom: 20, top: 30, left: 16, right: 16),
      title: Center(
        child: Text('Join Room',
            style: textTheme.titleLarge!.copyWith(
              color: Colors.black,
            )),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
              // controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: Color(0xff34A853), width: 1.0)),
                contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
                hintText: 'Box ID',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a box ID';
                }
                return null;
              },
              onSaved: (value) {
                _boxId = value!;
              },
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(top: 14, bottom: 14),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xff34A853),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  viewModel.joinRoom(_boxId).then((result) {
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid box ID'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        '/chat',
                        arguments: {
                          'roomId': result['roomId'],
                          'roomName': result['roomName'],
                        },
                      );
                    }
                  });
                }
              },
              child: Text(
                'Join',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
