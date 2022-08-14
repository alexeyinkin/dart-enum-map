import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/modifiable_map_generator.dart';
import 'src/unmodifiable_map_generator.dart';

Builder modifiableEnumMapBuilder(BuilderOptions options) => SharedPartBuilder(
      [ModifiableEnumMapGenerator()],
      'enum_map_gen_modifiable',
    );

Builder unmodifiableEnumMapBuilder(BuilderOptions options) => SharedPartBuilder(
      [UnmodifiableEnumMapGenerator()],
      'enum_map_gen_unmodifiable',
    );
