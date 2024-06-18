import '../macros.dart';

/// The base for classes generated with [MakeUnmodifiableMap] macro.
abstract class UnmodifiableEnumMap<K extends Enum, V> implements Map<K, V> {
  ///
  const UnmodifiableEnumMap();

  /// Returns the value for [key].
  ///
  /// Use this instead of `map[key]` to get a non-nullable result.
  V get(K key);
}
