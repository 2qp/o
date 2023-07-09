import 'package:o/src/widgets/t_widget.dart';

/// `TObserverDistinctExtension` extension provides `distinct()` method for `TObserver`
/// with distinct data events of [observable], filtered by custom equality.
extension TObserverDistinctExtension<T> on TaggedObserver<T> {
  /// Provides distinct data events of [observable], filtered by custom equality.
  TaggedObserver<T> distinct() {
    return TaggedObserver<T>(
      observable: observable,
      stream: observable.stream.distinct((previous, next) => previous == next),
      builder: builder,
      tag: tag,
    );
  }
}

/// `TObserverInvalidateTagsExtension` extends `TObserver`, discarding data events based on [tag].
/// Adds `invalidatePrevNext()` method to return a new filtered `TObserver`.
/// Params: `observable`, `stream`, `builder`, `tag`.
/// Returns: New `TObserver` instance with filtered data based on [tag]. [invalidatePrevNext]
extension TObserverInvalidateTagsExtension<T> on TaggedObserver<T> {
  // Method of `TObserverInvalidateTagsExtension`
  /// Return a new `TObserver` with filters applied to `stream`
  /// which discards events that `tag` isn't present on
  /// previous or current tag states of `observable`.
  TaggedObserver<T> invalidatePrevNext() {
    return TaggedObserver<T>(
      observable: observable,
      stream: observable.stream.where((event) => observable.containsTag(tag)),
      builder: builder,
      tag: tag,
    );
  }
}

/// `TObserverInvalidateDPNExtension` extends `TObserver`. Returns filtered `TObserver`
/// with distinct data events. Filters events based on [tag], `observable.tags`, and `observable.prevTags`.
extension TObserverDistinctTagsExtension<T> on TaggedObserver<T> {
  /// Return a new `TObserver` with filters applied to `stream`
  /// with distinct data events and
  /// discards events that `tag` isn't present on previous
  /// or current tag states of `observable`.
  TaggedObserver<T> invalidateDistinctPrevNext() {
    return TaggedObserver<T>(
      observable: observable,
      stream: observable.stream
          .distinct((previous, next) => previous == next)
          .where((event) {
        return (observable.tags.contains(tag) ||
            observable.prevTags.contains(tag));
      }),
      builder: builder,
      tag: tag,
    );
  }
}

/// `TObserverInvalidateNExtension` extends `TObserver`. Returns filtered `TObserver`
/// excluding data events not matching [tag] in `observable.tags`.
extension TObserverFilterTagsExtension<T> on TaggedObserver<T> {
  /// Return a new `TObserver` with filters applied to `stream`
  /// which discards events that `tag` isn't present on
  /// current tag state of `observable`.
  TaggedObserver<T> invalidateNext() {
    return TaggedObserver<T>(
      observable: observable,
      stream: observable.stream.where((event) => observable.tags.contains(tag)),
      builder: builder,
      tag: tag,
    );
  }
}
