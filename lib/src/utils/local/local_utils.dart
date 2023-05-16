// Local state
import 'package:o/src/core/core.dart';

(
  Observable<T> x,
  void Function(dynamic Function(T)) y,
) useState<T>(T initialValue) {
  final observable = Observable<T>(initialValue);

  return (
    observable,
    (modifier) => observable.value = modifier(observable.value),
  );
}
