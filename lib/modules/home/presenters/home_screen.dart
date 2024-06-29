import 'package:flutter/material.dart';
import 'package:vox_box/modules/home/presenters/widgets/create_room_dialog.dart';
import 'package:vox_box/modules/home/presenters/widgets/join_room_dialog.dart';
import 'package:vox_box/modules/shared_widget/top_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController _createBoxController = TextEditingController();
  // TextEditingController _joinBoxController = TextEditingController();
  // String? _createErrorMessage;
  // String? _joinErrorMessage;

  void _showPopupMenu(BuildContext context, Offset offset) async {
    await showMenu(
      constraints: BoxConstraints(minWidth: 180),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx - 120,
        offset.dy - 135,
        offset.dx,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'create',
          child: ListTile(
            title: Text(
              'Create New',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        PopupMenuItem(
          value: 'join',
          child: ListTile(
            title: Text('Join a box',
                style: Theme.of(context).textTheme.labelMedium),
          ),
        )
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 'create') {
        showDialog(context: context, builder: (_) => CreateRoomDialog());
      } else if (value == 'join') {
        showDialog(context: context, builder: (_) => JoinRoomDialog());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: CustomAppBar(
        title: 'My Boxes',
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 48, right: 16, left: 16, bottom: 48),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Please create a new box or join an existing one",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;
              final RenderBox button = context.findRenderObject() as RenderBox;
              final Offset offset =
                  button.localToGlobal(Offset.zero, ancestor: overlay);
              _showPopupMenu(context, offset);
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
