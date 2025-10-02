import 'package:dio/dio.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/core/services/api_services/api_services.dart';
import 'package:e_learning_app/src/features/message/model/conversation_model.dart';
import 'package:e_learning_app/src/features/message/model/message_model.dart';

class ConversationRepository {
  final ApiService _apiService = ApiService();

  Future<ConversationModel> getConversation() async {
    try {
      final Response response = await _apiService.get(ApiEndPoints.conversation);

      if (response.statusCode == 200) {
        return ConversationModel.fromJson(response.data);
      } else {
        return ConversationModel(
          success: false,
          message: "Error: ${response.statusCode}",
          data: [],
        );
      }
    } catch (e) {
      return ConversationModel(
        success: false,
        message: "Exception: $e",
        data: [],
      );
    }
  }

  Future<MessageModel> getMessages(
      String conversationId, String page, String perPage) async {
    try {
      final Response response = await _apiService.get(
        ApiEndPoints.getMessages(conversationId, page, perPage),
      );

      if (response.statusCode == 200) {
        return MessageModel.fromJson(response.data);
      } else {
        return MessageModel(
          success: false,
          message: "Error: ${response.statusCode}",
          data: [],
          pagination: null,
        );
      }
    } catch (e) {
      return MessageModel(
        success: false,
        message: "Exception: $e",
        data: [],
        pagination: null,
      );
    }
  }





}
