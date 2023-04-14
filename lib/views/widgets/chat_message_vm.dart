import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/repositories/repository.dart';

import '../../data/models/message.dart';

@injectable
class ChatMessageVm extends ChangeNotifier {
  final AppRepository appRepository;

  ChatMessageVm(this.appRepository);

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Message? _botMsg;
  Message? get botMsg => _botMsg;
  set botMsg(Message? value) {
    _botMsg = value;
    notifyListeners();
  }

  bool _hasError = false;
  bool get hasError => _hasError;
  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  Future<void> getResponseForQuery(Prompt prompt) async {
    _hasError = false;
    _botMsg = null;
    _loading = true;

    final response = await appRepository.getBotResposneForPrompt(prompt);
    response.fold((e) {
      hasError = true;
      loading = false;
    }, (value) {
      loading = false;
      botMsg = value;
    });
  }
}
