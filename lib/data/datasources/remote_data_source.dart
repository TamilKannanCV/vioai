import 'package:vioai/data/models/message.dart';

abstract class RemoteDataSource {
  
  Future<Message> getBotResponseForMessages(List<Message> messages);
}
