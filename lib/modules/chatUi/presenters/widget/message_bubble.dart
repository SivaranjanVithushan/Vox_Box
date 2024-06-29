import 'package:flutter/material.dart';
import 'package:vox_box/modules/chatUi/model/message.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final String senderName;
  final String senderImage;
  final DateTime time;
  final MessageStatus status;

  const MessageBubble({
    required this.text,
    required this.isSentByMe,
    required this.senderName,
    required this.senderImage,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Alignment alignment =
        isSentByMe ? Alignment.centerRight : Alignment.centerLeft;
    Color textColor = isSentByMe ? Colors.white : Colors.black;
    Color messageColor = isSentByMe ? Colors.green : Colors.white;
    BorderRadius messageBorderRadius = isSentByMe
        ? const BorderRadius.only(
            topRight: Radius.circular(16.0),
            topLeft: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          );

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: alignment,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isSentByMe) ...[
                CircleAvatar(
                  backgroundImage: NetworkImage(senderImage),
                  radius: 15.0,
                ),
                SizedBox(width: 10.0),
              ],
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    crossAxisAlignment: isSentByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (!isSentByMe)
                        Text(
                          senderName,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color: Color(0xff9A9BB1)),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: messageColor,
                          borderRadius: messageBorderRadius,
                        ),
                        child: Column(
                          crossAxisAlignment: isSentByMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              text,
                              style: TextStyle(color: textColor),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${time.hour}:${time.minute}",
                                  style: TextStyle(
                                      color: isSentByMe
                                          ? Color(0xffE9EAEB)
                                          : Color(0xffD0D1DB),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                if (isSentByMe) ...[
                                  SizedBox(width: 5.0),
                                  Icon(
                                    status == MessageStatus.delivered
                                        ? Icons.done_all_outlined
                                        : Icons.done_all_outlined,
                                    color: status == MessageStatus.sent
                                        ? Colors.blue
                                        : Colors.white70,
                                    size: 12.0,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
