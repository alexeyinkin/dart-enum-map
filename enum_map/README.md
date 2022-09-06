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

Add these packages to your pubspec.yaml:

```yaml
dependencies:
  enum_map: ^0.1.0

dev_dependencies:
  build_runner:
  enum_map_gen: ^0.1.0
```

Run `dart pub get`

Given that your enum is in `fruit.dart`, add:

1. `part 'fruit.g.dart;` directive.
2. `@enumMap` or `@unmodifiableEnumMap` annotation, or both.

```dart
import 'package:enum_map/enum_map.dat';

part 'fruit.g.dart';   // Add '.g' to the current file name before '.dart' extension.

@enumMap
@unmodifiableEnumMap
enum Fruit { apple, orange, banana }
```

Then run this in your project root:

```bash
$ dart run build_runner build
```

This creates a file next to your enum file. If it was `lib/fruit.dart`, then the generated
file is `lib/fruit.g.dart`.

This is how you use it:

```dart
import 'fruit.dart';

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

- [All 21 of the public members](https://api.dart.dev/stable/2.17.6/dart-core/Map-class.html) of the `Map` interface.
- `V get(Fruit key)` -- the non-nullable getter that guarantees the result of type `V`.
- `toString()` that works like with the default maps.

## Do Not Put Generated Files Under Version Control

You should never put generated files under version control.
Instead you should generate them after each checkout.
To do this, add the above command to your build pipeline before `dart compile` or `flutter build`.

If you store generated files under version control, there is a risk that these files get outdated.
Then your program will only work until the next re-generation, and then fixing it will be hard.
To ensure you do not store generated files under version control, add the following line to
your `.gitignore` file:

```
*.g.dart
```

There is however a safety in `get()` method. It uses `switch (key)` to return the result.
If you add a value to your enum, the generated file will break the build because there will be
an uncovered case that does not return a result.
This will remind you to rebuild your generated files.
