import 'package:id_logging/id_logging.dart';
import 'package:logging/logging.dart' as logging_pkg;
import 'package:test/test.dart';

void main() {
  final records = <logging_pkg.LogRecord>[];

  setUp(() {
    records.clear();
    logging_pkg.hierarchicalLoggingEnabled = true;
    logging_pkg.Logger.root.onRecord.listen((record) => records.add(record));
  });

  tearDown(() {
    logging_pkg.Logger.root.clearListeners();
  });

  test('LoggerImpl logs messages without error', () {
    final logger = LoggerImpl(name: 'test_logger');

    expect(() => logger.debug('Debug message'), returnsNormally);
    expect(() => logger.info('Info message'), returnsNormally);
    expect(() => logger.warning('Warning message'), returnsNormally);
    expect(() => logger.error('Error message'), returnsNormally);
  });

  test('LoggerImpl logLevel can be set and retrieved', () {
    final logger = LoggerImpl(name: 'test_logger');

    expect(logger.logLevel, isNull);

    logger.logLevel = LogLevel.warning;
    expect(logger.logLevel, LogLevel.warning);

    logger.logLevel = null;
    expect(logger.logLevel, isNull);
  });

  test('LoggerImpl filters messages based on logLevel - debug', () {
    final logger = LoggerImpl(name: 'test_logger');
    logger.logLevel = LogLevel.debug;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(records.length, 4);
    expect(records[0].message, 'Debug');
    expect(records[1].message, 'Info');
    expect(records[2].message, 'Warning');
    expect(records[3].message, 'Error');
  });

  test('LoggerImpl filters messages based on logLevel - info', () {
    final logger = LoggerImpl(name: 'test_logger');
    logger.logLevel = LogLevel.info;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(records.where((r) => r.message == 'Debug').length, 0);
    expect(records.where((r) => r.message == 'Info').length, 1);
    expect(records.where((r) => r.message == 'Warning').length, 1);
    expect(records.where((r) => r.message == 'Error').length, 1);
  });

  test('LoggerImpl filters messages based on logLevel - warning', () {
    final logger = LoggerImpl(name: 'test_logger');
    logger.logLevel = LogLevel.warning;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(records.where((r) => r.message == 'Debug').length, 0);
    expect(records.where((r) => r.message == 'Info').length, 0);
    expect(records.where((r) => r.message == 'Warning').length, 1);
    expect(records.where((r) => r.message == 'Error').length, 1);
  });

  test('LoggerImpl filters messages based on logLevel - error', () {
    final logger = LoggerImpl(name: 'test_logger');
    logger.logLevel = LogLevel.error;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(records.where((r) => r.message == 'Debug').length, 0);
    expect(records.where((r) => r.message == 'Info').length, 0);
    expect(records.where((r) => r.message == 'Warning').length, 0);
    expect(records.where((r) => r.message == 'Error').length, 1);
  });

  test('LoggerImpl logs all when logLevel is null', () {
    final logger = LoggerImpl(name: 'test_logger');
    logger.logLevel = null;

    logger.debug('Debug');
    logger.info('Info');
    logger.warning('Warning');
    logger.error('Error');

    expect(records.length, 4);
  });

  test('LoggerImpl log method works', () {
    final logger = LoggerImpl(name: 'test_logger');

    logger.log(LogLevel.debug, 'Direct debug');
    logger.log(LogLevel.info, 'Direct info');

    expect(records.length, 2);
    expect(records[0].message, 'Direct debug');
    expect(records[1].message, 'Direct info');
  });
}
