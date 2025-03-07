// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escape_manual_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EscapeManualController on _EscapeManualControllerBase, Store {
  Computed<PageProgressState>? _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_EscapeManualControllerBase.progressState'))
      .value;

  final _$stateAtom = Atom(name: '_EscapeManualControllerBase.state');

  @override
  EscapeManualState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(EscapeManualState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_reactionAtom = Atom(name: '_EscapeManualControllerBase._reaction');

  @override
  EscapeManualReaction? get _reaction {
    _$_reactionAtom.reportRead();
    return super._reaction;
  }

  @override
  set _reaction(EscapeManualReaction? value) {
    _$_reactionAtom.reportWrite(value, super._reaction, () {
      super._reaction = value;
    });
  }

  final _$_pageProgressAtom =
      Atom(name: '_EscapeManualControllerBase._pageProgress');

  @override
  ObservableFuture<dynamic>? get _pageProgress {
    _$_pageProgressAtom.reportRead();
    return super._pageProgress;
  }

  @override
  set _pageProgress(ObservableFuture<dynamic>? value) {
    _$_pageProgressAtom.reportWrite(value, super._pageProgress, () {
      super._pageProgress = value;
    });
  }

  final _$loadAsyncAction = AsyncAction('_EscapeManualControllerBase.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$openAssistantAsyncAction =
      AsyncAction('_EscapeManualControllerBase.openAssistant');

  @override
  Future<void> openAssistant(EscapeManualAssistantActionEntity action) {
    return _$openAssistantAsyncAction.run(() => super.openAssistant(action));
  }

  @override
  String toString() {
    return '''
state: ${state},
progressState: ${progressState}
    ''';
  }
}
