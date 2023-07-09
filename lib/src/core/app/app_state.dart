import 'dart:collection';

import 'package:o/src/core/core.dart';

///
/// `Store` singleton which holds the AppState.
///
/// States are stored within <String, Observable<dynamic>> `_cache`.
///
/// exposes 4 **methods**
/// >-  `addObservable()`
/// >-  `observable()`
/// >-  `memoize()`
/// >-  `removeObservable()`
///
/// use `useStore()` to get / set states.
///
/// direct access via `getStore()` global function
class Store {
  static final Store _instance = Store._internal();

  factory Store() {
    return _instance;
  }

  Store._internal();

  final _cache = HashMap<String, Observable<dynamic>>();

  /// add Observables
  void addObservable<T>({required String key, required T value}) {
    _cache.putIfAbsent(key, () => Observable<T>(value));
  }

  Observable<T> observable<T>({required String key, required T initialValue}) {
    var cachedValue =
        _cache.containsKey(key) ? _cache[key] as Observable<T> : null;
    return cachedValue ??= _cache[key] = Observable<T>(initialValue);
  }

  /// Memoization
  Observable<T> memoize<T>(String key, T Function() create) {
    var cachedValue =
        _cache.containsKey(key) ? _cache[key] as Observable<T> : null;

    return cachedValue ??= _cache[key] = Observable<T>(create());
  }

  /// Removal
  void removeObservable<T>({required String key}) {
    _cache.remove(key);
  }
}

/// Creates an observable store for the provided key and initial value.
///
/// Record to expose `Observable` and `void Function(T)` / `void Function(T Function(T))` to create an Appstate with provided
/// [initialValue] & [key].
///
/// ```dart
/// final (down, setDown, _) = useStore('counter', 500);
/// setDown(1);
/// ```
///
/// **or**
///
/// ```dart
/// final (down, _, setDown) = useStore('counter', 500);
/// setDown((prev) => prev - 1);
/// ```
/// State will be created only if a state doesn't exist with the provided key.
///
/// **Records** :
/// >- `Observable` | Ex : count
/// >- `void Function(T)`
/// >- `void Function(T Function(T)`
///
/// **Args**
/// >> ```dart
/// String key  // Unique State Identifier
/// T initialValue
/// > ```
(Observable<T> x, void Function(T) y, void Function(T Function(T prev)) z)
    useStore<T>(
  String key,
  T initialValue,
) {
  final observable =
      Store._instance.observable<T>(key: key, initialValue: initialValue);
  return (
    observable,
    (modifier) => observable.value = modifier,
    (modifier) => observable.value = modifier(observable.value)
  );
}

/// Direct store accessor
Store getStore() => Store._instance;
