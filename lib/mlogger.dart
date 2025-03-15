import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';


abstract class LoggerService {
  void info(String msg);
  void warning(String msg);
  void debug(String msg);
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
  void debug(String msg) {
    talker.debug(msg);
  }

  @override
  void error(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    talker.error(msg, exception, stackTrace);
  }

  @override
  void info(String msg) {
    talker.info(msg);
  }

  @override
  void warning(String msg) {
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
