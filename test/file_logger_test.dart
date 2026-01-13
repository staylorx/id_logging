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
}
