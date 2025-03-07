import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/appstate/data/model/user_profile_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  AppStateModel appStateModel;
  UserProfileModel? userProfile;
  setUp(() {
    userProfile = UserProfileModel(
      nickname: 'maria',
      email: 'email@valid.com',
      avatar: 'https://api.com/avatar/padrao.svg',
      birthdate: DateTime(1980, 3, 3),
      fullName: 'Fulana da Silva',
      race: 'pardo',
      genre: 'Feminino',
    );
  });

  group('AppStateModel', () {
    test('should be a subclass of AppStateEntity', () async {
      // arrange
      const session = QuizSessionModel(
        currentMessage: [],
        sessionId: '1',
        endScreen: 'home',
        isFinished: false,
      );
      const appMode = AppStateModeEntity();
      final List<AppStateModuleEntity> modes = [];
      // act
      appStateModel = AppStateModel(session, userProfile, appMode, modes);
      // assert
      expect(appStateModel, isA<AppStateEntity>());
    });

    List<QuizMessageEntity> _currentMessage() {
      return [
        const QuizMessageModel(
          content:
              'Olá, eu sou a Assistente PenhaS ☺️ e vou te ajudar a conhecer o aplicativo 🤳',
          type: QuizMessageType.displayText,
          style: 'normal',
        ),
        const QuizMessageModel(
          content:
              'Vou começar com algumas perguntas, para saber melhor como te ajudar',
          type: QuizMessageType.displayText,
          style: 'normal',
        ),
        const QuizMessageModel(
          content: 'Atualmente, você está em um relacionamento amoroso?',
          type: QuizMessageType.yesno,
          ref: 'YN1',
        ),
      ];
    }

    List<QuizMessageEntity> _currentMessageWithPrevious() {
      return [
        const QuizMessageModel(
          content:
              'Olá, eu sou a Assistente PenhaS ☺️ e vou te ajudar a conhecer o aplicativo 🤳',
          type: QuizMessageType.displayText,
          style: 'normal',
        ),
        const QuizMessageModel(
          content:
              'Vou começar com algumas perguntas, para saber melhor como te ajudar',
          type: QuizMessageType.displayText,
          style: 'normal',
        ),
        const QuizMessageModel(
          content: 'Atualmente, você está em um relacionamento amoroso?',
          type: QuizMessageType.displayText,
          style: 'normal',
        ),
        const QuizMessageModel(
          content: 'Sim',
          type: QuizMessageType.displayTextResponse,
          style: 'normal',
        ),
        const QuizMessageModel(
          content:
              'Você acredita que tem uma relação saudável com o seu parceiro ou parceira?',
          type: QuizMessageType.yesno,
          ref: 'YN3',
        ),
      ];
    }

    List<QuizMessageEntity> _currentMessageWithMultipleChoices() {
      return [
        const QuizMessageModel(
          content:
              'Que tal nos contar um pouco como você acha que pode ajudar outras mulheres? Suas opções ficarão visíveis para as outras usuárias',
          type: QuizMessageType.multipleChoices,
          ref: 'MC7',
          options: [
            QuizMessageChoiceOptionModel(
              index: '0',
              display: 'Escuta acolhedora',
            ),
            QuizMessageChoiceOptionModel(
              index: '1',
              display: 'Psicologia',
            ),
            QuizMessageChoiceOptionModel(index: '2', display: 'Abrigo'),
          ],
        ),
      ];
    }

    List<QuizMessageEntity> _currentMessageWithTutorialStealth() {
      return [
        const QuizMessageModel(
          content:
              'Fulana da Silva, pelas suas respostas avalio que você está em situação de risco ⚠️',
          type: QuizMessageType.displayText,
          style: 'normal',
        ),
        const QuizMessageModel(
          content:
              'Para garantir sua segurança, nenhuma outra usuária do PenhaS saberá sua identidade e você terá um perfil anônimo 👭',
          type: QuizMessageType.displayText,
          style: 'normal',
        ),
        const QuizMessageModel(
          content:
              'Também recomendamos que você utilize o PenhaS com o <b>Modo Camuflado ativado</b>. Isso criará um disfarce para o app. Veja como funciona',
          type: QuizMessageType.showStealthTutorial,
          action: 'botao_tela_modo_camuflado',
          buttonLabel: 'Ver',
          ref: 'BT6',
        ),
      ];
    }

    List<QuizMessageEntity> _currentMessageWithSingleButton() {
      return [
        const QuizMessageModel(
          content:
              'Lindo 💜 Obrigada! Assim você nos ajuda a construir um ambiente em que mais mulheres se sintam mais seguras 🤗',
          type: QuizMessageType.button,
          action: 'botao_fim',
          buttonLabel: 'Finalizar',
          ref: 'BT9',
        ),
      ];
    }

    List<AppStateModuleEntity> _currentModules() {
      return [
        const AppStateModuleEntity(code: 'modo_anonimo', meta: '{}'),
        const AppStateModuleEntity(
          code: 'modo_seguranca',
          meta: '{"numero":"000"}',
        ),
        const AppStateModuleEntity(code: 'modo_camuflado', meta: '{}'),
      ];
    }

    test('should return a valid model with only current message in JSON',
        () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final List<QuizMessageEntity> currentMessage = _currentMessage();
      final QuizSessionEntity quizSession = QuizSessionModel(
        currentMessage: currentMessage,
        sessionId: '200',
        endScreen: null,
        isFinished: false,
      );
      const appMode = AppStateModeEntity(
        hasActivedGuardian: true,
      );
      final modules = _currentModules();

      final AppStateEntity expected = AppStateModel(
        quizSession,
        userProfile,
        appMode,
        modules,
      );
      // act
      final result = AppStateModel.fromJson(jsonData);
      // assert
      expect(result, expected);
    });

    test('should return a valid model with JSON with previous message',
        () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
        from: 'profile/quiz_session_response_with_previous_message.json',
      );
      final List<QuizMessageEntity> currentMessage =
          _currentMessageWithPrevious();
      final QuizSessionEntity quizSession = QuizSessionModel(
        currentMessage: currentMessage,
        sessionId: '247',
        endScreen: null,
        isFinished: false,
      );
      const appMode = AppStateModeEntity();
      final modules = _currentModules();
      final userProfile = UserProfileModel(
        nickname: 'maria',
        email: 'email@valid.com',
        avatar: 'https://api.com/avatar/padrao.svg',
        anonymousModeEnabled: true,
        birthdate: DateTime(1980, 3, 3),
        fullName: 'Fulana da Silva',
        race: 'pardo',
        genre: 'Feminino',
      );
      final AppStateEntity expected = AppStateModel(
        quizSession,
        userProfile,
        appMode,
        modules,
      );
      // act
      final result = AppStateModel.fromJson(jsonData);
      // assert
      expect(result, expected);
    });

    test('should return a valid model with JSON with multiplechoices',
        () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
        from: 'profile/quiz_session_resonse_multiple_choices.json',
      );
      final List<QuizMessageEntity> currentMessage =
          _currentMessageWithMultipleChoices();
      final QuizSessionEntity quizSession = QuizSessionModel(
        currentMessage: currentMessage,
        sessionId: '255',
        endScreen: null,
        isFinished: false,
      );
      const appMode = AppStateModeEntity();
      final modules = _currentModules();
      final userProfile = UserProfileModel(
        nickname: 'maria',
        email: 'email@valid.com',
        avatar: 'https://api.com/avatar/padrao.svg',
        stealthModeEnabled: true,
        birthdate: DateTime(1980, 3, 3),
        fullName: 'Fulana da Silva',
        race: 'pardo',
        genre: 'Feminino',
      );
      final AppStateEntity expected = AppStateModel(
        quizSession,
        userProfile,
        appMode,
        modules,
      );
      // act
      final result = AppStateModel.fromJson(jsonData);
      // assert
      expect(result, expected);
    });

    test('should return a valid model with JSON with showTutorial', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
        from: 'profile/quiz_session_response_stealth_mode.json',
      );
      final List<QuizMessageEntity> currentMessage =
          _currentMessageWithTutorialStealth();
      final QuizSessionEntity quizSession = QuizSessionModel(
        currentMessage: currentMessage,
        sessionId: '200',
        endScreen: null,
        isFinished: false,
      );
      const appMode = AppStateModeEntity(
        hasActivedGuardian: true,
      );
      final modules = _currentModules();
      final AppStateEntity expected = AppStateModel(
        quizSession,
        userProfile,
        appMode,
        modules,
      );
      // act
      final result = AppStateModel.fromJson(jsonData);
      // assert
      expect(result, expected);
    });

    test('should return a valid model with JSON with single button', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
        from: 'profile/quiz_session_response_button_fim.json',
      );
      final List<QuizMessageEntity> currentMessage =
          _currentMessageWithSingleButton();
      final QuizSessionEntity quizSession = QuizSessionModel(
        currentMessage: currentMessage,
        sessionId: '310',
        endScreen: 'home',
        isFinished: true,
      );
      const appMode = AppStateModeEntity();
      final modules = _currentModules();
      final AppStateEntity expected = AppStateModel(
        quizSession,
        userProfile,
        appMode,
        modules,
      );
      // act
      final result = AppStateModel.fromJson(jsonData);
      // assert
      expect(result, expected);
    });
  });
}
