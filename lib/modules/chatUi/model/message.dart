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

  //create fromMap
  factory Message.fromMap(Map<dynamic, dynamic> map) {
    return Message(
      text: map['text'] as String,
      isSentByMe: map['isSentByMe'] as bool,
      senderName: map['senderName'] as String,
      senderImage: map['senderImage'] as String,
      time: DateTime.parse(map['time'] as String),
      status: MessageStatus.values[map['status'] as int],
    );
  }

  //create toMap
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isSentByMe': isSentByMe,
      'senderName': senderName,
      'senderImage': senderImage,
      'time': time.toIso8601String(),
      'status': status.index,
    };
  }
}

enum MessageStatus { sent, seen }
