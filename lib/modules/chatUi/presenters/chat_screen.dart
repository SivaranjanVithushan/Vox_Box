import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vox_box/core/theme_data/colour_scheme.dart';
import 'package:vox_box/modules/chatUi/presenters/widget/message_bubble.dart';
import 'package:vox_box/modules/shared_widget/top_app_bar.dart';
import '../model/message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late DatabaseReference _messagesRef;
  late String _roomName;
  late String _roomId;
  late String _userName;
  late String _userProfileImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    _roomName = args['roomName'];
    _roomId = args['roomId'];
    _messagesRef =
        FirebaseDatabase.instance.ref().child('chat_rooms/$_roomId/messages');
    _userName = "LoggedInUser"; // Replace with the actual logged in user's name
    _userProfileImage =
        "https://via.placeholder.com/150"; // Replace with actual user's profile image URL

    _messagesRef.onChildAdded.listen((event) {
      final newMessage = Message.fromMap(event.snapshot.value as Map);
      setState(() {
        _messages.add(newMessage);
      });
      _scrollToBottom();
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      final newMessage = Message(
        text: _controller.text,
        isSentByMe: true,
        senderName: _userName,
        senderImage: _userProfileImage,
        time: DateTime.now(),
        status: MessageStatus.sent,
      );

      _messagesRef.push().set(newMessage.toMap());
      _controller.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: CustomAppBar(
        onLeftArrowPressed: () {
          Navigator.pop(context);
        },
        title: _roomName,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 0),
        decoration: const BoxDecoration(
          color: Color(0xffF0F0F3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: false,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(
                    text: _messages[index].text,
                    isSentByMe: _messages[index].isSentByMe,
                    senderName: _messages[index].senderName,
                    senderImage: _messages[index].senderImage,
                    time: _messages[index].time,
                    status: _messages[index].status,
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48.0, // Set a fixed height for the TextField
              child: TextField(
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Color(0xff1A1A1A)),
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffFFFFFF).withOpacity(0.4),
                  hintText: 'Type a message ...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Color.fromRGBO(208, 213, 221, 1)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          // Send button
          Material(
            color: primarybackground,
            shape: CircleBorder(),
            child: InkWell(
              onTap: _sendMessage,
              customBorder: CircleBorder(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                height: 48.0, // Adjust the size as needed
                width: 48.0, // Adjust the size as needed
                child: SvgPicture.asset(
                  'assets/icons/send.svg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
