// Core
import 'dart:async';

class Observable<T> {
  T _value;
  T get value => _value;
  set value(T v) {
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

  void dispose() {
    _controller.close();
  }

  Observable(this._value);

  final _controller = StreamController<T>.broadcast();
  Stream<T> get stream => _controller.stream;
}
