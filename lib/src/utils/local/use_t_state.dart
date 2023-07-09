import 'package:o/src/core/t_core.dart';

/// Record to expose `TaggedObservable` and  `void Function(T)` / `void Function(T Function(T))` to create state with provided [initialValue].
/// Optional : accepts `tags` as args which will be used to filter out rebuilds via `stream`.
///
/// **Records** :
/// >- `TaggedObservable` | Ex : count
/// >- `void Function(T)`
/// >- `void Function(T Function(T)`
///
/// >> ```dart
/// final (count, _, setCount) = useState(50);
/// Ex : setCount((prev) => 1);
/// >> ```
///
/// or
///
/// >> ```dart
/// final (count, setCount, _) = useState(50);
/// Ex : setCount(1);
/// >> ```
///
/// **Args**
/// >- T initialValue
/// >- tags : List<String>
/// >> ```dart
/// Ex : setCount((prev)=> 1, tags : ['widget1']);
/// >> ```
///
(
  TaggedObservable<T> x,
  void Function(T, {List<String>? tags}),
  void Function(T Function(T prev), {List<String>? tags}) y
) useTag<T>(T initialValue) {
  final observable = TaggedObservable<T>(initialValue);

  return (
    observable,
    (modifier, {tags}) {
      observable.value = modifier;
      observable.tags = tags?.toSet() ?? {};
    },
    (modifier, {tags}) {
      observable.value = modifier(observable.value);
      observable.tags = tags?.toSet() ?? {};
    }
  );
}
