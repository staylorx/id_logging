import 'package:id_logging/id_logging.dart';

/// Mixin that provides an optional logger for injection into repositories and use cases.
mixin Loggable {
  /// The optional logger instance.
  Logger? logger;
}
