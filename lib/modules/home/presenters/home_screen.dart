import 'package:flutter/material.dart';
import 'package:vox_box/modules/shared_widget/top_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _createBoxController = TextEditingController();
  TextEditingController _joinBoxController = TextEditingController();
  String? _createErrorMessage;
  String? _joinErrorMessage;

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
        _showCreateDialog(context);
      } else if (value == 'join') {
        _showJoinDialog(context);
      }
    });
  }

  void _showCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.only(
                  top: 32, left: 16, right: 16, bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Create New Box',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                    controller: _createBoxController,
                    decoration: InputDecoration(
                      hintText: 'Box Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorText: _createErrorMessage,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        String boxName = _createBoxController.text.trim();

                        if (boxName.isNotEmpty) {
                          // Proceed with create action
                          Navigator.of(context).pop();
                          // Perform your create action here
                        } else {
                          _createErrorMessage =
                              'Please fill in the Box Name field.';
                        }
                      });
                    },
                    child: Text('Create'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showJoinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.only(
                  top: 32, left: 16, right: 16, bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Join Box',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                    controller: _joinBoxController,
                    decoration: InputDecoration(
                      hintText: 'Box ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorText: _joinErrorMessage,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        String boxId = _joinBoxController.text.trim();

                        if (boxId.isNotEmpty) {
                          // Proceed with join action
                          Navigator.of(context).pop();
                          // Perform your join action here
                        } else {
                          _joinErrorMessage =
                              'Please fill in the Box ID field.';
                        }
                      });
                    },
                    child: Text('Join'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _createBoxController.dispose();
    _joinBoxController.dispose();
    super.dispose();
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
