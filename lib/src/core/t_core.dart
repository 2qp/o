import 'package:o/src/core/core.dart';

/// Extended version of `Observable`
/// Object that holds the state data.
///
/// takes `T` [value] to create an instance.
///
/// **Getters**
/// >-  `value`
/// >-  `prev`
/// >-  `tags`
/// >-  `prevTags`
/// >-  `stream`
///
/// **Setters**
/// >-  `value`
/// >-  `tags`
class TaggedObservable<T> extends Observable<T> {
  TaggedObservable(super.value);

  /// Previous tags
  Set<String> get prevTags => _prevTags;

  /// Tags after setting state
  Set<String> get tags => _tags;

  Set<String> _tags = {};
  Set<String> _prevTags = {};

  /// INVALIDATION
  set tags(Set<String>? t) {
    _prevTags = _tags.toSet();
    _tags = t?.toSet() ?? {};
  }

  /// Returns a `bool` by checking if `tag` contains in da combined Set of `tags` & `prevTags`
  bool containsTag(String tag) {
    final Set<String> allTags = {..._tags, ..._prevTags};
    return allTags.contains(tag);
  }
}
