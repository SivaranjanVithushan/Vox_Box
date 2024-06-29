class Message {
  final String text;
  final String senderId;
  final String senderName;
  final String senderImage;
  final DateTime time;
  final MessageStatus status;
  final String? imageUrl;

  Message({
    required this.text,
    required this.senderId,
    required this.senderName,
    required this.senderImage,
    required this.time,
    required this.status,
    this.imageUrl,
  });

  //create fromMap
  factory Message.fromMap(Map<dynamic, dynamic> map) {
    return Message(
      text: map['text'] as String,
      senderId: map['senderId'] as String,
      senderName: map['senderName'] as String,
      senderImage: map['senderImage'] as String,
      time: DateTime.parse(map['time'] as String),
      status: MessageStatus.values[map['status'] as int],
      imageUrl: map['imageUrl'] as String?,
    );
  }

  //create toMap
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'senderImage': senderImage,
      'time': time.toIso8601String(),
      'status': status.index,
      'imageUrl': imageUrl,
    };
  }
}

enum MessageStatus { sent, delivered, read }
