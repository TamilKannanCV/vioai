import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vioai/data/openAI/models/completion_request.dart';
import 'package:vioai/data/openAI/models/completion_response.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.openai.com/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/chat/completions")
  Future<CompletionResponse> getCompletionReponse(
      @Body() CompletionRequest request);
}
