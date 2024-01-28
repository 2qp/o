// Observer
import 'package:flutter/material.dart';
import 'package:o/src/core/core.dart';

class Observer<T, U> extends StatelessWidget {
  final Observable<T> observable;
  final Widget Function(BuildContext context, T value) builder;

  /// An [Observable] listener.
  ///
  /// *Args*
  /// >-  `observable`
  const Observer({required this.observable, required this.builder, super.key});

  @override
  Widget build(context) => StreamBuilder<T>(
        initialData: observable.value,
        stream: observable.stream,
        builder: (context, value) {
          return builder(context, observable.value);
        },
      );
}
