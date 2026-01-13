import 'package:id_logging/id_logging.dart';

extension LoggerExtension on Logger {
  void log<T>(String method, String message) {
    info('${T.toString()}.$method: $message');
  }
}
