import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'app_test.dart' as app_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Todo App Integration Tests', () {
    setUpAll(() async {
      // Any setup needed before all tests
    });

    tearDownAll(() async {
      // Any cleanup needed after all tests
    });

    setUp(() async {
      // Setup before each test
    });

    tearDown(() async {
      // Cleanup after each test
    });

    // Import and run the actual test file
    app_test.main();
  });
} 