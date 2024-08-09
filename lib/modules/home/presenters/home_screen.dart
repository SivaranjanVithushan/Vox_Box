import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vox_box/modules/chatUi/presenters/chat_screen.dart';
import 'package:vox_box/modules/home/presenters/widgets/create_room_dialog.dart';
import 'package:vox_box/modules/home/presenters/widgets/join_room_dialog.dart';
import 'package:vox_box/modules/shared_widget/top_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _chatRoomsRef =
      FirebaseDatabase.instance.ref().child('chat_rooms');
  List<Map<String, dynamic>> _chatRooms = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchChatRooms();
  }

  void _fetchChatRooms() {
    _chatRoomsRef.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      final List<Map<String, dynamic>> rooms = [];
      data.forEach((key, value) {
        rooms.add({'id': key, 'name': value['name']});
      });
      setState(() {
        _chatRooms = rooms;
        _isLoading = false;
        _errorMessage = null;
      });
    }).onError((error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load chat rooms. Please try again later.';
      });
    });
  }

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
          children: [
            Text("Please create a new box or join an existing one",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            Expanded(
              child: _buildChatRoomList(),
            ),
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

  Widget _buildChatRoomList() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    } else if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: TextStyle(color: Colors.red),
        ),
      );
    } else if (_chatRooms.isEmpty) {
      return Center(
        child: Text(
          "No chat rooms available",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _chatRooms.length,
        itemBuilder: (context, index) {
          final room = _chatRooms[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(room['name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(),
                    settings: RouteSettings(
                      arguments: {
                        'roomId': room['id'],
                        'roomName': room['name'],
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }
}
