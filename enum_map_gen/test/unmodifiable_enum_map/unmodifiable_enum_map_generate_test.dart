@TestOn('vm')
import 'package:enum_map_gen/src/unmodifiable_map_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  initializeBuildLogTracking();

  final jsonSerializableTestReader = await initializeLibraryReaderForDirectory(
    'test/unmodifiable_enum_map/src',
    'input.dart',
  );

  testAnnotatedElements(
    jsonSerializableTestReader,
    UnmodifiableEnumMapGenerator(),
    expectedAnnotatedTests: ['Fruit'],
  );
}
