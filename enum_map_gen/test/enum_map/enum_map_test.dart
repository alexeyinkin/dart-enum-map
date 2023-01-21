import 'package:test/test.dart';

import 'src/input.dart';

class Foo {
  final String value;

  const Foo(this.value);
}

class Bar extends Foo {
  const Bar(super.value);
}

void main() {
  late FruitMap<String> map;

  setUp(() {
    // ignore: prefer_const_constructors
    map = FruitMap<String>(
      apple: 'apple',
      banana: 'banana',
      orange: 'orange',
    );
  });

  group('Specific to modifiable', () {
    group('cast', () {
      test('key cannot be non-subtype', () {
        expect(
          () => map.cast<int, String>(),
          throwsA(isA<TypeError>()),
        );
      });

      test('value cannot be non-subtype', () {
        expect(
          () => map.cast<Fruit, int>(),
          throwsA(isA<TypeError>()),
        );
      });

      test('upcast', () {
        // ignore: prefer_const_constructors
        final map = FruitMap<Bar>(
          apple: Bar('apple'), // ignore: prefer_const_constructors
          banana: Bar('banana'), // ignore: prefer_const_constructors
          orange: Bar('orange'), // ignore: prefer_const_constructors
        );

        final casted = map.cast<Enum, Foo>();

        expect(casted[Fruit.apple], map.apple);
        expect(casted[Fruit.banana], map.banana);
        expect(casted[Fruit.orange], map.orange);
      });

      test('downcast OK', () {
        // ignore: prefer_const_constructors
        final map = FruitMap<Foo>(
          apple: Bar('apple'), // ignore: prefer_const_constructors
          banana: Bar('banana'), // ignore: prefer_const_constructors
          orange: Bar('orange'), // ignore: prefer_const_constructors
        );

        final casted = map.cast<Fruit, Bar>();

        expect(casted[Fruit.apple], map.apple);
        expect(casted[Fruit.banana], map.banana);
        expect(casted[Fruit.orange], map.orange);
      });

      test('downcast TypeError', () {
        // ignore: prefer_const_constructors
        final map = FruitMap<Foo>(
          apple: Bar('apple'), // ignore: prefer_const_constructors
          banana: Foo('banana'), // ignore: prefer_const_constructors
          orange: Bar('orange'), // ignore: prefer_const_constructors
        );

        expect(
          () => map.cast<Fruit, Bar>(),
          throwsA(isA<TypeError>()),
        );
      });
    });

    test('operator []=', () {
      map[Fruit.apple] = 'a';
      expect(map.apple, 'a');
    });

    test('addEntries', () {
      map.addEntries(const []);

      expect(map.length, 3);
      expect(map.apple, 'apple');
      expect(map.orange, 'orange');
      expect(map.banana, 'banana');

      map.addEntries(const [
        MapEntry(Fruit.orange, 'o'),
        MapEntry(Fruit.banana, 'b'),
      ]);

      expect(map.length, 3);
      expect(map.apple, 'apple');
      expect(map.orange, 'o');
      expect(map.banana, 'b');
    });

    test('update', () {
      map.update(
        Fruit.apple,
        (v) => v.toUpperCase(),
      );
      map.update(
        Fruit.orange,
        (v) => v.toUpperCase(),
        ifAbsent: () => throw Exception(),
      );

      expect(map.length, 3);
      expect(map.apple, 'APPLE');
      expect(map.orange, 'ORANGE');
      expect(map.banana, 'banana');
    });

    test('updateAll', () {
      map.updateAll((key, value) => '${key.name}-$value');

      expect(map.length, 3);
      expect(map.apple, 'apple-apple');
      expect(map.orange, 'orange-orange');
      expect(map.banana, 'banana-banana');
    });

    test('putIfAbsent', () {
      map.putIfAbsent(Fruit.apple, () => 'a');

      expect(map.length, 3);
      expect(map.apple, 'apple');
      expect(map.orange, 'orange');
      expect(map.banana, 'banana');
    });

    test('addAll', () {
      map.addAll({});
      map.addAll({
        Fruit.apple: 'a',
        Fruit.orange: 'o',
      });

      expect(map.length, 3);
      expect(map.apple, 'a');
      expect(map.orange, 'o');
      expect(map.banana, 'banana');
    });

    test('Fields', () {
      map.apple = 'a';

      expect(map.length, 3);
      expect(map[Fruit.apple], 'a');
      expect(map[Fruit.orange], 'orange');
      expect(map[Fruit.banana], 'banana');
    });
  });

  group('Common for modifiable and unmodifiable', () {
    test('containsValue', () {
      expect(map.containsValue('apple'), true);
      expect(map.containsValue('banana'), true);
      expect(map.containsValue('orange'), true);

      expect(map.containsValue('kiwi'), false);
      expect(map.containsValue(DateTime(2022)), false);
    });

    test('containsKey', () {
      expect(map.containsKey(Fruit.apple), true);
      expect(map.containsKey(Fruit.banana), true);
      expect(map.containsKey(Fruit.orange), true);

      expect(map.containsKey(null), false);
      expect(map.containsKey(DateTime(2022)), false);
    });

    test('operator []', () {
      expect(map[Fruit.apple], 'apple');
      expect(map[Fruit.banana], 'banana');
      expect(map[Fruit.orange], 'orange');

      expect(map[null], null);
      expect(map[DateTime(2022)], null);
    });

    test('entries', () {
      final entries = map.entries;

      expect(entries.length, 3);
      expect(entries.elementAt(0).key, Fruit.apple);
      expect(entries.elementAt(0).value, 'apple');
      expect(entries.elementAt(1).key, Fruit.orange);
      expect(entries.elementAt(1).value, 'orange');
      expect(entries.elementAt(2).key, Fruit.banana);
      expect(entries.elementAt(2).value, 'banana');
    });

    test('map', () {
      final result = map.map(
        (key, value) => MapEntry(
          Fruit.values.indexOf(key) + 1,
          value.toUpperCase(),
        ),
      );

      expect(result, {1: 'APPLE', 2: 'ORANGE', 3: 'BANANA'});
    });

    test('removeWhere', () {
      expect(
        () => map.removeWhere((key, value) => false),
        throwsUnsupportedError,
      );
    });

    test('remove', () {
      expect(
        () => map.remove(Fruit.apple),
        throwsUnsupportedError,
      );
      expect(
        () => map.remove(null),
        throwsUnsupportedError,
      );
      expect(
        () => map.remove(DateTime(2022)),
        throwsUnsupportedError,
      );
    });

    test('clear', () {
      expect(
        () => map.clear(),
        throwsUnsupportedError,
      );
    });

    test('forEach', () {
      final keys = <Fruit>[];
      final values = <String>[];

      map.forEach((key, value) {
        keys.add(key);
        values.add(value);
      });

      expect(keys, [Fruit.apple, Fruit.orange, Fruit.banana]);
      expect(values, ['apple', 'orange', 'banana']);
    });

    test('keys', () {
      final keys = map.keys;

      expect(keys, isA<List<Fruit>>());
      expect(keys, [Fruit.apple, Fruit.orange, Fruit.banana]);

      final list = keys as List<Fruit>;

      expect(
        () => list[0] = Fruit.apple,
        throwsUnsupportedError,
      );
      expect(
        () => list.add(Fruit.apple),
        throwsUnsupportedError,
      );
    });

    test('values', () {
      final values = map.values;

      expect(values, isA<List<String>>());
      expect(values, ['apple', 'orange', 'banana']);

      final list = values as List<String>;

      expect(
        () => list[0] = 'a',
        throwsUnsupportedError,
      );
      expect(
        () => list.add(''),
        throwsUnsupportedError,
      );
    });

    test('length', () {
      expect(map.length, 3);
    });

    test('isEmpty', () {
      expect(map.isEmpty, false);
    });

    test('isNotEmpty', () {
      expect(map.isNotEmpty, true);
    });

    test('get', () {
      expect(map.get(Fruit.apple), 'apple');
      expect(map.get(Fruit.banana), 'banana');
      expect(map.get(Fruit.orange), 'orange');
    });

    test('toString', () {
      expect(
        map.toString(),
        '{Fruit.apple: apple, Fruit.orange: orange, Fruit.banana: banana}',
      );
    });
  });
}
