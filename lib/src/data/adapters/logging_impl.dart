import 'package:logging/logging.dart' as logging_pkg;
import 'package:id_logging/id_logging.dart';

/// Implementation of Logger using the logging package.
class LoggerImpl implements Logger {
  @override
  final String name;

  final logging_pkg.Logger _logger;

  LoggerImpl({required this.name}) : _logger = logging_pkg.Logger(name);

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
