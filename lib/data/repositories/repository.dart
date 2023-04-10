import 'package:vioai/data/models/message.dart';

typedef Messages = List<Message>;

abstract class Repository {
  Future<Message> getBotResposneForMessages(Messages mesages);
}
