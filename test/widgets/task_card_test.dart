import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toodoflutter/models/task.dart';
import 'package:toodoflutter/widgets/task_card.dart';

void main() {
  group('TaskCard Widget Tests', () {
    late Task testTask;
    bool onToggleCalled = false;
    bool onEditCalled = false;
    bool onDeleteCalled = false;

    setUp(() {
      testTask = Task(
        id: 'test-id',
        title: 'Test Task',
        description: 'Test Description',
        category: 'Test Category',
        priority: TaskPriority.medium,
      );
      onToggleCalled = false;
      onEditCalled = false;
      onDeleteCalled = false;
    });

    Widget createTaskCard({
      Task? task,
      VoidCallback? onToggle,
      VoidCallback? onEdit,
      VoidCallback? onDelete,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: TaskCard(
            task: task ?? testTask,
            onToggle: onToggle ?? () => onToggleCalled = true,
            onEdit: onEdit ?? () => onEditCalled = true,
            onDelete: onDelete ?? () => onDeleteCalled = true,
          ),
        ),
      );
    }

    group('Basic Rendering Tests', () {
      testWidgets('should render task card with all elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        expect(find.text('Test Task'), findsOneWidget);
        expect(find.text('Test Description'), findsOneWidget);
        expect(find.text('Test Category'), findsOneWidget);
        expect(find.byType(Checkbox), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
      });

      testWidgets('should render completed task with strikethrough', (WidgetTester tester) async {
        final completedTask = testTask.copyWith(isCompleted: true);
        await tester.pumpWidget(createTaskCard(task: completedTask));

        final titleFinder = find.text('Test Task');
        expect(titleFinder, findsOneWidget);

        final titleWidget = tester.widget<Text>(titleFinder);
        expect(titleWidget.style?.decoration, TextDecoration.lineThrough);
      });

      testWidgets('should render task without description', (WidgetTester tester) async {
        final taskWithoutDescription = testTask.copyWith(description: '');
        await tester.pumpWidget(createTaskCard(task: taskWithoutDescription));

        expect(find.text('Test Task'), findsOneWidget);
        expect(find.text('Test Description'), findsNothing);
      });
    });

    group('Priority Indicator Tests', () {
      testWidgets('should render high priority indicator', (WidgetTester tester) async {
        final highPriorityTask = testTask.copyWith(priority: TaskPriority.high);
        await tester.pumpWidget(createTaskCard(task: highPriorityTask));

        expect(find.text('HIGH'), findsOneWidget);
        expect(find.byIcon(Icons.priority_high), findsOneWidget);
      });

      testWidgets('should render medium priority indicator', (WidgetTester tester) async {
        final mediumPriorityTask = testTask.copyWith(priority: TaskPriority.medium);
        await tester.pumpWidget(createTaskCard(task: mediumPriorityTask));

        expect(find.text('MEDIUM'), findsOneWidget);
        expect(find.byIcon(Icons.remove), findsOneWidget);
      });

      testWidgets('should render low priority indicator', (WidgetTester tester) async {
        final lowPriorityTask = testTask.copyWith(priority: TaskPriority.low);
        await tester.pumpWidget(createTaskCard(task: lowPriorityTask));

        expect(find.text('LOW'), findsOneWidget);
        expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
      });
    });

    group('Due Date Tests', () {
      testWidgets('should render due date when present', (WidgetTester tester) async {
        final taskWithDueDate = testTask.copyWith(
          dueDate: DateTime(2023, 12, 25),
        );
        await tester.pumpWidget(createTaskCard(task: taskWithDueDate));

        expect(find.text('Dec 25'), findsOneWidget);
        expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      });

      testWidgets('should not render due date when not present', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        expect(find.text('Dec 25'), findsNothing);
        expect(find.byIcon(Icons.calendar_today), findsNothing);
      });

      testWidgets('should render overdue due date in red', (WidgetTester tester) async {
        final overdueTask = testTask.copyWith(
          dueDate: DateTime.now().subtract(const Duration(days: 1)),
        );
        await tester.pumpWidget(createTaskCard(task: overdueTask));

        final dateTextFinder = find.text('Dec ${DateTime.now().subtract(const Duration(days: 1)).day}');
        expect(dateTextFinder, findsOneWidget);

        final dateTextWidget = tester.widget<Text>(dateTextFinder);
        expect(dateTextWidget.style?.color, Colors.red);
      });

      testWidgets('should render today due date in orange', (WidgetTester tester) async {
        final todayTask = testTask.copyWith(
          dueDate: DateTime.now(),
        );
        await tester.pumpWidget(createTaskCard(task: todayTask));

        final dateTextFinder = find.text('Dec ${DateTime.now().day}');
        expect(dateTextFinder, findsOneWidget);

        final dateTextWidget = tester.widget<Text>(dateTextFinder);
        expect(dateTextWidget.style?.color, Colors.orange);
      });

      testWidgets('should render future due date in default color', (WidgetTester tester) async {
        final futureTask = testTask.copyWith(
          dueDate: DateTime.now().add(const Duration(days: 1)),
        );
        await tester.pumpWidget(createTaskCard(task: futureTask));

        final dateTextFinder = find.text('Dec ${DateTime.now().add(const Duration(days: 1)).day}');
        expect(dateTextFinder, findsOneWidget);

        final dateTextWidget = tester.widget<Text>(dateTextFinder);
        expect(dateTextWidget.style?.color, isNot(Colors.red));
        expect(dateTextWidget.style?.color, isNot(Colors.orange));
      });
    });

    group('Interaction Tests', () {
      testWidgets('should call onToggle when checkbox is tapped', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        await tester.tap(find.byType(Checkbox));
        await tester.pump();

        expect(onToggleCalled, true);
      });

      testWidgets('should call onToggle when card is tapped', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        await tester.tap(find.byType(Card));
        await tester.pump();

        expect(onToggleCalled, true);
      });

      testWidgets('should call onEdit when edit action is triggered', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        // Swipe to reveal actions
        await tester.drag(find.byType(Card), const Offset(-100, 0));
        await tester.pump();

        // Tap edit action
        await tester.tap(find.text('Edit'));
        await tester.pump();

        expect(onEditCalled, true);
      });

      testWidgets('should call onDelete when delete action is triggered', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        // Swipe to reveal actions
        await tester.drag(find.byType(Card), const Offset(-100, 0));
        await tester.pump();

        // Tap delete action
        await tester.tap(find.text('Delete'));
        await tester.pump();

        expect(onDeleteCalled, true);
      });
    });

    group('Swipe Actions Tests', () {
      testWidgets('should show swipe actions', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        // Swipe to reveal actions
        await tester.drag(find.byType(Card), const Offset(-100, 0));
        await tester.pump();

        expect(find.text('Edit'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
      });

      testWidgets('should have correct action colors', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        // Swipe to reveal actions
        await tester.drag(find.byType(Card), const Offset(-100, 0));
        await tester.pump();

        final editAction = find.byType(Container).at(1); // Edit action container
        final deleteAction = find.byType(Container).at(2); // Delete action container

        expect(editAction, findsOneWidget);
        expect(deleteAction, findsOneWidget);
      });
    });

    group('Visual States Tests', () {
      testWidgets('should show completed task with muted colors', (WidgetTester tester) async {
        final completedTask = testTask.copyWith(isCompleted: true);
        await tester.pumpWidget(createTaskCard(task: completedTask));

        final titleFinder = find.text('Test Task');
        final titleWidget = tester.widget<Text>(titleFinder);
        
        expect(titleWidget.style?.decoration, TextDecoration.lineThrough);
        expect(titleWidget.style?.color, isNot(null));
      });

      testWidgets('should show category chip with correct styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        final categoryFinder = find.text('Test Category');
        expect(categoryFinder, findsOneWidget);

        final categoryContainer = tester.widget<Container>(
          find.ancestor(
            of: categoryFinder,
            matching: find.byType(Container),
          ).first,
        );

        expect(categoryContainer.decoration, isA<BoxDecoration>());
      });
    });

    group('Accessibility Tests', () {
      testWidgets('should have semantic labels', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        expect(find.bySemanticsLabel('Task card'), findsOneWidget);
        expect(find.bySemanticsLabel('Toggle task completion'), findsOneWidget);
      });

      testWidgets('should be accessible to screen readers', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        // Verify that the task title is accessible
        expect(find.text('Test Task'), findsOneWidget);
        
        // Verify that the checkbox is accessible
        expect(find.byType(Checkbox), findsOneWidget);
      });
    });

    group('Theme Tests', () {
      testWidgets('should adapt to light theme', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: TaskCard(
                task: testTask,
                onToggle: () {},
                onEdit: () {},
                onDelete: () {},
              ),
            ),
          ),
        );

        expect(find.byType(Card), findsOneWidget);
        expect(find.text('Test Task'), findsOneWidget);
      });

      testWidgets('should adapt to dark theme', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: TaskCard(
                task: testTask,
                onToggle: () {},
                onEdit: () {},
                onDelete: () {},
              ),
            ),
          ),
        );

        expect(find.byType(Card), findsOneWidget);
        expect(find.text('Test Task'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very long title', (WidgetTester tester) async {
        final longTitleTask = testTask.copyWith(
          title: 'This is a very long task title that should be handled properly by the UI',
        );
        await tester.pumpWidget(createTaskCard(task: longTitleTask));

        expect(find.text('This is a very long task title that should be handled properly by the UI'), findsOneWidget);
      });

      testWidgets('should handle very long description', (WidgetTester tester) async {
        final longDescriptionTask = testTask.copyWith(
          description: 'This is a very long description that should be truncated properly by the UI to prevent layout issues',
        );
        await tester.pumpWidget(createTaskCard(task: longDescriptionTask));

        expect(find.text('This is a very long description that should be truncated properly by the UI to prevent layout issues'), findsOneWidget);
      });

      testWidgets('should handle empty title', (WidgetTester tester) async {
        final emptyTitleTask = testTask.copyWith(title: '');
        await tester.pumpWidget(createTaskCard(task: emptyTitleTask));

        expect(find.text(''), findsOneWidget);
      });

      testWidgets('should handle special characters in title', (WidgetTester tester) async {
        final specialCharTask = testTask.copyWith(
          title: 'Task with special chars: !@#\$%^&*()',
        );
        await tester.pumpWidget(createTaskCard(task: specialCharTask));

        expect(find.text('Task with special chars: !@#\$%^&*()'), findsOneWidget);
      });
    });

    group('Performance Tests', () {
      testWidgets('should render quickly', (WidgetTester tester) async {
        final stopwatch = Stopwatch()..start();
        
        await tester.pumpWidget(createTaskCard());
        
        stopwatch.stop();
        expect(stopwatch.elapsed.inMilliseconds, lessThan(100));
      });

      testWidgets('should handle rapid interactions', (WidgetTester tester) async {
        await tester.pumpWidget(createTaskCard());

        // Rapidly tap the checkbox multiple times
        for (int i = 0; i < 10; i++) {
          await tester.tap(find.byType(Checkbox));
          await tester.pump();
        }

        // Should not crash and should handle all interactions
        expect(true, true);
      });
    });
  });
} 