import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:vioai/data/authentication/repository/authentication_repo.dart';
import 'package:vioai/data/openAI/models/message.dart';
import 'package:vioai/data/openAI/repository/repository.dart';
import 'package:vioai/injection/app_module.dart';
import 'package:vioai/views/home/widgets/chat_message.dart';

typedef ChatMessageWidgets = List<ChatMessageWidget>;
typedef Messages = List<Message>;

@injectable
class HomeScreenViewModel extends ChangeNotifier {
  final AppRepository _appRepository;
  final ScaffoldMessengerKey _scaffoldMessengerKey;
  final AuthenticationRepo _authenticationRepo;

  HomeScreenViewModel(
    this._appRepository,
    this._authenticationRepo,
    this._scaffoldMessengerKey,
  );

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

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
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

  bool _authenticating = false;
  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  Future<void> authenticateWithGoogle() async {
    authenticating = true;
    final response = await _authenticationRepo.signInWithGoogle();
    authenticating = false;
    response.fold(
      (e) {
        _scaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(content: Text("Unable to signin")),
        );
      },
      (r) {},
    );
  }

  void watchUserAuthStatus() {
    _authenticationRepo.watchUserAuthChanges().listen((e) {
      isLoggedIn = e;
    });
  }
}
