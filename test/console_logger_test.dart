import 'package:id_logging/id_logging.dart';
import 'package:logger/logger.dart' as logger_pkg;
import 'package:test/test.dart';

class TestPrinter extends logger_pkg.LogPrinter {
  final List<String> logs = [];

  @override
  List<String> log(logger_pkg.LogEvent event) {
    logs.add('${event.level.name}: ${event.message}');
    return [];
  }
}

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

  test('ConsoleLoggerImpl filters messages based on logLevel - debug', () {
    final printer = TestPrinter();
    final logger = ConsoleLoggerImpl(name: 'test_console', printer: printer);
    logger.logLevel = LogLevel.debug;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(printer.logs.length, 4);
    expect(printer.logs[0], 'debug: Debug');
    expect(printer.logs[1], 'info: Info');
    expect(printer.logs[2], 'warning: Warning');
    expect(printer.logs[3], 'error: Error');
  });

  test('ConsoleLoggerImpl filters messages based on logLevel - info', () {
    final printer = TestPrinter();
    final logger = ConsoleLoggerImpl(name: 'test_console', printer: printer);
    logger.logLevel = LogLevel.info;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(printer.logs.length, 3);
    expect(printer.logs[0], 'info: Info');
    expect(printer.logs[1], 'warning: Warning');
    expect(printer.logs[2], 'error: Error');
  });

  test('ConsoleLoggerImpl filters messages based on logLevel - warning', () {
    final printer = TestPrinter();
    final logger = ConsoleLoggerImpl(name: 'test_console', printer: printer);
    logger.logLevel = LogLevel.warning;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(printer.logs.length, 2);
    expect(printer.logs[0], 'warning: Warning');
    expect(printer.logs[1], 'error: Error');
  });

  test('ConsoleLoggerImpl filters messages based on logLevel - error', () {
    final printer = TestPrinter();
    final logger = ConsoleLoggerImpl(name: 'test_console', printer: printer);
    logger.logLevel = LogLevel.error;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(printer.logs.length, 1);
    expect(printer.logs[0], 'error: Error');
  });

  test('ConsoleLoggerImpl logs all when logLevel is null', () {
    final printer = TestPrinter();
    final logger = ConsoleLoggerImpl(name: 'test_console', printer: printer);
    logger.logLevel = null;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(printer.logs.length, 4);
  });

  test('ConsoleLoggerImpl log method works', () {
    final printer = TestPrinter();
    final logger = ConsoleLoggerImpl(name: 'test_console', printer: printer);

    logger.log(LogLevel.debug, 'Direct debug');
    logger.log(LogLevel.info, 'Direct info');

    expect(printer.logs.length, 2);
    expect(printer.logs[0], 'debug: Direct debug');
    expect(printer.logs[1], 'info: Direct info');
  });
}
