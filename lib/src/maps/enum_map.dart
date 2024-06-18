import '../macros.dart';

/// The base for classes generated with [MakeMap] macro.
abstract class EnumMap<K extends Enum, V> implements Map<K, V> {
  /// Returns the value for [key].
  ///
  /// Use this instead of `map[key]` to get a non-nullable result.
  V get(K key);
}
