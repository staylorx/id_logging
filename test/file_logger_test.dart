import 'dart:io';
import 'package:id_logging/id_logging.dart';
import 'package:test/test.dart';

void main() {
  const filePath = 'build/test.log';

  setUp(() {
    Directory('build').createSync(recursive: true);
  });

  tearDown(() {
    final file = File(filePath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  });

  test('FileLoggerImpl writes messages to file', () {
    final logger = FileLoggerImpl(filePath: filePath, name: 'test_file');

    logger.debug('Debug message');
    logger.info('Info message');
    logger.warning('Warning message');
    logger.error('Error message');

    final file = File(filePath);
    expect(file.existsSync(), true);

    final content = file.readAsStringSync();
    expect(content.contains('Debug message'), true);
    expect(content.contains('Info message'), true);
    expect(content.contains('Warning message'), true);
    expect(content.contains('Error message'), true);
  });

  test('FileLoggerImpl filters messages based on logLevel - debug', () {
    final logger = FileLoggerImpl(filePath: filePath, name: 'test_file');
    logger.logLevel = LogLevel.debug;

    logger.debug('Debug message');
    logger.info('Info message');
    logger.warning('Warning message');
    logger.error('Error message');

    final file = File(filePath);
    expect(file.existsSync(), true);

    final content = file.readAsStringSync();
    expect(content.contains('Debug message'), true);
    expect(content.contains('Info message'), true);
    expect(content.contains('Warning message'), true);
    expect(content.contains('Error message'), true);
  });

  test('FileLoggerImpl filters messages based on logLevel - info', () {
    final logger = FileLoggerImpl(filePath: filePath, name: 'test_file');
    logger.logLevel = LogLevel.info;

    logger.debug('Debug message');
    logger.info('Info message');
    logger.warning('Warning message');
    logger.error('Error message');

    final file = File(filePath);
    expect(file.existsSync(), true);

    final content = file.readAsStringSync();
    expect(content.contains('Debug message'), false);
    expect(content.contains('Info message'), true);
    expect(content.contains('Warning message'), true);
    expect(content.contains('Error message'), true);
  });

  test('FileLoggerImpl filters messages based on logLevel - warning', () {
    final logger = FileLoggerImpl(filePath: filePath, name: 'test_file');
    logger.logLevel = LogLevel.warning;

    logger.debug('Debug message');
    logger.info('Info message');
    logger.warning('Warning message');
    logger.error('Error message');

    final file = File(filePath);
    expect(file.existsSync(), true);

    final content = file.readAsStringSync();
    expect(content.contains('Debug message'), false);
    expect(content.contains('Info message'), false);
    expect(content.contains('Warning message'), true);
    expect(content.contains('Error message'), true);
  });

  test('FileLoggerImpl filters messages based on logLevel - error', () {
    final logger = FileLoggerImpl(filePath: filePath, name: 'test_file');
    logger.logLevel = LogLevel.error;

    logger.debug('Debug message');
    logger.info('Info message');
    logger.warning('Warning message');
    logger.error('Error message');

    final file = File(filePath);
    expect(file.existsSync(), true);

    final content = file.readAsStringSync();
    expect(content.contains('Debug message'), false);
    expect(content.contains('Info message'), false);
    expect(content.contains('Warning message'), false);
    expect(content.contains('Error message'), true);
  });

  test('FileLoggerImpl logs all when logLevel is null', () {
    final logger = FileLoggerImpl(filePath: filePath, name: 'test_file');
    logger.logLevel = null;

    logger.debug('Debug message');
    logger.info('Info message');
    logger.warning('Warning message');
    logger.error('Error message');

    final file = File(filePath);
    expect(file.existsSync(), true);

    final content = file.readAsStringSync();
    expect(content.contains('Debug message'), true);
    expect(content.contains('Info message'), true);
    expect(content.contains('Warning message'), true);
    expect(content.contains('Error message'), true);
  });

  test('FileLoggerImpl log method works', () {
    final logger = FileLoggerImpl(filePath: filePath, name: 'test_file');

    logger.log(LogLevel.debug, 'Direct debug');
    logger.log(LogLevel.info, 'Direct info');

    final file = File(filePath);
    expect(file.existsSync(), true);

    final content = file.readAsStringSync();
    expect(content.contains('Direct debug'), true);
    expect(content.contains('Direct info'), true);
  });
}
