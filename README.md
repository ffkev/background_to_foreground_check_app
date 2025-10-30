# Background Resume Listener

A simple and reusable FlutterFlow-compatible custom action that detects when your app resumes from the background and executes defined logic.  
Built with `WidgetsBindingObserver`, it provides a debounced, stable lifecycle callback to refresh sessions, reload data, or trigger background syncs automatically.

## Features
- Detects app resume events reliably.
- Debounces quick consecutive triggers.
- Works seamlessly within FlutterFlow custom actions.
- Supports easy integration for background handling logic.

## Usage
1. Call `checkBackgroundResume()` after `WidgetsFlutterBinding.ensureInitialized()` in your main app initialization.
2. Add your desired logic inside the `onResume` callback.
3. Optionally, call `dispose()` if you want to stop listening to lifecycle changes.

## Example
```dart
await checkBackgroundResume();
