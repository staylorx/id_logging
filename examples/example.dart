// ignore_for_file: avoid_print

import 'package:id_logging/id_logging.dart';

/// Example 1: Using Logger with Clean Architecture Dependency Injection
///
/// In Clean Architecture, the Logger is injected into use cases or repositories
/// via the constructor. This allows for easy testing and swapping of implementations.
class UserRepository {
  final Logger logger;

  UserRepository(this.logger);

  void fetchUser(String id) {
    logger.info('Fetching user with id: $id');
    // Simulate fetching logic
    logger.debug('User fetched successfully');
  }
}

void exampleCleanArchInjection() {
  // Create a concrete logger implementation
  final logger = ConsoleLoggerImpl(name: 'UserRepository');

  // Inject the logger into the repository
  final userRepo = UserRepository(logger);

  // Use the repository
  userRepo.fetchUser('123');
}

/// Example 2: Using the Loggable Mixin for Injectable Logger
///
/// The Loggable mixin provides an optional logger field that makes it obvious
/// where a logger can be injected later. This is useful for classes that may
/// need logging but where dependency injection setup is deferred.
class DataService with Loggable {
  void processData(String data) {
    // Use the injected logger if available
    logger?.info('Processing data: $data');
    // Processing logic
    logger?.debug('Data processed successfully');
  }
}

void exampleLoggableMixin() {
  final dataService = DataService();

  // Later, inject the logger when ready
  dataService.logger = ConsoleLoggerImpl(name: 'DataService');

  // Use the service
  dataService.processData('sample data');
}

/// Example 3: Using the Logger Extension for Automatic Context
///
/// The Logger extension provides a convenient way to log messages with
/// automatic class and method context. This can be used alongside the Loggable
/// mixin or directly on any Logger instance. Note: The extension adds a generic
/// `log<T>` method, but due to naming conflict with the Logger's log method,
/// it's shown here with manual context for clarity.
class ApiClient with Loggable {
  void makeRequest(String endpoint) {
    // The extension allows: logger?.log<ApiClient>('makeRequest', 'Making request to $endpoint');
    // But for demonstration, using standard logging with manual context
    logger?.info('ApiClient.makeRequest: Making request to $endpoint');
    // Request logic
    logger?.info('ApiClient.makeRequest: Request completed');
  }
}

void exampleLoggerExtension() {
  final apiClient = ApiClient();

  // Inject the logger
  apiClient.logger = ConsoleLoggerImpl(name: 'ApiClient');

  // Use the client
  apiClient.makeRequest('/api/users');
}

void main() {
  print('Example 1: Clean Architecture Injection');
  exampleCleanArchInjection();
  print('\nExample 2: Loggable Mixin for Injectable Logger');
  exampleLoggableMixin();
  print('\nExample 3: Logger Extension for Automatic Context');
  exampleLoggerExtension();
}
