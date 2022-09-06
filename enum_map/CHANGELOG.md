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
