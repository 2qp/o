// Core
import 'dart:async';

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
  /// State value
  T get value => _value;

  /// Previous value
  T? get prev => _prev;

  /// Stream emitted by `_controller` of `Observable`
  Stream<T> get stream => _controller.stream;

  T _value;
  T? _prev;

  set value(T v) {
    _prev = _value;
    _value = v;
    _controller.add(v);
  }

  void notify() {
    _controller.add(_value);
  }

  void setIfChanged(T v) {
    if (v != _value) {
      value = v;
    }
  }

  /// Closes the `stream` controller of `Observable`
  void dispose() {
    _controller.close();
  }

  Observable(this._value);

  final _controller = StreamController<T>.broadcast();
}
