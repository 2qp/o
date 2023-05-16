// Type
import 'package:o/src/core/core.dart';

typedef Tuple<T> = (
  Observable<T> x,
  void Function(dynamic Function(T)) y,
);
