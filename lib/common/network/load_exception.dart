// Почему не удалось загрузить данные.
// Датасорс переводит в эти классы ошибки dio и разбора JSON,
// поэтому Cubit и экраны про dio не знают.
sealed class LoadException implements Exception {
  const LoadException();
}

// Нет сети, сервер недоступен или браузер не пропустил ответ (CORS).
final class NoConnectionException extends LoadException {
  const NoConnectionException();
}

final class TimeoutLoadException extends LoadException {
  const TimeoutLoadException();
}

// Сервер ответил 404: такой записи нет.
final class NotFoundException extends LoadException {
  const NotFoundException();
}

// Сервер ответил ошибкой, кроме 404.
final class ServerException extends LoadException {
  const ServerException(this.statusCode);

  final int? statusCode;
}

// Ответ пришёл, но не той формы, что описана в DTO.
final class BadResponseException extends LoadException {
  const BadResponseException();
}
