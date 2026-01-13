/// Enum representing different log levels.
enum LogLevel { debug, info, warning, error }

/// Abstract port for logging functionality.
abstract class Logger {
  /// The optional name of the logger.
  String? get name;

  /// The optional log level. If null, show all logs.
  LogLevel? get logLevel;

  /// Sets the log level. If null, show all logs.
  set logLevel(LogLevel? level);

  /// Log a message at the specified level.
  void log(LogLevel level, String message);

  /// Convenience method for debug level logging.
  void debug(String message);

  /// Convenience method for info level logging.
  void info(String message);

  /// Alias for warning level logging.
  void warning(String message);

  /// Convenience method for error level logging.
  void error(String message);
}
