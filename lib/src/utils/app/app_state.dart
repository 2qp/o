part of '../../core/core.dart';

/// Record to expose `Observable` and `Dispatch<T, U>` and `void Function()` to create state with provided [initial].
///
/// ```dart
/// final $count = createSlice<int, CounterActions>(1, counterReducer); // define counterReducer somewhere
///
/// $count.dispatch(IncrementCounter(1)); // [ASYNC SUPPORTED]
/// ````
/// **Read Value**
///
/// ```dart
/// final currentCount = await dispatch(const GetCounterAction());
/// ````
///
/// **Records** :
/// >- `Observable`     | o
/// >- `Dispatch<T, U>` | dispatch(U action);
/// >- `void Function()`| dispose();
///
/// **Args**
/// >- `T` initialValue
/// >- `Reducer<T, U?>` reducer
/// >> ```dart
/// >> ```
///
({Observable<T> o, Dispatch<T, U> dispatch, void Function() dispose})
    createStore<T, U>(
  T initial,
  Reducer<T, U> reducer,
) {
  final controller = StreamController<T>.broadcast();
  void dispose() => controller.close();

  final o = Observable<T>(initial, controller);

  FutureOr<T> dispatch(U actions) async {
    final reduced = await reducer(o.value, actions);
    o._notify(reduced);

    /// ACTION IDENTIFIER [kDebugMode]
    if (kDebugMode) print(actions?.runtimeType);
    return o._value;
  }

  return (o: o, dispatch: dispatch, dispose: dispose);
}
