// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_center_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SupportCenterController on _SupportCenterControllerBase, Store {
  Computed<PageProgressState> _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_SupportCenterControllerBase.progressState'))
      .value;

  final _$_loadCategoriesAtom =
      Atom(name: '_SupportCenterControllerBase._loadCategories');

  @override
  ObservableFuture<Either<Failure, SupportCenterMetadataEntity>>
      get _loadCategories {
    _$_loadCategoriesAtom.reportRead();
    return super._loadCategories;
  }

  @override
  set _loadCategories(
      ObservableFuture<Either<Failure, SupportCenterMetadataEntity>> value) {
    _$_loadCategoriesAtom.reportWrite(value, super._loadCategories, () {
      super._loadCategories = value;
    });
  }

  final _$categoriesSelectedAtom =
      Atom(name: '_SupportCenterControllerBase.categoriesSelected');

  @override
  int get categoriesSelected {
    _$categoriesSelectedAtom.reportRead();
    return super.categoriesSelected;
  }

  @override
  set categoriesSelected(int value) {
    _$categoriesSelectedAtom.reportWrite(value, super.categoriesSelected, () {
      super.categoriesSelected = value;
    });
  }

  final _$onFilterActionAsyncAction =
      AsyncAction('_SupportCenterControllerBase.onFilterAction');

  @override
  Future<void> onFilterAction() {
    return _$onFilterActionAsyncAction.run(() => super.onFilterAction());
  }

  final _$onKeywordsActionAsyncAction =
      AsyncAction('_SupportCenterControllerBase.onKeywordsAction');

  @override
  Future<void> onKeywordsAction(String keywords) {
    return _$onKeywordsActionAsyncAction
        .run(() => super.onKeywordsAction(keywords));
  }

  @override
  String toString() {
    return '''
categoriesSelected: ${categoriesSelected},
progressState: ${progressState}
    ''';
  }
}
