import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';

class MockTweetRepository extends Mock implements ITweetRepository {}

class MockTweetFilterPreference extends Mock implements TweetFilterPreference {}

void main() {
  ITweetRepository repository;
  TweetFilterPreference filterPreference;

  setUp(() {
    repository = MockTweetRepository();
    filterPreference = MockTweetFilterPreference();
  });

  group('FeedUseCases', () {
    test('should not hit datasource on instantiate', () async {
      // act
      FeedUseCases(repository: repository, filterPreference: filterPreference);
      // assert
      verifyNoMoreInteractions(repository);
    });
    group('create', () {
      int maxRowsPerRequet;

      setUp(() {
        maxRowsPerRequet = 5;
      });

      test('should create tweet', () async {
        // arrange
        final sut = FeedUseCases(
          repository: repository,
          filterPreference: filterPreference,
          maxRows: maxRowsPerRequet,
        );
        when(repository.create(option: anyNamed('option')))
            .thenAnswer((_) async => right(
                  TweetEntity(
                      id: '200608T1805540001',
                      userName: 'maria',
                      clientId: 424,
                      createdAt: '2020-06-08 18:05:54',
                      totalReply: 0,
                      totalLikes: 0,
                      anonymous: false,
                      content: 'Mensagem 1',
                      avatar:
                          'https:\/\/elasv2-api.appcivico.com\/avatar\/padrao.svg',
                      meta: TweetMeta(liked: false, owner: true),
                      lastReply: []),
                ));
        final expected = right(FeedCache(
          tweets: [
            TweetEntity(
              id: '200608T1805540001',
              userName: 'maria',
              clientId: 424,
              createdAt: '2020-06-08 18:05:54',
              totalReply: 0,
              totalLikes: 0,
              anonymous: false,
              content: 'Mensagem 1',
              avatar: 'https:\/\/elasv2-api.appcivico.com\/avatar\/padrao.svg',
              meta: TweetMeta(liked: false, owner: true),
              lastReply: [],
            ),
          ],
        ));
        // act
        final received = await sut.create('Mensagem 1');
        // assert
        expect(expected, received);
      });
    });
  });
}
