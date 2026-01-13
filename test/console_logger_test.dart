import 'package:id_logging/id_logging.dart';
import 'package:test/test.dart';

void main() {
  test('ConsoleLoggerImpl logs messages without error', () {
    final logger = ConsoleLoggerImpl(name: 'test_console');

    expect(() => logger.debug('Debug message'), returnsNormally);
    expect(() => logger.info('Info message'), returnsNormally);
    expect(() => logger.warning('Warning message'), returnsNormally);
    expect(() => logger.error('Error message'), returnsNormally);
  });

  test('ConsoleLoggerImpl logLevel can be set and retrieved', () {
    final logger = ConsoleLoggerImpl(name: 'test_console');

    expect(logger.logLevel, isNull);

    logger.logLevel = LogLevel.warning;
    expect(logger.logLevel, LogLevel.warning);

    logger.logLevel = null;
    expect(logger.logLevel, isNull);
  });
}
