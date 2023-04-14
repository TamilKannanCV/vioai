import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/models/message.dart';
import 'package:vioai/data/repositories/repository.dart';

import '../../widgets/chat_message.dart';

typedef ChatMessageWidgets = List<ChatMessageWidget>;
typedef Messages = List<Message>;

@injectable
class HomeScreenViewModel extends ChangeNotifier {
  final AppRepository appRepository;
  HomeScreenViewModel(this.appRepository);

  ChatMessageWidgets _chatWidgets = <ChatMessageWidget>[];
  ChatMessageWidgets get chatWidgets => _chatWidgets;
  set chatWidgets(ChatMessageWidgets value) {
    _chatWidgets = value;
    notifyListeners();
  }

  Messages _messages = [];
  Messages get messages => _messages;
  set messages(Messages value) {
    _messages = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void sendMessage(Message message) {
    messages = [...messages, message];
    chatWidgets = [...chatWidgets, ChatMessageWidget(userMessage: message)];
  }

  void clearChats() {
    messages = [];
    chatWidgets = [];
  }
}
