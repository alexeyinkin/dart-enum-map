import 'abstract_enum_map.dart';

/// Use this annotation on enums to create an unmodifiable map based on them.
/// Such map has a const constructor.
class UnmodifiableEnumMap extends AbstractEnumMap {
  ///
  const UnmodifiableEnumMap();
}

/// Use this annotation on enums to create a modifiable map based on them.
/// Such map has a const constructor.
const unmodifiableEnumMap = UnmodifiableEnumMap();
