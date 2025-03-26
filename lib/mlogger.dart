import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';


abstract class LoggerService {
  void info(dynamic msg);
  void warning(dynamic msg);
  void debug(dynamic msg);
  void error(dynamic msg, [Object? exception, StackTrace? stackTrace]);
  void showLogs(BuildContext context);
}

class TalkerService implements LoggerService {
  final Talker talker;

  TalkerService(this.talker);
  
  // Фабричный конструктор для удобного создания
  factory TalkerService.init() {
    return TalkerService(TalkerFlutter.init());
  }

  @override
  void debug(dynamic msg) {
    talker.debug(msg);
  }

  @override
  void error(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    talker.error(msg, exception, stackTrace);
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

final log = TalkerService.init();
