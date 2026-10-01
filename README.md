[![GitHub](https://img.shields.io/github/license/alexeyinkin/dart-enum-map)](https://github.com/alexeyinkin/dart-enum-map/blob/main/LICENSE)
[![Support Chat](https://img.shields.io/badge/support%20chat-telegram-brightgreen)](https://ainkin.com/chat)

A Map with the compile-time check that every `enum` constant has an entry in it.

This repository contains two packages:

- [enum_map](enum_map) ([pub.dev](https://pub.dev/packages/enum_map)):
  annotations and base classes. See its README for usage.
- [enum_map_gen](enum_map_gen) ([pub.dev](https://pub.dev/packages/enum_map_gen)):
  the code generator.

## Macros

`enum_map` 0.4.0-1.dev and 0.4.0-2.dev were an experimental rewrite with Dart macros.
Dart macros were canceled, so that rewrite is discontinued,
and the code generator is the supported approach.
The rewrite is kept in the `macros` branch.
