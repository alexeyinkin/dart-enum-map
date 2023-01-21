import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:enum_map/annotations.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../util/enum_element.dart';

abstract class AbstractEnumMapGenerator<T extends AbstractGenerateEnumMap>
    extends GeneratorForAnnotation<T> {
  static const _throwUnsupportedError =
      "throw UnsupportedError('Cannot remove objects from this map');";

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final e = requireEnumElement(element);
    final a = readAnnotation(annotation);

    final buffer = StringBuffer();

    buffer.write('class ');
    buffer.write(getClassName(a, e));
    buffer.write('<V> ');
    buffer.write('extends ');
    buffer.write(getSuperclassName(a, e));
    buffer.writeln('<${e.name}, V> {');

    buffer.writeln(getConstants(a, e));
    buffer.writeln(getConstructor(a, e));
    buffer.writeln(getExtraFields(a, e));

    buffer.writeln(getCast(a, e));
    buffer.writeln(getContainsValue(a, e));
    buffer.writeln(getContainsKey(a, e));
    buffer.writeln(getOperatorGet(a, e));
    buffer.writeln(getOperatorSet(a, e));
    buffer.writeln(getEntries(a, e));
    buffer.writeln(getMap(a, e));
    buffer.writeln(getAddEntries(a, e));
    buffer.writeln(getUpdate(a, e));
    buffer.writeln(getUpdateAll(a, e));
    buffer.writeln(getRemoveWhere(a, e));
    buffer.writeln(getPutIfAbsent(a, e));
    buffer.writeln(getAddAll(a, e));
    buffer.writeln(getRemove(a, e));
    buffer.writeln(getClear(a, e));
    buffer.writeln(getForEach(a, e));
    buffer.writeln(getKeys(a, e));
    buffer.writeln(getValues(a, e));
    buffer.writeln(getLength(a, e));
    buffer.writeln(getIsEmpty(a, e));
    buffer.writeln(getIsNotEmpty(a, e));

    buffer.writeln(getGet(a, e));
    buffer.writeln(getToString(a, e));

    buffer.writeln('}');
    return buffer.toString();
  }

  @protected
  EnumElement requireEnumElement(Element element) {
    if (element is! EnumElement) {
      throw Exception(
        '@EnumMap can only be applied to enum but was applied to '
        '${element.name} which is ${element.kind.displayName}',
      );
    }

    return element;
  }

  @protected
  T readAnnotation(ConstantReader reader);

  @protected
  bool getNullableGet(ConstantReader reader) {
    return reader.read('nullableGet').literalValue as bool? ?? false;
  }

  @protected
  String getClassName(T a, EnumElement e);

  @protected
  String getSuperclassName(T a, EnumElement e);

  @protected
  String getConstants(T a, EnumElement e) {
    final buffer = StringBuffer();

    for (final constant in e.constants) {
      buffer.write(getConstant(a, e, constant));
      buffer.writeln(';');
    }

    return buffer.toString();
  }

  @protected
  String getConstant(T a, EnumElement e, FieldElement c);

  @protected
  String getConstructor(T a, EnumElement e) {
    return 'const ' +
        getClassName(a, e) +
        getConstructorArguments(a, e) +
        ';\n';
  }

  @protected
  String getConstructorArguments(T a, EnumElement e) {
    final buffer = StringBuffer();
    buffer.writeln('({');

    for (final constant in e.constants) {
      buffer.write(getConstructorArgument(a, e, constant));
      buffer.writeln(',');
    }

    buffer.writeln('})');
    return buffer.toString();
  }

  @protected
  String getConstructorArgument(T a, EnumElement e, FieldElement constant) {
    return 'required this.${constant.name}';
  }

  @protected
  String getExtraFields(T a, EnumElement e) => '';

  @protected
  String getCast(T a, EnumElement e) {
    return '@override\nMap<RK, RV> cast<RK, RV>() {' +
        getCastBody(a, e) +
        '}\n';
  }

  @protected
  String getCastBody(T a, EnumElement e) {
    return 'return Map.castFrom<${e.name}, V, RK, RV>(this);';
  }

  @protected
  String getContainsValue(T a, EnumElement e) {
    return '@override\nbool containsValue(Object? value) {' +
        getContainsValueBody(a, e) +
        '}\n';
  }

  @protected
  String getContainsValueBody(T a, EnumElement e) {
    final buffer = StringBuffer();

    for (final constant in e.constants) {
      buffer.writeln('if (this.${constant.name} == value) return true;');
    }

    buffer.writeln('return false;');
    return buffer.toString();
  }

  @protected
  String getContainsKey(T a, EnumElement e) {
    return '@override\nbool containsKey(Object? key) {\n' +
        getContainsKeyBody(a, e) +
        '}\n';
  }

  @protected
  String getContainsKeyBody(T a, EnumElement e) {
    return 'return key.runtimeType == ${e.name};\n';
  }

  @protected
  String getOperatorGet(T a, EnumElement e) {
    return '@override\nV? operator [](Object? key) {' +
        getOperatorGetBody(a, e) +
        '}\n';
  }

  @protected
  String getOperatorGetBody(T a, EnumElement e) {
    return getOperatorGetSwitch(a, e) + 'return null;\n';
  }

  @protected
  String getOperatorGetSwitch(T a, EnumElement e) {
    final buffer = StringBuffer('switch (key) {\n');

    for (final constant in e.constants) {
      buffer.writeln(
        'case ${e.name}.${constant.name}: '
        'return this.${constant.name};',
      );
    }

    buffer.writeln('}\n');
    return buffer.toString();
  }

  @protected
  String getOperatorSet(T a, EnumElement e) {
    return '@override\nvoid operator []=(${e.name} key, V value) {' +
        getOperatorSetBody(a, e) +
        '}\n';
  }

  @protected
  String getOperatorSetBody(T a, EnumElement e) {
    final buffer = StringBuffer();

    for (final constant in e.constants) {
      buffer.writeln(
        'if (key == ${e.name}.${constant.name}) {\n'
        'this.${constant.name} = value;\n'
        'return;\n'
        '}\n',
      );
    }

    return buffer.toString();
  }

  @protected
  String getEntries(T a, EnumElement e) {
    return '@override\n'
            'Iterable<MapEntry<${e.name}, V>> get entries {' +
        getEntriesBody(a, e) +
        '}\n';
  }

  @protected
  String getEntriesBody(T a, EnumElement e) {
    return 'return ' + getEntriesList(a, e) + ';\n';
  }

  @protected
  String getEntriesList(T a, EnumElement e) {
    final buffer = StringBuffer('[');

    for (final constant in e.constants) {
      buffer.writeln(
        'MapEntry<${e.name}, V>('
        '${e.name}.${constant.name}, '
        'this.${constant.name}'
        '),\n',
      );
    }

    buffer.write(']');
    return buffer.toString();
  }

  @protected
  String getMap(T a, EnumElement e) {
    return '@override\n'
            'Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> transform(${e.name} key, '
            'V value)) {\n' +
        getMapBody(a, e) +
        '}\n';
  }

  @protected
  String getMapBody(T a, EnumElement e) {
    final buffer = StringBuffer();
    final setBuffer = StringBuffer();

    for (final constant in e.constants) {
      buffer.writeln(
        'final ${constant.name} = transform('
        '${e.name}.${constant.name}, '
        'this.${constant.name}'
        ');',
      );
      setBuffer.writeln('${constant.name}.key: ${constant.name}.value,');
    }

    buffer.writeln('return {');
    buffer.write(setBuffer);
    buffer.writeln('};');
    return buffer.toString();
  }

  @protected
  String getAddEntries(T a, EnumElement e) {
    return '@override\n'
            'void addEntries(Iterable<MapEntry<${e.name}, V>> newEntries) {\n' +
        getAddEntriesBody(a, e) +
        '}\n';
  }

  @protected
  String getAddEntriesBody(T a, EnumElement e) {
    return 'for (final e in newEntries) this[e.key] = e.value;\n';
  }

  @protected
  String getUpdate(T a, EnumElement e) {
    return '@override\n'
            'V update('
            '${e.name} key, '
            'V update(V value), '
            '{V Function()? ifAbsent}) {\n' +
        getUpdateBody(a, e) +
        '}\n';
  }

  @protected
  String getUpdateBody(T a, EnumElement e) {
    return 'return this[key] = update(this.get(key));\n';
  }

  @protected
  String getUpdateAll(T a, EnumElement e) {
    return '@override\n'
            'void updateAll(V update(${e.name} key, V value)) {\n' +
        getUpdateAllBody(a, e) +
        '}\n';
  }

  @protected
  String getUpdateAllBody(T a, EnumElement e) {
    final buffer = StringBuffer();

    for (final constant in e.constants) {
      buffer.writeln(
        'this.${constant.name} = update('
        '${e.name}.${constant.name}, '
        'this.${constant.name}'
        ');',
      );
    }

    return buffer.toString();
  }

  @protected
  String getRemoveWhere(T a, EnumElement e) {
    return '@override\n'
            'void removeWhere(bool test(${e.name} key, V value)) {\n' +
        getRemoveWhereBody(a, e) +
        '}\n';
  }

  @protected
  String getRemoveWhereBody(T a, EnumElement e) {
    return _throwUnsupportedError;
  }

  @protected
  String getPutIfAbsent(T a, EnumElement e) {
    return '@override\n' 'V putIfAbsent(${e.name} key, V ifAbsent()) {\n' +
        getPutIfAbsentBody(a, e) +
        '}\n';
  }

  @protected
  String getPutIfAbsentBody(T a, EnumElement e) => 'return this.get(key);';

  @protected
  String getAddAll(T a, EnumElement e) {
    return '@override\n' 'void addAll(Map<${e.name}, V> other) {\n' +
        getAddAllBody(a, e) +
        '}\n';
  }

  @protected
  String getAddAllBody(T a, EnumElement e) {
    return 'for (final e in other.entries) this[e.key] = e.value;';
  }

  @protected
  String getRemove(T a, EnumElement e) {
    return '@override\n' 'V? remove(Object? key) {\n' +
        getRemoveBody(a, e) +
        '}\n';
  }

  @protected
  String getRemoveBody(T a, EnumElement e) {
    return _throwUnsupportedError;
  }

  @protected
  String getClear(T a, EnumElement e) {
    return '@override\nvoid clear() {\n' + getClearBody(a, e) + '}\n';
  }

  @protected
  String getClearBody(T a, EnumElement e) {
    return _throwUnsupportedError;
  }

  @protected
  String getForEach(T a, EnumElement e) {
    return '@override\n'
            'void forEach(void action(${e.name} key, V value)) {\n' +
        getForEachBody(a, e) +
        '}\n';
  }

  @protected
  String getForEachBody(T a, EnumElement e) {
    final buffer = StringBuffer();

    for (final c in e.constants) {
      buffer.writeln('action(${e.name}.${c.name}, this.${c.name});');
    }

    return buffer.toString();
  }

  @protected
  String getKeys(T a, EnumElement e) {
    return '@override\n' 'Iterable<${e.name}> get keys {\n' +
        getKeysBody(a, e) +
        '}\n';
  }

  @protected
  String getKeysBody(T a, EnumElement e) {
    return 'return ${e.name}.values;\n';
  }

  @protected
  String getValues(T a, EnumElement e) {
    return '@override\n' 'Iterable<V> get values {\n' +
        getValuesBody(a, e) +
        '}\n';
  }

  @protected
  String getValuesBody(T a, EnumElement e) {
    final buffer = StringBuffer('return List.unmodifiable([\n');

    for (final c in e.constants) {
      buffer.writeln('this.${c.name},');
    }

    buffer.writeln(']);');
    return buffer.toString();
  }

  @protected
  String getLength(T a, EnumElement e) {
    return '@override\nint get length {\n' + getLengthBody(a, e) + '}\n';
  }

  @protected
  String getLengthBody(T a, EnumElement e) {
    return 'return ${e.constants.length};';
  }

  @protected
  String getIsEmpty(T a, EnumElement e) {
    return '@override\nbool get isEmpty {\n' + getIsEmptyBody(a, e) + '}\n';
  }

  @protected
  String getIsEmptyBody(T a, EnumElement e) {
    return 'return false;';
  }

  @protected
  String getIsNotEmpty(T a, EnumElement e) {
    return '@override\n' 'bool get isNotEmpty {\n' +
        getIsNotEmptyBody(a, e) +
        '}\n';
  }

  @protected
  String getIsNotEmptyBody(T a, EnumElement e) {
    return 'return true;';
  }

  @protected
  String getGet(T a, EnumElement e) {
    return 'V get(${e.name} key) {' + getGetBody(a, e) + '}\n';
  }

  @protected
  String getGetBody(T a, EnumElement e) {
    return getOperatorGetSwitch(a, e);
  }

  @protected
  String getToString(T a, EnumElement e) {
    return '@override\nString toString() {\n' + getToStringBody(a, e) + '}\n';
  }

  @protected
  String getToStringBody(T a, EnumElement e) {
    final buffer = StringBuffer('final buffer = StringBuffer("{");');
    bool first = true;

    for (final constant in e.constants) {
      if (!first) {
        buffer.writeln('buffer.write(", ");');
      }

      buffer.writeln(
        'buffer.write("${e.name}.${constant.name}: '
        '\${this.${constant.name}}");',
      );
      first = false;
    }

    buffer.writeln('buffer.write("}");');
    buffer.writeln('return buffer.toString();');
    return buffer.toString();
  }
}
