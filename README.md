# Todo Flutter App

A comprehensive Flutter todo application with modern UI, authentication, and offline support.

## Features

### 🔐 Authentication
- **OTP Login**: Secure login via phone number and OTP verification
- **Secure Logout**: Proper session management and data cleanup
- **Offline Support**: Works without internet connection

### 📝 Task Management
- **CRUD Operations**: Create, read, update, and delete tasks
- **Task Properties**: Title, description, completion status
- **Priority Levels**: High, Medium, Low with visual indicators
- **Due Dates**: Calendar integration with date picker
- **Categories**: Organize tasks into customizable categories

### 🔍 Search & Filter
- **Search**: Find tasks by title or description
- **Category Filter**: Filter tasks by category
- **Priority Filter**: Filter tasks by priority level
- **Smart Sorting**: Tasks sorted by priority, due date, and completion status

### 🎨 User Experience
- **Dark/Light Theme**: Automatic theme switching with Material Design 3
- **Swipe Actions**: Swipe to complete or delete tasks
- **Pull-to-Refresh**: Refresh task list with swipe gesture
- **Modern UI**: Clean and intuitive interface

### 📊 Feedback System
- **App Rating**: 5-star rating system
- **User Feedback**: Text feedback submission
- **Mock API**: Simulated server responses for development

### 💾 Data Management
- **Local Storage**: SQLite database for offline task storage
- **Repository Pattern**: Clean separation of data access
- **MVVM Architecture**: Model-View-ViewModel pattern
- **Mock API Integration**: Simulated network requests

## Architecture

### MVVM Pattern
- **Models**: Task data structure with all properties
- **ViewModels**: Business logic and state management
- **Views**: UI components and screens

### Repository Pattern
- **TaskRepository**: Centralized data access
- **DatabaseHelper**: SQLite operations
- **MockApiService**: Simulated API calls

### State Management
- **Provider**: Dependency injection and state management
- **ChangeNotifier**: Reactive UI updates

## Project Structure

```
lib/
├── models/
│   └── task.dart              # Task data model
├── data/
│   └── database_helper.dart    # SQLite database operations
├── services/
│   ├── auth_service.dart       # Authentication logic
│   ├── theme_service.dart      # Theme management
│   └── mock_api_service.dart   # Mock API responses
├── repositories/
│   └── task_repository.dart    # Data access layer
├── viewmodels/
│   ├── auth_viewmodel.dart     # Authentication state
│   └── task_viewmodel.dart     # Task management state
├── screens/
│   ├── login_screen.dart       # OTP login screen
│   ├── home_screen.dart        # Main task list screen
│   └── feedback_screen.dart    # Feedback and rating screen
├── widgets/
│   ├── task_card.dart          # Individual task display
│   └── add_task_dialog.dart    # Add/edit task form
└── main.dart                   # App entry point
```

## Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd toodoflutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Dependencies

The app uses the following key dependencies:

- **provider**: State management
- **sqflite**: Local database storage
- **http & dio**: HTTP client for API calls
- **flutter_slidable**: Swipe actions
- **pull_to_refresh**: Pull-to-refresh functionality
- **intl**: Date formatting
- **shared_preferences**: Local preferences storage
- **uuid**: Unique ID generation

## Usage

### Authentication
1. Enter your phone number
2. Click "Send OTP" to generate a verification code
3. Enter the OTP (shown in console for testing)
4. Click "Verify OTP" to login

### Task Management
1. **Add Task**: Tap the floating action button (+)
2. **Edit Task**: Swipe left on a task and tap "Edit"
3. **Complete Task**: Tap the checkbox or swipe to complete
4. **Delete Task**: Swipe left and tap "Delete"

### Search & Filter
1. **Search**: Use the search bar to find tasks
2. **Filter by Category**: Tap category chips
3. **Filter by Priority**: Tap priority chips
4. **Clear Filters**: Use the clear button in search bar

### Theme
- Toggle between light and dark themes using the switch on the login screen
- Theme preference is saved automatically

### Feedback
- Tap the feedback icon in the app bar
- Rate the app with stars
- Provide text feedback (optional)
- Submit your feedback

## Features in Detail

### Task Properties
- **Title**: Required task name
- **Description**: Optional detailed description
- **Category**: Customizable task category
- **Priority**: High, Medium, Low with color coding
- **Due Date**: Optional deadline with calendar picker
- **Completion Status**: Checkbox to mark as complete

### Visual Indicators
- **Priority Colors**: Red (High), Orange (Medium), Green (Low)
- **Due Date Colors**: Red (Overdue), Orange (Today), Gray (Future)
- **Completion**: Strikethrough text for completed tasks

### Offline Support
- All data is stored locally in SQLite
- Works without internet connection
- Syncs with mock API when available
- Graceful error handling for network failures

### Mock API
- Simulates real API responses
- Includes network delays and occasional failures
- Used for testing offline/online scenarios
- Provides realistic development experience

## Development

### Adding New Features
1. Create models in `lib/models/`
2. Add services in `lib/services/`
3. Create viewmodels in `lib/viewmodels/`
4. Build UI components in `lib/widgets/`
5. Add screens in `lib/screens/`

### Testing
- The app includes mock data for testing
- OTP is displayed in console for easy testing
- Mock API simulates network conditions

### Database Schema
```sql
CREATE TABLE tasks(
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  isCompleted INTEGER NOT NULL,
  priority INTEGER NOT NULL,
  dueDate INTEGER,
  category TEXT NOT NULL,
  createdAt INTEGER NOT NULL,
  updatedAt INTEGER NOT NULL
);
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support and questions, please open an issue in the repository.
