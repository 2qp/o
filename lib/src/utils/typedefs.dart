import 'dart:async';

typedef Reducer<T, U> = FutureOr<T> Function(T currentState, U action);

typedef Dispatch<T, U> = FutureOr<T> Function(U action);
