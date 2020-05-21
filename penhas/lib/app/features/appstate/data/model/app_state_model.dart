import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

class AppStateModel extends AppStateEntity {
  final QuizSessionEntity quizSession;

  AppStateModel(this.quizSession) : super(quizSession: quizSession);

  factory AppStateModel.fromJson(Map<String, Object> jsonData) {
    final quizSession = _parseQuizSession(jsonData['quiz_session']);
    return AppStateModel(quizSession);
  }

  static QuizSessionEntity _parseQuizSession(Map<String, Object> session) {
    final currentMessage = _parseQuizMessage(session["current_msgs"]);
    final previousMessage = _parseQuizMessage(session['prev_msgs']);

    if (previousMessage != null) {
      currentMessage.insertAll(0, previousMessage);
    }

    final int sessionId = (session['session_id'] as num).toInt();
    return QuizSessionEntity(
      currentMessage: currentMessage,
      sessionId: sessionId,
    );
  }

  static List<QuizMessageEntity> _parseQuizMessage(List<Object> data) {
    if (data == null || data.isEmpty) {
      return null;
    }

    return data
        .map((e) => e as Map<String, Object>)
        .expand((e) => _buildMessage(e))
        .toList();
  }

  static List<QuizMessageEntity> _buildMessage(Map<String, Object> message) {
    if (message['display_response'] != null) {
      return _buildDisplayResponseMessage(message);
    }

    return [
      QuizMessageEntity(
        content: message['content'],
        type: QuizMessageType.from[message['type']],
        action: message['action'],
        ref: message['ref'],
        style: message['style'],
        options: _mapToOptions(message['options']),
      )
    ];
  }

  static List<QuizMessageEntity> _buildDisplayResponseMessage(
      Map<String, Object> message) {
    return [
      QuizMessageEntity(
        content: message['content'],
        type: QuizMessageType.displayText,
        style: "normal",
      ),
      QuizMessageEntity(
        content: message['display_response'],
        type: QuizMessageType.displayTextResponse,
        style: "normal",
      )
    ];
  }

  static List<QuizMessageMultiplechoicesOptions> _mapToOptions(
      List<Object> options) {
    if (options == null || options.isEmpty) {
      return null;
    }

    return options
        .map((e) => e as Map<String, Object>)
        .map(
          (e) => QuizMessageMultiplechoicesOptions(
            index: e['index'],
            display: e['display'],
          ),
        )
        .toList();
  }
}
