import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/bot/chat_message_model.dart';
import 'package:puntgpt_nick/service/bot/bot_api_service.dart';

class BotProvider extends ChangeNotifier {
  final List<ChatMessageModel> _messages = [];
  List<ChatMessageModel> get messages => List.unmodifiable(_messages);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _sessionId;
  String? get sessionId => _sessionId;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    _errorMessage = null;
    final userMsg = ChatMessageModel(
      isUser: true,
      content: content.trim(),
      timestamp: DateTime.now(),
    );
    _messages.add(userMsg);
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    final result = await BotApiService.instance.getBotResponse(
      userQuery: content.trim(),
      sessionId: _sessionId,
    );

    _isLoading = false;
    result.fold(
      (l) {
        Logger.error(l.errorMsg);
        _errorMessage = l.errorMsg;
        notifyListeners();
      },
      (r) {
        _sessionId = r.sessionId;
        final botMsg = ChatMessageModel(
          isUser: false,
          content: r.answer,
          timestamp: DateTime.now(),
        );
        _messages.add(botMsg);
        notifyListeners();
      },
    );
  }

  void clearMessages() {
    _messages.clear();
    _sessionId = null;
    _errorMessage = null;
    notifyListeners();
  }
}
