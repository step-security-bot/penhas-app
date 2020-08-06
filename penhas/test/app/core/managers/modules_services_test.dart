import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

class MockLocalStorage extends Mock implements ILocalStorage {}

void main() {
  AppModulesServices sut;
  ILocalStorage storage;
  String appModuleKey;

  String _convert(List<AppStateModuleEntity> modules) {
    final objects =
        modules.map((e) => {'code': e.code, 'meta': e.meta}).toList();
    return jsonEncode(objects);
  }

  group('AppModulesServices', () {
    setUp(() {
      storage = MockLocalStorage();
      appModuleKey = 'br.com.penhas.appModules';
      sut = AppModulesServices(storage: storage);
    });
    test(
        'should hit the local storage with correct id and struct from correct model',
        () async {
      // arrange
      final modules = [
        AppStateModuleEntity(code: 'module_1', meta: '{}'),
        AppStateModuleEntity(code: 'module_2', meta: '{"data":true}'),
      ];
      final jsonString = _convert(modules);
      when(storage.put(any, any)).thenAnswer((_) => Future.value());
      // act
      await sut.save(modules);
      // assert
      verify(storage.put(appModuleKey, jsonString));
    });
  });
}
