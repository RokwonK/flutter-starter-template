import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logger = BaseLogger();

class BaseLogger {
  BaseLogger();

  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
    ),
  );

  void d(String message) {
    if (!kDebugMode) return;
    logger.d(message); // Debug
  }

  void i(String message) {
    if (!kDebugMode) return;
    logger.i(message); // Info
  }

  void w(String message) {
    if (!kDebugMode) return;
    logger.w(message); // Warning
  }

  void e(String message) {
    if (!kDebugMode) return;
    logger.e(message); // Error
  }
}