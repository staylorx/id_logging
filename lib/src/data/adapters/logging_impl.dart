import 'package:logging/logging.dart' as logging_pkg;
import 'package:id_logging/id_logging.dart';

/// Implementation of Logger using the logging package.
class LoggingImpl implements Logger {
  @override
  final String name;

  final logging_pkg.Logger _logger;

  LogLevel? _logLevel;

  LoggingImpl({required this.name}) : _logger = logging_pkg.Logger(name) {
    _logLevel = null;
    logging_pkg.hierarchicalLoggingEnabled = true;
    _logger.level = logging_pkg.Level.ALL;
  }

  @override
  LogLevel? get logLevel => _logLevel;

  @override
  set logLevel(LogLevel? level) {
    _logLevel = level;
    logging_pkg.hierarchicalLoggingEnabled = true;
    if (level == null) {
      _logger.level = logging_pkg.Level.ALL;
    } else {
      switch (level) {
        case LogLevel.debug:
          _logger.level = logging_pkg.Level.ALL;
          break;
        case LogLevel.info:
          _logger.level = logging_pkg.Level.INFO;
          break;
        case LogLevel.warning:
          _logger.level = logging_pkg.Level.WARNING;
          break;
        case LogLevel.error:
          _logger.level = logging_pkg.Level.SEVERE;
          break;
      }
    }
  }

  @override
  /// Logs a message at the specified level.
  void log(LogLevel level, String message) {
    switch (level) {
      case LogLevel.debug:
        _logger.fine(message);
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

  /// Logs a fine message.
  void fine(String message) => log(LogLevel.debug, message);

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
