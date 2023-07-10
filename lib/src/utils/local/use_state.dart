// Local state
import 'package:o/src/core/core.dart';

/// Record to expose `Observable` and  `void Function(T)` / `void Function(T Function(T))` to create state with provided [initialValue].
///
/// ```dart
/// final (count, setCount, _) = useState(50);
/// setCount(5);
/// ````
/// **Prev Value**
///
/// ```dart
/// final (pCount, _, setPrev) = useState(50);
/// setPrev((prev) => prev + 10);
/// ````
///
/// **Records** :
/// >- `Observable` | Ex : count
/// >- `void Function(T)`
/// >- `void Function(T Function(T)`
///
/// **Args**
/// >- T initialValue
/// >> ```dart
/// >> ```
///
(Observable<T> x, void Function(T) y, void Function(T Function(T prev)) z)
    useState<T>(T initialValue) {
  final observable = Observable<T>(initialValue);

  return (
    observable,
    (modifier) => observable.value = modifier,
    (modifier) => observable.value = modifier(observable.value)
  );
}
