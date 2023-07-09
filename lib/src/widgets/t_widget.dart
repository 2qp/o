import 'package:flutter/widgets.dart';
import 'package:o/src/core/core.dart';
import 'package:o/src/core/t_core.dart';

class TaggedObserver<T> extends StatelessWidget {
  final TaggedObservable<T> observable;

  final String tag;
  final Stream<T>? stream;

  final Widget Function(
      BuildContext context, T value, Observable<T> obs, bool invalid) builder;

  /// An advanced [Observable] listener with tag system.
  ///
  /// Suitable for many [Widget]s that depends on same [Observable]
  /// [tag] Unique identifier for each [Widget]
  ///
  /// Rebuilds can be controlled by 4 extensions.
  /// >-  `distinct()`
  /// >-  `invalidatePrevNext()`
  /// >-  `invalidateDistinctPrevNext()`
  /// >-  `invalidateNext()`
  ///
  /// *Args*
  /// >-  `tag` | unique identifier for widget
  /// >-  `stream` | handled by extensions, so it's optional
  const TaggedObserver({
    required this.observable,
    required this.builder,
    required this.tag,
    this.stream,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    return StreamBuilder<T>(
        stream: stream,
        builder: (context, value) => builder(context, observable.value,
            observable, observable.tags.contains(tag)));
  }
}
