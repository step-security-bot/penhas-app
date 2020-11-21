import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/extension/safetly_parser.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/notification/data/models/notification_session_model.dart';
import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';

abstract class INotificationRepository {
  Future<Either<Failure, ValidField>> unread();
  Future<Either<Failure, NotificationSessionModel>> notifications();
}

class NotificationRepository implements INotificationRepository {
  final IApiProvider _apiProvider;

  NotificationRepository({
    @required IApiProvider apiProvider,
  }) : this._apiProvider = apiProvider;

  @override
  Future<Either<Failure, ValidField>> unread() async {
    final endPoint = "/me/unread-notif-count";

    try {
      final bodyResponse = await _apiProvider.get(
        path: endPoint,
      );
      return right(parseUnread(bodyResponse));
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, NotificationSessionModel>> notifications() async {
    final endPoint = "/me/notifications";

    try {
      final bodyResponse = await _apiProvider.get(
        path: endPoint,
      );
      return right(parseNotifications(bodyResponse));
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _ParsePrivate on NotificationRepository {
  ValidField parseUnread(String body) {
    final jsonData = jsonDecode(body) as Map<String, Object>;
    final count = jsonData["count"].safeParseInt() ?? 0;
    return ValidField(message: count.toString());
  }

  NotificationSessionEntity parseNotifications(String body) {
    final jsonData = jsonDecode(body) as Map<String, Object>;
    return NotificationSessionModel.fromJson(jsonData);
  }
}
