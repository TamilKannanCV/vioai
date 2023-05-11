import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/authentication/repository/authentication_repo.dart';
import 'package:vioai/data/openAI/models/message.dart';
import 'package:vioai/data/openAI/repository/repository.dart';
import 'package:vioai/injection/app_module.dart';

@injectable
class ChatMessageVm extends ChangeNotifier {
  final FlutterTts _flutterTts;
  final AppRepository _appRepository;
  final ScaffoldMessengerKey _scaffoldMessengerKey;
  final AuthenticationRepo _authenticationRepo;

  ChatMessageVm(this._appRepository, this._scaffoldMessengerKey,
      this._flutterTts, this._authenticationRepo) {
    _flutterTts.setCompletionHandler(() {
      isSpeaking = false;
    });
  }

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

  String? get getProfileImageUrl => _authenticationRepo.currentUser?.photoURL;

  Future<void> getResponseForQuery(Prompt prompt) async {
    _hasError = false;
    _botMsg = null;
    _loading = true;

    final response = await _appRepository.getBotResposneForPrompt(prompt);
    response.fold((e) {
      hasError = true;
      loading = false;
    }, (value) {
      loading = false;
      botMsg = value;
      speak(value.content);
    });
  }

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;
  set isSpeaking(bool value) {
    _isSpeaking = value;
    notifyListeners();
  }

  Future<void> stop() async {
    isSpeaking = await _flutterTts.stop() != 1;
  }

  Future<void> speak(String message) async {
    isSpeaking = await _flutterTts.speak(message) == 1;
  }

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    _scaffoldMessengerKey.currentState
        ?.showSnackBar(const SnackBar(content: Text("Copied!")));
  }
}
