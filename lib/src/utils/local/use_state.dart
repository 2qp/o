part of '../../core/core.dart';

/// Record to expose `Observable` and
/// `T Function()` and
/// `FutureOr<void> Function(T)` and
/// `FutureOr<void> Function(T Function(T))` and
/// `void Function()` to create state with provided [initialValue].
///
/// ```dart
/// final count = useState(50);
/// count.setCount(5); // [ASYNC SUPPORTED]
/// ````
/// **Update Value**
///
/// ```dart
/// count.update((prev) => prev + 10); // [ASYNC SUPPORTED]
/// ````
/// **Read Value**
///
/// ```dart
/// final updated = count.get();
/// ````
///
/// **Records** :
/// >- `Observable` | o
/// >- `T Function()` | get();
/// >- `void Function(T)` | set(T);
/// >- `void Function(T Function(T)` | update(T Function(T))
/// >- `void Function()` | dispose();
///
/// **Args**
/// >- T initialValue
/// >> ```dart
/// >> ```
///
({
  Observable<T> o,
  T Function() get,
  FutureOr<void> Function(FutureOr<T>) set,
  FutureOr<void> Function(FutureOr<T> Function(T prev)) update,
  void Function() dispose
}) useState<T>(T initialValue) {
  final controller = StreamController<T>.broadcast();
  void dispose() => controller.close();

  final o = Observable<T>(initialValue, controller);

  T get() {
    try {
      return o._copyWith((o.value)).value;
    } catch (e) {
      if (kDebugMode) {
        print('CONTROLLER DISPOSED ON LOCAL STATE');
        print('Error Details: $e');
      }
      return o.value;
    }
  }

  return (
    o: o,
    get: get,

    /// Direct setter
    set: (modifier) async => o._notify(await modifier),

    /// Update with prev value
    update: (modifier) async => o._notify(await modifier(o.value)),

    /// Controller disposer
    dispose: dispose
  );
}
