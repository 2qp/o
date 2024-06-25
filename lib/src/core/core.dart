import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:o/src/utils/typedefs.dart';

part '../utils/local/use_state.dart';
part '../utils/app/app_state.dart';

/// Object that holds the state data.
///
/// takes `T` [value] to create an instance.
///
/// **Getters**
/// >-  `value`
/// >-  `prev`
/// >-  `stream`
///
/// **Setters**
/// >-  `value`

class Observable<T> {
  T _value;

  /// State value
  T get value => _value;

  final StreamController<T> _controller;

  Stream<T> get stream => _controller.stream;

  /// State notifier
  @protected
  void _notify(T v) {
    _value = v;
    _controller.add(v);
  }

  Observable(this._value, this._controller);
}
