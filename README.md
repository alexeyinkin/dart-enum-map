[![Pub Package](https://img.shields.io/pub/v/enum_map.svg)](https://pub.dev/packages/enum_map)
[![GitHub](https://img.shields.io/github/license/alexeyinkin/dart-enum-map)](https://github.com/alexeyinkin/dart-enum-map/blob/main/LICENSE)
[![CodeFactor](https://img.shields.io/codefactor/grade/github/alexeyinkin/dart-enum-map?style=flat-square)](https://www.codefactor.io/repository/github/alexeyinkin/dart-enum-map)
[![Support Chat](https://img.shields.io/badge/support%20chat-telegram-brightgreen)](https://ainkin.com/chat)

A Map with the compile-time check that every `enum` constant has an entry in it.

## Overview

For an `enum` like this
```dart
enum Fruit { apple, orange, banana }
```

... you can generate the following class:

```dart
class FruitMap<V> extends EnumMap<Fruit, V> { // implements Map<Fruit, V>
  FruitMap({
    required this.apple,
    required this.orange,
    required this.banana,
  });
  // ...
}
```

Which means that the app will only build if you set all the values in the constructor.
And then you can treat this object like an ordinary map.

## Usage

```dart
@MakeMap()
@MakeUnmodifiableMap()
enum Fruit { apple, orange, banana }

void main() {
  final modifiableMap = FruitMap<String>(apple: 'a', orange: 'o', banana: 'b');
  print(modifiableMap);  // prints: {Fruit.apple: a, Fruit.orange: o, Fruit.banana: b}
  print(modifiableMap[Fruit.apple]);      // prints: a
  print(modifiableMap.get(Fruit.apple));  // prints: a

  const unmodifiableMap = UnmodifiableFruitMap<String>(apple: 'a', orange: 'o', banana: 'b');
  print(unmodifiableMap);  // prints: {Fruit.apple: a, Fruit.orange: o, Fruit.banana: b}
  print(unmodifiableMap[Fruit.apple]);      // prints: a
  print(unmodifiableMap.get(Fruit.apple));  // prints: a
}
```

The generated classes contain:

- [All 21 of the public members](https://api.dart.dev/stable/3.4.4/dart-core/Map-class.html) of the `Map` interface.
- `V get(Fruit key)` -- the non-nullable getter that guarantees the result of type `V`.
- `toString()` that works like with the default maps.

## Migrating from the Pre-Macro Version

1. Change the annotations:
   - Replace `@enumMap` with `@MakeMap()`.
   - Replace `@unmodifiableEnumMap` with `@MakeUnmodifiableMap()`.
2. Delete all `*.g.dart` files.
3. Delete `enum_map_gen` package from your `pubspec.yaml`. Run `dart pub get`.
4. Check if you still need `build_runner` package for other packages. If you don't, delete it and run `dart pub get`.
5. Otherwise, regenerate all `*.g.dart` files that exist for reasons other than this package.

## Support Chat

Do you have any questions? Feel free to ask in the [Telegram Support Chat](https://ainkin.com/chat).

Or even just join to say 'Hi!'. I like to hear from the users.
