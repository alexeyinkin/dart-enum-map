## 0.4.0-2.dev

* Relaxed the minimal [meta](https://pub.dev/packages/meta) version to `1.14.0`.
* Added pub.dev topics: collections, macros, enum.

## 0.4.0-1.dev

* **BREAKING:** Rewritten as macros: `@MakeMap()`, `@MakeUnmodifiableMap()`.
* The base classes `EnumMap<K, V>` and `UnmodifiableEnumMap<K, V>` changed to `<K extends Enum, V>`.
* Dropped the dependency on `enum_map_gen`.
* Upgraded [total_lints](https://pub.dev/packages/total_lints) to v3.4.0.

## 0.3.0

* Upgraded [total_lints](https://pub.dev/packages/total_lints) to v3.0.0.

## 0.2.1

* Added 'Support Chat' section to README.

## 0.2.0

* **BREAKING:** Rename annotation classes from `EnumMap` to `GenerateEnumMap`, `UnmodifiableEnumMap`
  to `GenerateUnmodifiableEnumMap`. Constants `enumMap` and `unmodifiableEnumMap` are intact.
* **BREAKING:** Added superclasses for the generated maps: `EnumMap`, `UnmodifiableEnumMap`.
  These require `import 'package:enum_map/enum_map.dart`
  instead of the older `.../annotations.dart`.

## 0.1.0

* Initial release.
