import 'package:enum_map_gen/src/unmodifiable_map_generator.dart';
import 'package:source_gen_test_golden/source_gen_test_golden.dart';

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
