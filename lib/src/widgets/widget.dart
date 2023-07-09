// Observer
import 'package:flutter/widgets.dart';
import 'package:o/src/core/core.dart';

class Observer<T> extends StatelessWidget {
  final Observable<T> observable;
  final Widget Function(BuildContext context, Observable<T> obs, T value)
      builder;

  /// An [Observable] listener.
  ///
  /// *Args*
  /// >-  `observable`
  const Observer({required this.observable, required this.builder, Key? key})
      : super(key: key);

  @override
  Widget build(context) {
    return StreamBuilder<T>(
      stream: observable.stream,
      builder: (context, value) {
        return builder(context, observable, observable.value);
      },
    );
  }
}
