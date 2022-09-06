import '../annotations/generate_unmodifiable_enum_map.dart';

/// The base for classes generated with [unmodifiableEnumMap] annotation.
abstract class UnmodifiableEnumMap<K, V> implements Map<K, V> {
  ///
  const UnmodifiableEnumMap();

  /// Returns the value for [key].
  ///
  /// Use this instead of `map[key]` to get a non-nullable result.
  V get(K key);
}
