import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toodoflutter/models/task.dart';
import 'package:toodoflutter/widgets/add_task_dialog.dart';

void main() {
  group('AddTaskDialog Widget Tests', () {
    late Task? testTask;
    bool onSaveCalled = false;
    Task? savedTask;

    setUp(() {
      testTask = null;
      onSaveCalled = false;
      savedTask = null;
    });

    Widget createAddTaskDialog({
      Task? task,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return AddTaskDialog(
                task: task,
              );
            },
          ),
        ),
      );
    }

    group('Basic Rendering Tests', () {
      testWidgets('should render dialog with all form fields', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        expect(find.text('Add Task'), findsOneWidget);
        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Description'), findsOneWidget);
        expect(find.text('Category'), findsOneWidget);
        expect(find.text('Priority'), findsOneWidget);
        expect(find.text('Due Date'), findsOneWidget);
        expect(find.text('Save'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
      });

      testWidgets('should render edit dialog when task is provided', (WidgetTester tester) async {
        final task = Task(
          id: 'test-id',
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
          priority: TaskPriority.high,
        );

        await tester.pumpWidget(createAddTaskDialog(task: task));

        expect(find.text('Edit Task'), findsOneWidget);
        
        // Check that form fields are populated
        final titleField = tester.widget<TextFormField>(
          find.byKey(const Key('title_field')),
        );
        expect(titleField.controller?.text, 'Test Task');
      });

      testWidgets('should render add dialog when no task is provided', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        expect(find.text('Add Task'), findsOneWidget);
        
        // Check that form fields are empty
        final titleField = tester.widget<TextFormField>(
          find.byKey(const Key('title_field')),
        );
        expect(titleField.controller?.text, '');
      });
    });

    group('Form Validation Tests', () {
      testWidgets('should show error when title is empty', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        // Try to save without entering title
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(find.text('Please enter a title'), findsOneWidget);
        expect(onSaveCalled, false);
      });

      testWidgets('should show error when category is empty', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        // Enter title but not category
        await tester.enterText(find.byKey(const Key('title_field')), 'Test Task');
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(find.text('Please enter a category'), findsOneWidget);
        expect(onSaveCalled, false);
      });

      testWidgets('should save successfully when all required fields are filled', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        // Fill required fields
        await tester.enterText(find.byKey(const Key('title_field')), 'Test Task');
        await tester.enterText(find.byKey(const Key('category_field')), 'Test Category');
        
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(onSaveCalled, true);
        expect(savedTask, isNotNull);
        expect(savedTask!.title, 'Test Task');
        expect(savedTask!.category, 'Test Category');
        expect(savedTask!.description, '');
        expect(savedTask!.priority, TaskPriority.medium);
        expect(savedTask!.dueDate, null);
      });
    });

    group('Priority Selection Tests', () {
      testWidgets('should select high priority', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        // Fill required fields
        await tester.enterText(find.byKey(const Key('title_field')), 'Test Task');
        await tester.enterText(find.byKey(const Key('category_field')), 'Test Category');
        
        // Select high priority
        await tester.tap(find.text('High'));
        await tester.pump();

        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.priority, TaskPriority.high);
      });

      testWidgets('should select medium priority', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        // Fill required fields
        await tester.enterText(find.byKey(const Key('title_field')), 'Test Task');
        await tester.enterText(find.byKey(const Key('category_field')), 'Test Category');
        
        // Select medium priority
        await tester.tap(find.text('Medium'));
        await tester.pump();

        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.priority, TaskPriority.medium);
      });

      testWidgets('should select low priority', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        // Fill required fields
        await tester.enterText(find.byKey(const Key('title_field')), 'Test Task');
        await tester.enterText(find.byKey(const Key('category_field')), 'Test Category');
        
        // Select low priority
        await tester.tap(find.text('Low'));
        await tester.pump();

        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.priority, TaskPriority.low);
      });
    });

    group('Due Date Selection Tests', () {
      testWidgets('should open date picker when due date is tapped', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        await tester.tap(find.text('Select Date'));
        await tester.pump();

        // Date picker should be shown
        expect(find.byType(CalendarDatePicker), findsOneWidget);
      });

      testWidgets('should set due date when date is selected', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        // Fill required fields
        await tester.enterText(find.byKey(const Key('title_field')), 'Test Task');
        await tester.enterText(find.byKey(const Key('category_field')), 'Test Category');
        
        // Open date picker
        await tester.tap(find.text('Select Date'));
        await tester.pump();

        // Select a date (first day of next month)
        final nextMonth = DateTime.now().add(const Duration(days: 30));
        await tester.tap(find.text(nextMonth.day.toString()));
        await tester.pump();

        // Confirm date selection
        await tester.tap(find.text('OK'));
        await tester.pump();

        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.dueDate, isNotNull);
        expect(savedTask!.dueDate!.year, nextMonth.year);
        expect(savedTask!.dueDate!.month, nextMonth.month);
        expect(savedTask!.dueDate!.day, nextMonth.day);
      });
    });

    group('Form Field Tests', () {
      testWidgets('should handle title input', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        await tester.enterText(find.byKey(const Key('title_field')), 'New Task Title');
        await tester.enterText(find.byKey(const Key('category_field')), 'Test Category');
        
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.title, 'New Task Title');
      });

      testWidgets('should handle description input', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        await tester.enterText(find.byKey(const Key('title_field')), 'Test Task');
        await tester.enterText(find.byKey(const Key('description_field')), 'Test Description');
        await tester.enterText(find.byKey(const Key('category_field')), 'Test Category');
        
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.description, 'Test Description');
      });

      testWidgets('should handle category input', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        await tester.enterText(find.byKey(const Key('title_field')), 'Test Task');
        await tester.enterText(find.byKey(const Key('category_field')), 'New Category');
        
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.category, 'New Category');
      });
    });

    group('Edit Mode Tests', () {
      testWidgets('should populate form fields when editing existing task', (WidgetTester tester) async {
        final task = Task(
          id: 'test-id',
          title: 'Original Task',
          description: 'Original Description',
          category: 'Original Category',
          priority: TaskPriority.high,
          dueDate: DateTime(2023, 12, 25),
        );

        await tester.pumpWidget(createAddTaskDialog(task: task));

        // Check that form fields are populated
        final titleField = tester.widget<TextFormField>(
          find.byKey(const Key('title_field')),
        );
        final descriptionField = tester.widget<TextFormField>(
          find.byKey(const Key('description_field')),
        );
        final categoryField = tester.widget<TextFormField>(
          find.byKey(const Key('category_field')),
        );

        expect(titleField.controller?.text, 'Original Task');
        expect(descriptionField.controller?.text, 'Original Description');
        expect(categoryField.controller?.text, 'Original Category');
      });

      testWidgets('should save updated task when editing', (WidgetTester tester) async {
        final task = Task(
          id: 'test-id',
          title: 'Original Task',
          description: 'Original Description',
          category: 'Original Category',
          priority: TaskPriority.high,
        );

        await tester.pumpWidget(createAddTaskDialog(task: task));

        // Update fields
        await tester.enterText(find.byKey(const Key('title_field')), 'Updated Task');
        await tester.enterText(find.byKey(const Key('description_field')), 'Updated Description');
        await tester.enterText(find.byKey(const Key('category_field')), 'Updated Category');
        
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.title, 'Updated Task');
        expect(savedTask!.description, 'Updated Description');
        expect(savedTask!.category, 'Updated Category');
        expect(savedTask!.priority, TaskPriority.high); // Should preserve original priority
      });
    });

    group('Cancel Functionality Tests', () {
      testWidgets('should not call onSave when cancel is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        await tester.tap(find.text('Cancel'));
        await tester.pump();

        expect(onSaveCalled, false);
        expect(savedTask, null);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very long text inputs', (WidgetTester tester) async {
        final longTitle = 'A' * 1000;
        final longDescription = 'B' * 2000;
        final longCategory = 'C' * 500;

        await tester.pumpWidget(createAddTaskDialog());

        await tester.enterText(find.byKey(const Key('title_field')), longTitle);
        await tester.enterText(find.byKey(const Key('description_field')), longDescription);
        await tester.enterText(find.byKey(const Key('category_field')), longCategory);
        
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.title, longTitle);
        expect(savedTask!.description, longDescription);
        expect(savedTask!.category, longCategory);
      });

      testWidgets('should handle special characters in text', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        await tester.enterText(find.byKey(const Key('title_field')), 'Task with special chars: !@#\$%^&*()');
        await tester.enterText(find.byKey(const Key('description_field')), 'Description with "quotes" and \'apostrophes\'');
        await tester.enterText(find.byKey(const Key('category_field')), 'Category with spaces and symbols!');
        
        await tester.tap(find.text('Save'));
        await tester.pump();

        expect(savedTask!.title, 'Task with special chars: !@#\$%^&*()');
        expect(savedTask!.description, 'Description with "quotes" and \'apostrophes\'');
        expect(savedTask!.category, 'Category with spaces and symbols!');
      });
    });

    group('Accessibility Tests', () {
      testWidgets('should have semantic labels', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        expect(find.bySemanticsLabel('Title field'), findsOneWidget);
        expect(find.bySemanticsLabel('Description field'), findsOneWidget);
        expect(find.bySemanticsLabel('Category field'), findsOneWidget);
      });

      testWidgets('should be accessible to screen readers', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        // Verify that form fields are accessible
        expect(find.byType(TextFormField), findsAtLeast(3));
        expect(find.byType(ElevatedButton), findsAtLeast(1));
      });
    });

    group('Theme Tests', () {
      testWidgets('should adapt to light theme', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return AddTaskDialog();
                },
              ),
            ),
          ),
        );

        expect(find.byType(Dialog), findsOneWidget);
        expect(find.text('Add New Task'), findsOneWidget);
      });

      testWidgets('should adapt to dark theme', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return AddTaskDialog();
                },
              ),
            ),
          ),
        );

        expect(find.byType(Dialog), findsOneWidget);
        expect(find.text('Add New Task'), findsOneWidget);
      });
    });

    group('Performance Tests', () {
      testWidgets('should render quickly', (WidgetTester tester) async {
        final stopwatch = Stopwatch()..start();
        
        await tester.pumpWidget(createAddTaskDialog());
        
        stopwatch.stop();
        expect(stopwatch.elapsed.inMilliseconds, lessThan(100));
      });

      testWidgets('should handle rapid form interactions', (WidgetTester tester) async {
        await tester.pumpWidget(createAddTaskDialog());

        // Rapidly enter text in multiple fields
        for (int i = 0; i < 10; i++) {
          await tester.enterText(find.byKey(const Key('title_field')), 'Task $i');
          await tester.enterText(find.byKey(const Key('description_field')), 'Description $i');
          await tester.enterText(find.byKey(const Key('category_field')), 'Category $i');
          await tester.pump();
        }

        // Should not crash and should handle all interactions
        expect(true, true);
      });
    });
  });
} 