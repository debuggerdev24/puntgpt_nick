import 'package:dartz/dartz.dart';
import 'package:puntgpt_nick/core/constants/end_points.dart';
import 'package:puntgpt_nick/core/helper/base_api_helper.dart';
import 'package:puntgpt_nick/models/bot/answer_model.dart';

class BotApiService {
  factory BotApiService() => _instance;
  BotApiService._internal();
  static final BotApiService _instance = BotApiService._internal();

  static BotApiService get instance => _instance;

  Future<Either<ApiException, AnswerModel>> getBotResponse({
    required String userQuery,
    String? sessionId,
  }) async {
    final data = <String, dynamic>{
      'user_query': userQuery,
      if (sessionId != null && sessionId.isNotEmpty) 'session_id': sessionId,
    };
    final result = await BaseApiHelper.instance.post<Map<String, dynamic>>(
      EndPoints.bot,
      data: data,
    );
    return result.map((r) => AnswerModel.fromJson(r));
  }
}