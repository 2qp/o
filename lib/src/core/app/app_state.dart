// GSSM core
import 'package:flutter/material.dart';
import 'package:o/src/core/core.dart';
import 'package:o/src/typedefs/typedefs.dart';

class Store {
  static final Store _instance = Store._internal();

  factory Store() {
    return _instance;
  }

  Store._internal();

  final Map<String, dynamic> _cache = {};

  // Observables
  void addObservable<T>({required String key, required T value}) {
    _cache.putIfAbsent(key, () => Observable<T>(value));
  }

  Observable<T> observable<T>({required String key, required T initialValue}) {
    final cachedValue = _cache[key] as Observable<T>?;

    if (cachedValue != null) {
      return cachedValue;
    } else {
      final value = Observable(initialValue);
      _cache[key] = value;
      return value;
    }
  }

  // Memoization
  Observable<T> memoize<T>(String key, T Function() create) {
    final cachedValue = _cache[key] as Observable<T>?;
    if (cachedValue != null) {
      return cachedValue;
    } else {
      final value = Observable(create());
      _cache[key] = value;
      return value;
    }
  }

  // Removal
  void removeObservable<T>({required String key}) {
    _cache.remove(key);
  }
}

// Global store accessor
(Observable<T> x, void Function(dynamic Function(T)) y) useStore<T>(
  String key,
  T initialValue,
) {
  final observable =
      Store._instance.observable<T>(key: key, initialValue: initialValue);
  return (
    observable,
    (modifier) => observable.value = modifier(observable.value),
  );
}

// Global Observable injector
Widget dependencies(List<Tuple> initializers, {required Widget app}) {
  for (int i = 0; i < initializers.length; i++) {}
  return app;
}

// Global service injector
Widget injector(
    {required Widget app,
    List<Object> objects = const [],
    List<Function> functions = const []}) {
  for (int i = 0; i < objects.length; i++) {}

  for (int i = 0; i < functions.length; i++) {
    Function initializer = functions[i];
    initializer();
  }

  return app;
}

// Direct store accessor
Store getStore() => Store._instance;
