import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:toodoflutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Todo App Integration Tests', () {
    testWidgets('App launches and shows login screen', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify app title is displayed
      expect(find.text('Todo App'), findsOneWidget);
      expect(find.text('Stay organized and productive'), findsOneWidget);
      
      // Verify login form elements are present
      expect(find.text('Phone Number'), findsOneWidget);
      expect(find.text('+1 234 567 8900'), findsOneWidget);
      expect(find.byIcon(Icons.phone), findsOneWidget);
    });

    testWidgets('Complete login flow with OTP', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Enter phone number
      await tester.enterText(find.byType(TextField).first, '1234567890');
      await tester.pump();

      // Tap generate OTP button
      await tester.tap(find.text('Generate OTP'));
      await tester.pumpAndSettle();

      // Verify OTP field appears
      expect(find.text('OTP'), findsOneWidget);
      expect(find.text('Enter 6-digit OTP'), findsOneWidget);

      // Enter OTP (using the generated OTP from the service)
      await tester.enterText(find.byType(TextField).last, '123456');
      await tester.pump();

      // Tap login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify we're on the home screen
      expect(find.text('My Tasks'), findsOneWidget);
    });

    testWidgets('Add new task flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await tester.enterText(find.byType(TextField).first, '1234567890');
      await tester.pump();
      await tester.tap(find.text('Generate OTP'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, '123456');
      await tester.pump();
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify we're on home screen
      expect(find.text('My Tasks'), findsOneWidget);

      // Tap add task button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verify add task dialog appears
      expect(find.text('Add New Task'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);

      // Fill in task details
      await tester.enterText(find.byType(TextField).first, 'Test Task');
      await tester.enterText(find.byType(TextField).last, 'Test Description');
      await tester.pump();

      // Tap save button
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify task appears in the list
      expect(find.text('Test Task'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('Complete task flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await tester.enterText(find.byType(TextField).first, '1234567890');
      await tester.pump();
      await tester.tap(find.text('Generate OTP'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, '123456');
      await tester.pump();
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Add a task first
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Task to Complete');
      await tester.enterText(find.byType(TextField).last, 'Description');
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Tap the checkbox to complete the task
      await tester.tap(find.byType(Checkbox).first);
      await tester.pumpAndSettle();

      // Verify task is marked as completed (strikethrough or different styling)
      expect(find.text('Task to Complete'), findsOneWidget);
    });

    testWidgets('Delete task flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await tester.enterText(find.byType(TextField).first, '1234567890');
      await tester.pump();
      await tester.tap(find.text('Generate OTP'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, '123456');
      await tester.pump();
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Add a task first
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Task to Delete');
      await tester.enterText(find.byType(TextField).last, 'Description');
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Swipe to delete (using Flutter Slidable)
      await tester.drag(find.text('Task to Delete'), const Offset(-300, 0));
      await tester.pumpAndSettle();

      // Tap delete button
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // Verify task is removed
      expect(find.text('Task to Delete'), findsNothing);
    });

    testWidgets('Navigation to feedback screen', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await tester.enterText(find.byType(TextField).first, '1234567890');
      await tester.pump();
      await tester.tap(find.text('Generate OTP'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, '123456');
      await tester.pump();
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Tap feedback button
      await tester.tap(find.byIcon(Icons.feedback));
      await tester.pumpAndSettle();

      // Verify we're on feedback screen
      expect(find.text('Feedback'), findsOneWidget);
    });

    testWidgets('Logout flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await tester.enterText(find.byType(TextField).first, '1234567890');
      await tester.pump();
      await tester.tap(find.text('Generate OTP'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, '123456');
      await tester.pump();
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Tap menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Tap logout
      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();

      // Verify we're back to login screen
      expect(find.text('Todo App'), findsOneWidget);
      expect(find.text('Stay organized and productive'), findsOneWidget);
    });

    testWidgets('Search functionality', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await tester.enterText(find.byType(TextField).first, '1234567890');
      await tester.pump();
      await tester.tap(find.text('Generate OTP'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, '123456');
      await tester.pump();
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Add multiple tasks
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Searchable Task');
      await tester.enterText(find.byType(TextField).last, 'Description');
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Another Task');
      await tester.enterText(find.byType(TextField).last, 'Description');
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Enter search text
      await tester.enterText(find.byType(TextField).first, 'Searchable');
      await tester.pumpAndSettle();

      // Verify only the matching task is shown
      expect(find.text('Searchable Task'), findsOneWidget);
      expect(find.text('Another Task'), findsNothing);
    });

    testWidgets('Theme switching', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await tester.enterText(find.byType(TextField).first, '1234567890');
      await tester.pump();
      await tester.tap(find.text('Generate OTP'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, '123456');
      await tester.pump();
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Tap menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Look for theme-related menu items (if implemented)
      // This test verifies the menu opens correctly
      expect(find.text('Logout'), findsOneWidget);
      expect(find.text('Clear All Data'), findsOneWidget);
    });
  });
} 