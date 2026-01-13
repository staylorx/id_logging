import 'package:logger/logger.dart' as logger_pkg;
import 'package:id_logging/id_logging.dart';

/// Implementation of Logger using the logger package for console output.
class ConsoleLoggerImpl implements Logger {
  @override
  final String? name;

  final logger_pkg.Logger _logger;

  LogLevel? _logLevel;

  ConsoleLoggerImpl({this.name, logger_pkg.LogPrinter? printer})
    : _logger = logger_pkg.Logger(
        printer:
            printer ??
            logger_pkg.PrettyPrinter(
              methodCount: 0,
              errorMethodCount: 5,
              lineLength: 50,
              colors: true,
              printEmojis: true,

              dateTimeFormat: logger_pkg.DateTimeFormat.onlyTimeAndSinceStart,
            ),
      ),
      _logLevel = null {
    logger_pkg.Logger.level = logger_pkg.Level.trace;
  }

  @override
  LogLevel? get logLevel => _logLevel;

  @override
  set logLevel(LogLevel? level) {
    _logLevel = level;
    if (level == null) {
      logger_pkg.Logger.level = logger_pkg.Level.trace;
    } else {
      switch (level) {
        case LogLevel.debug:
          logger_pkg.Logger.level = logger_pkg.Level.trace;
          break;
        case LogLevel.info:
          logger_pkg.Logger.level = logger_pkg.Level.info;
          break;
        case LogLevel.warning:
          logger_pkg.Logger.level = logger_pkg.Level.warning;
          break;
        case LogLevel.error:
          logger_pkg.Logger.level = logger_pkg.Level.error;
          break;
      }
    }
  }

  @override
  /// Logs a message at the specified level.
  void log(LogLevel level, String message) {
    switch (level) {
      case LogLevel.debug:
        _logger.d(message);
        break;
      case LogLevel.info:
        _logger.i(message);
        break;
      case LogLevel.warning:
        _logger.w(message);
        break;
      case LogLevel.error:
        _logger.e(message);
        break;
    }
  }

  @override
  /// Logs a debug message.
  void debug(String message) => log(LogLevel.debug, message);

  @override
  /// Logs an info message.
  void info(String message) => log(LogLevel.info, message);

  @override
  /// Logs a warning message.
  void warning(String message) => log(LogLevel.warning, message);

  @override
  /// Logs an error message.
  void error(String message) => log(LogLevel.error, message);
}
