==> Daily Task Application

I have developed this Daily Task application using Flutter and Dart. The main purpose of this application is to help users manage their daily tasks easily.

==> Features

- Users can add new tasks using a bottom sheet.
- View all tasks on the home screen.
- Mark tasks as completed or pending using a checkbox.
- Delete tasks whenever required.
- View task details by clicking on a task.
- Show success and error messages.
- Save tasks locally using SharedPreferences, so data remains available after restarting the app.

==> How the Application Works

I have used BLoC for state management. Whenever a user adds, deletes, or updates a task, an event is sent to the BLoC. BLoC handles that event, updates the task list, and saves the data in SharedPreferences.

Whenever the data changes, the UI automatically updates according to the latest state.

==> Technologies Used

1) Flutter
2) Dart
3) BLoC State Management
4) SharedPreferences
5) Material UI