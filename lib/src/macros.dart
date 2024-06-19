import 'dart:async';

import 'package:macro_util/macro_util.dart';
import 'package:macros/macros.dart';

import 'enum_introspection_data.dart';
import 'introspection_data.dart';
import 'libraries.dart';
import 'resolved_identifiers.dart';

@Deprecated('Use MakeMap()')
// ignore: public_member_api_docs
typedef GenerateEnumMap = MakeMap;

@Deprecated('Use MakeUnmodifiableMap()')
// ignore: public_member_api_docs
typedef GenerateUnmodifiableEnumMap = MakeUnmodifiableMap;

abstract class _MakeMapBase implements ClassTypesMacro, ClassDeclarationsMacro {
  const _MakeMapBase();

  // Differing to modifiable and unmodifiable:

  Future<Identifier> _getMapBaseClassTypePhase(ClassTypeBuilder builder);

  Identifier _getMapBaseClassDeclarationPhase(IntrospectionData intr);

  List<Object> _getFields(IntrospectionData intr);

  List<Object> _getConstructor(IntrospectionData intr);

  // Map interface, differing to modifiable and unmodifiable:

  List<Object> _getAddAll(IntrospectionData intr);

  List<Object> _getAddEntries(IntrospectionData intr);

  List<Object> _getPutIfAbsent(IntrospectionData intr);

  List<Object> _getUpdate(IntrospectionData intr);

  List<Object> _getUpdateAll(IntrospectionData intr);

  List<Object> _getOperatorSet(IntrospectionData intr);

  @override
  Future<void> buildTypesForClass(
    ClassDeclaration clazz,
    ClassTypeBuilder builder,
  ) async {
    final name = _getMapClassName(clazz);
    final base = await _getMapBaseClassTypePhase(builder);

    builder.declareType(
      name,
      DeclarationCode.fromParts([
        //
        'class $name<V> implements ', base, '<', clazz.identifier.name,
        ', V> {}',
      ]),
    );
  }

  @override
  Future<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final intr = await _introspect(clazz, builder);
    final base = _getMapBaseClassDeclarationPhase(intr);

    builder.declareInLibrary(
      DeclarationCode.fromParts(
        [
          //
          'augment class ', intr.mapClassName, '<V> ',
          'implements ', base, '<', intr.enumName, ', V>{\n',

          ..._getFields(intr).indent(),
          ..._getConstructor(intr).indent(),

          ..._getGet(intr).indent(),
          ..._getToString(intr).indent(),

          // Map interface, common for modifiable and unmodifiable:
          ..._getGetEntries(intr).indent(),
          ..._getGetIsEmpty(intr).indent(),
          ..._getGetIsNotEmpty(intr).indent(),
          ..._getGetKeys(intr).indent(),
          ..._getGetLength(intr).indent(),
          ..._getGetValues(intr).indent(),

          ..._getCast(intr).indent(),
          ..._getClear(intr).indent(),
          ..._getContainsKey(intr).indent(),
          ..._getContainsValue(intr).indent(),
          ..._getForEach(intr).indent(),
          ..._getMap(intr).indent(),
          ..._getRemove(intr).indent(),
          ..._getRemoveWhere(intr).indent(),

          ..._getOperatorGet(intr).indent(),

          // Map interface, differing for modifiable and unmodifiable:
          ..._getAddAll(intr).indent(),
          ..._getAddEntries(intr).indent(),
          ..._getPutIfAbsent(intr).indent(),
          ..._getUpdate(intr).indent(),
          ..._getUpdateAll(intr).indent(),

          ..._getOperatorSet(intr).indent(),
          '}',
        ],
      ),
    );
  }

  List<Object> _getGet(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'V get(', intr.enumName, ' key) {\n',
      '  return switch (key) {\n',
      for (final value in intr.enumIntr.values)
        ...[
          //
          intr.enumName, '.', value.name, ' => ', value.name, ',\n',
        ].indent(4),
      '  };\n',
      '}\n',
    ];
  }

  List<Object> _getToString(IntrospectionData intr) {
    final i = intr.ids;

    final valuesExceptLast = [...intr.enumIntr.values];
    final last = valuesExceptLast.removeLast();

    return [
      //
      '@', i.override, '\n',
      i.String, ' toString() {\n',
      '  final b = ', i.StringBuffer, '("{");\n',
      for (final v in valuesExceptLast) ...[
        //
        '  b.write("', intr.enumName, '.', v.name, r': $', v.name, ', ");\n',
      ],
      '  b.write("', intr.enumName, '.', last.name, r': $', last.name, '}");\n',
      '  return b.toString();\n',
      '}\n',
    ];
  }

  // Getters:

  List<Object> _getGetEntries(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.Iterable, '<', i.MapEntry, '<', intr.enumName, ', V>> get entries {\n',
      '  return ', i.UnmodifiableListView, '([\n',
      for (final v in intr.enumIntr.values)
        ...[
          //
          i.MapEntry, '(', intr.enumName, '.', v.name, ', ', v.name, '),\n',
        ].indent(4),
      '  ]);\n',
      '}\n',
    ];
  }

  List<Object> _getGetIsEmpty(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.bool, ' get isEmpty {\n',
      '  return false;\n',
      '}\n',
    ];
  }

  List<Object> _getGetIsNotEmpty(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.bool, ' get isNotEmpty {\n',
      '  return true;\n',
      '}\n',
    ];
  }

  List<Object> _getGetKeys(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.Iterable, '<', intr.enumName, '> get keys {\n',
      '  return ', intr.enumName, '.values;\n',
      '}\n',
    ];
  }

  List<Object> _getGetLength(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.int, ' get length {\n',
      '  return ${intr.enumIntr.values.length};\n',
      '}\n',
    ];
  }

  List<Object> _getGetValues(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.Iterable, '<V> get values {\n',
      '  return ', i.UnmodifiableListView, '([\n',
      for (final value in intr.enumIntr.values)
        ...[
          //
          value.name, ',\n',
        ].indent(4),
      '  ]);\n',
      '}\n',
    ];
  }

  // Methods:

  List<Object> _getCast(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.Map, '<RK, RV> cast<RK, RV>() {\n',
      '  return ', i.Map, '.castFrom<', intr.enumName, ', V, RK, RV>(this);\n',
      '}\n',
    ];
  }

  List<Object> _getClear(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void clear() {\n',
      ..._getThrowUnsupported(intr),
      '}\n',
    ];
  }

  List<Object> _getContainsKey(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.bool, ' containsKey(', i.Object, '? key) {\n',
      '  return key.runtimeType == ', intr.enumName, ';\n',
      '}\n',
    ];
  }

  List<Object> _getContainsValue(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.bool, ' containsValue(', i.Object, '? value) {\n',
      for (final value in intr.enumIntr.values)
        ...[
          //
          'if (value == ', value.name, ') return true;\n',
        ].indent(),
      '  return false;\n',
      '}\n',
    ];
  }

  List<Object> _getForEach(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void forEach(void action(', intr.enumName, ' key, V value)) {\n',
      for (final value in intr.enumIntr.values)
        ...[
          //
          'action(', intr.enumName, '.', value.name, ', ', value.name, ');\n',
        ].indent(),
      '}\n',
    ];
  }

  List<Object> _getMap(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      i.Map, '<K2, V2> map<K2, V2>(',
      i.MapEntry, '<K2, V2> convert(', intr.enumName, ' key, V value)) {\n',

      '  return ', i.Map, '.fromEntries([\n',
      for (final value in intr.enumIntr.values)
        ...[
          //
          'convert(', intr.enumName, '.', value.name, ', ', value.name, '),\n',
        ].indent(4),
      '  ]);\n',
      '}\n',
    ];
  }

  List<Object> _getRemove(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'V? remove(', i.Object, '? key) {\n',
      ..._getThrowUnsupported(intr),
      '}\n',
    ];
  }

  List<Object> _getRemoveWhere(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void removeWhere(',
      i.bool, ' test(', intr.enumName, ' key, V value)) {\n',

      ..._getThrowUnsupported(intr),
      '}\n',
    ];
  }

  // Operators:

  List<Object> _getOperatorGet(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'V? operator [](', i.Object, '? key) {\n',
      '  return switch (key) {\n',
      for (final value in intr.enumIntr.values)
        ...[
          //
          intr.enumName, '.', value.name, ' => ', value.name, ',\n',
        ].indent(4),
      '    _ => null,\n',
      '  };\n',
      '}\n',
    ];
  }

  // End of Map interface.

  Future<IntrospectionData> _introspect(
    TypeDeclaration enuum,
    MemberDeclarationBuilder builder,
  ) async {
    final (ids, enumIntr) = await (
      ResolvedIdentifiers.fill(builder),
      builder.introspectEnum(enuum),
    ).wait;

    return IntrospectionData(
      enumIntr: enumIntr,
      enumName: enuum.identifier.name,
      enuum: enuum,
      ids: ids,
      mapClassName: _getMapClassName(enuum),
    );
  }

  String _getMapClassName(TypeDeclaration enuum);
}

/// Creates a modifiable map based on an enum.
macro class MakeMap extends _MakeMapBase {
  /// Creates a modifiable map based on an enum.
  const MakeMap();

  @override
  Future<Identifier> _getMapBaseClassTypePhase(ClassTypeBuilder builder) async {
    // ignore: deprecated_member_use
    return builder.resolveIdentifier(Libraries.enumMap, 'EnumMap');
  }

  @override
  Identifier _getMapBaseClassDeclarationPhase(IntrospectionData intr) {
    return intr.ids.EnumMap;
  }

  @override
  List<Object> _getFields(IntrospectionData intr) {
    final result = <Object>[];

    for (final value in intr.enumIntr.values) {
      result.addAll([
        'V ',
        value.name,
        ';\n',
      ]);
    }

    return result;
  }

  @override
  List<Object> _getConstructor(IntrospectionData intr) {
    return [
      //
      intr.mapClassName, '({\n',
      for (final value in intr.enumIntr.values)
        ...[
          //
          'required this.', value.name, ',\n',
        ].indent(),
      '});\n',
    ];
  }

  @override
  List<Object> _getAddAll(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void addAll(', i.Map, '<', intr.enumName, ', V> other) {\n',
      '  for (final entry in other.entries) this[entry.key] = entry.value;\n',
      '}\n',
    ];
  }

  @override
  List<Object> _getAddEntries(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void addEntries(',
      i.Iterable, '<', i.MapEntry, '<', intr.enumName, ', V>> newEntries) {\n',

      '  for (final entry in newEntries) this[entry.key] = entry.value;\n',
      '}\n',
    ];
  }

  @override
  List<Object> _getPutIfAbsent(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'V putIfAbsent(', intr.enumName, ' key, V ifAbsent()) {\n',
      '  return get(key);\n',
      '}\n',
    ];
  }

  @override
  List<Object> _getUpdate(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'V update(',
      intr.enumName, ' key, V update(V value), {V ifAbsent()?}) {\n',

      '  return this[key] = update(get(key));\n',
      '}\n',
    ];
  }

  @override
  List<Object> _getUpdateAll(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void updateAll(V update(', intr.enumName, ' key, V value)) {\n',
      for (final v in intr.enumIntr.values)
        ...[
          //
          v.name, ' = update(', intr.enumName, '.', v.name, ', ', v.name,
          ');\n',
        ].indent(),
      '}\n',
    ];
  }

  @override
  List<Object> _getOperatorSet(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void operator []=(', i.Object, '? key, V value) {\n',
      for (final value in intr.enumIntr.values)
        ...[
          //
          'if (key == ', intr.enumName, '.', value.name, ') {\n',
          '  ', value.name, ' = value;\n',
          '  return;\n',
          '}\n',
        ].indent(),
      '}\n',
    ];
  }

  @override
  String _getMapClassName(TypeDeclaration enuum) {
    return '${enuum.identifier.name}Map';
  }
}

/// Creates an unmodifiable map based on an enum.
macro class MakeUnmodifiableMap extends _MakeMapBase {
  /// Creates an unmodifiable map based on an enum.
  const MakeUnmodifiableMap();

  @override
  Future<Identifier> _getMapBaseClassTypePhase(ClassTypeBuilder builder) async {
    // ignore: deprecated_member_use
    return builder.resolveIdentifier(
      Libraries.unmodifiableEnumMap,
      'UnmodifiableEnumMap',
    );
  }

  @override
  Identifier _getMapBaseClassDeclarationPhase(IntrospectionData intr) {
    return intr.ids.UnmodifiableEnumMap;
  }

  @override
  List<Object> _getFields(IntrospectionData intr) {
    final result = <Object>[];

    for (final value in intr.enumIntr.values) {
      result.addAll([
        'final V ',
        value.name,
        ';\n',
      ]);
    }

    return result;
  }

  @override
  List<Object> _getConstructor(IntrospectionData intr) {
    return [
      //
      'const ', intr.mapClassName, '({\n',
      for (final value in intr.enumIntr.values)
        ...[
          //
          'required this.', value.name, ',\n',
        ].indent(),
      '});\n',
    ];
  }

  @override
  List<Object> _getAddAll(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void addAll(', i.Map, '<', intr.enumName, ', V> other) {\n',
      ..._getThrowUnsupported(intr),
      '}\n',
    ];
  }

  @override
  List<Object> _getAddEntries(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void addEntries(',
      i.Iterable, '<', i.MapEntry, '<', intr.enumName, ', V>> newEntries) {\n',

      ..._getThrowUnsupported(intr),
      '}\n',
    ];
  }

  @override
  List<Object> _getPutIfAbsent(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'V putIfAbsent(', intr.enumName, ' key, V ifAbsent()) {\n',
      ..._getThrowUnsupported(intr),
      '}\n',
    ];
  }

  @override
  List<Object> _getUpdate(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'V update(',
      intr.enumName, ' key, V update(V value), {V ifAbsent()?}) {\n',

      ..._getThrowUnsupported(intr),
      '}\n',
    ];
  }

  @override
  List<Object> _getUpdateAll(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void updateAll(V update(', intr.enumName, ' key, V value)) {\n',
      ..._getThrowUnsupported(intr),
      '}\n',
    ];
  }

  @override
  List<Object> _getOperatorSet(IntrospectionData intr) {
    final i = intr.ids;

    return [
      //
      '@', i.override, '\n',
      'void operator []=(', i.Object, '? key, V value) {\n',
      ..._getThrowUnsupported(intr),
      '}\n',
    ];
  }

  @override
  String _getMapClassName(TypeDeclaration enuum) {
    return 'Unmodifiable${enuum.identifier.name}Map';
  }
}

List<Object> _getThrowUnsupported(IntrospectionData intr) {
  return [
    '  throw ',
    intr.ids.UnsupportedError,
    "('Cannot remove objects from this map');\n",
  ];
}
