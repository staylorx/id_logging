import 'package:simple_logger/simple_logger.dart' as simple_logger;
import 'package:id_logging/id_logging.dart';

/// Implementation of Logger using the simple_logger package.
class SimpleLoggerImpl implements Logger {
  @override
  final String? name;

  final simple_logger.SimpleLogger _logger = simple_logger.SimpleLogger();

  LogLevel? _logLevel;

  SimpleLoggerImpl({this.name}) {
    // Set default level to ALL (show all logs)
    _logger.setLevel(simple_logger.Level.ALL);
    _logLevel = null;
  }

  @override
  LogLevel? get logLevel => _logLevel;

  @override
  set logLevel(LogLevel? level) {
    _logLevel = level;
    if (level == null) {
      _logger.setLevel(simple_logger.Level.ALL);
    } else {
      switch (level) {
        case LogLevel.debug:
          _logger.setLevel(simple_logger.Level.FINEST);
          break;
        case LogLevel.info:
          _logger.setLevel(simple_logger.Level.INFO);
          break;
        case LogLevel.warning:
          _logger.setLevel(simple_logger.Level.WARNING);
          break;
        case LogLevel.error:
          _logger.setLevel(simple_logger.Level.SEVERE);
          break;
      }
    }
  }

  @override
  /// Logs a message at the specified level.
  void log(LogLevel level, String message) {
    switch (level) {
      case LogLevel.debug:
        _logger.finest(message);
        break;
      case LogLevel.info:
        _logger.info(message);
        break;
      case LogLevel.warning:
        _logger.warning(message);
        break;
      case LogLevel.error:
        _logger.severe(message);
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
