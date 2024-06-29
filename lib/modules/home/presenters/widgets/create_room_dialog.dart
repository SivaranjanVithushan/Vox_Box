import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vox_box/core/theme_data/text_theme.dart';
import 'package:vox_box/modules/home/presenters/chatroom_contoller.dart';
import 'package:vox_box/modules/shared_widget/input.dart';

class CreateRoomDialog extends ConsumerStatefulWidget {
  @override
  _CreateRoomDialogState createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends ConsumerState<CreateRoomDialog> {
  final _formKey = GlobalKey<FormState>();
  String _boxName = '';

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(chatRoomViewModelProvider);

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      titlePadding: EdgeInsets.only(bottom: 20, top: 30, left: 16, right: 16),
      title: Center(
          child: Text(
        'Create Room',
        style: textTheme.titleLarge!.copyWith(
          color: Colors.black,
        ),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Input(
                  controller: TextEditingController(),
                  hintText: 'Box Name',
                  errorText: 'Please enter a room name',
                  onSaved: (value) {
                    _boxName = value!;
                  },
                ),
              ],
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    viewModel.createRoom(_boxName).then((result) {
                      if (result == null) {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(
                          context,
                          '/chat',
                          arguments: {
                            'roomName': _boxName,
                            'roomId': viewModel.latestRoomId
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                      }
                    });
                  }
                },
                child: Text(
                  'Create',
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
          ),
        ],
      ),
    );
  }
}
