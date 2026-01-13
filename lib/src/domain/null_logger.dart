import 'package:id_logging/id_logging.dart';

/// A logger that ignores all log messages.
class NullLogger implements Logger {
  @override
  final String? name;

  const NullLogger({this.name});

  @override
  /// Ignores the log message.
  void log(LogLevel level, String message) {}
  @override
  /// Ignores the info message.
  void info(String message) {}
  @override
  /// Ignores the debug message.
  void debug(String message) {}
  @override
  /// Ignores the error message.
  void error(String message) {}
  @override
  /// Ignores the warning message.
  void warning(String message) {}
}
