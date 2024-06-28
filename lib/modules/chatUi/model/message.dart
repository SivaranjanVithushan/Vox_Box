class Message {
  final String text;
  final bool isSentByMe;
  final String senderName;
  final String senderImage;
  final DateTime time;
  final MessageStatus status;

  Message({
    required this.text,
    required this.isSentByMe,
    required this.senderName,
    required this.senderImage,
    required this.time,
    required this.status,
  });
}

enum MessageStatus { sent, seen }
