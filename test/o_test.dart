import 'package:flutter_test/flutter_test.dart';

import 'package:o/o.dart';

void main() {
  test('useState test', () {
    final (count, setCount, _) = useState(5);
    setCount(5);
    expect(count.value, 5);
  });

  test('useStore test', () {
    final (gCount, _, setGCount) = useStore('count', 2);
    setGCount((p0) => p0 + 1);
    expect(gCount.value, 3);

    getStore().removeObservable(key: 'count');
    final (newCount, _, _) = useStore('count', 5);
    expect(newCount.value, 5);

    final (sameCount, _, _) = useStore('count', 500);
    expect(sameCount.value, 5);
  });
}
