import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:logger/logger.dart' as log;


abstract class LoggerService {
  void info(dynamic msg);
  void warning(dynamic msg);
  void debug(dynamic msg);
  void error(dynamic msg, [Object? exception, StackTrace? stackTrace]);
  void critical(dynamic msg, [Object? exception, StackTrace? stackTrace]); 
  void showLogs(BuildContext context);
}

class TalkerService implements LoggerService {
  final Talker talker;

  TalkerService(this.talker);
  
  @override
  void debug(dynamic msg) {
    talker.debug(msg);
  }

  @override
  void error(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    talker.error(msg, exception, stackTrace);
  }

   @override
  void critical(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    talker.critical(msg, exception, stackTrace);
  }

  @override
  void info(dynamic msg) {
    talker.info(msg);
  }

  @override
  void warning(dynamic msg) {
    talker.warning(msg);
  }
  
  @override
  void showLogs(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TalkerScreen(talker: talker)),
    );
  }
}


class SimpleLoggerService implements LoggerService {
  final log.Logger _logger;

  SimpleLoggerService() : _logger = log.Logger(
    printer: log.PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: log.DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  @override
  void debug(dynamic msg) {
    _logger.d(msg);
  }

  @override
  void error(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    _logger.e(msg, error: exception, stackTrace: stackTrace);
  }

  @override
  void info(dynamic msg) {
    _logger.i(msg);
  }

  @override
  void warning(dynamic msg) {
    _logger.w(msg);
  }

  @override
  void critical(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    _logger.f(msg, error: exception, stackTrace: stackTrace);
  }

  @override
  void showLogs(BuildContext context) {
    // Простое сообщение, так как Logger не имеет UI
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Логи доступны в консоли')),
    );
  }
}
