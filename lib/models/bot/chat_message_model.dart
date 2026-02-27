class ChatMessageModel {
  const ChatMessageModel({
    required this.isUser,
    required this.content,
    required this.timestamp,
  });

  final bool isUser;
  final String content;
  final DateTime timestamp;

  String get senderLabel => isUser ? '@you' : '@PuntGPT';
}
