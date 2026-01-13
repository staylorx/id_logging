# id_logging

[![pub package](https://img.shields.io/pub/v/id_logging.svg)](https://pub.dev/packages/id_logging)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Logging implementations for Clean Architecture projects in Dart.

## Features

- Clean Architecture compliant logging interfaces
- Multiple logger implementations (console, file)
- Dependency injection support
- Loggable mixin for optional logger injection
- Logger extensions for automatic context
- Null logger for testing

## Installation

Add `id_logging` to your `pubspec.yaml`:

```yaml
dependencies:
  id_logging: ^1.0.0
```

Then run:

```bash
dart pub get
```

## Usage

### Basic Logging

```dart
import 'package:id_logging/id_logging.dart';

// Create a console logger
final logger = ConsoleLoggerImpl(name: 'MyApp');

// Log messages
logger.info('This is an info message');
logger.error('This is an error message');
```

### Dependency Injection

```dart
class MyService {
  final Logger logger;

  MyService(this.logger);

  void doSomething() {
    logger.debug('Doing something');
  }
}

// Inject the logger
final service = MyService(ConsoleLoggerImpl(name: 'MyService'));
```

### Using the Loggable Mixin

```dart
class MyClass with Loggable {
  void performAction() {
    logger?.info('Action performed');
  }
}

// Inject logger later
final instance = MyClass();
instance.logger = ConsoleLoggerImpl(name: 'MyClass');
```

## Examples

See the [`examples/`](examples/) directory for more detailed usage examples.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.