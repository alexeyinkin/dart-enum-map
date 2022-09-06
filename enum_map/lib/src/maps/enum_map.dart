import '../annotations/generate_enum_map.dart';

/// The base for classes generated with [enumMap] annotation.
abstract class EnumMap<K, V> implements Map<K, V> {
  /// Returns the value for [key].
  ///
  /// Use this instead of `map[key]` to get a non-nullable result.
  V get(K key);
}
