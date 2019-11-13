import 'dart:io';

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  final yamlFiles = Directory('lib')
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.yaml'));
  for (final file in yamlFiles) {
    final fileName = file.path.split(Platform.pathSeparator).last;

    test(fileName, () {
      final yaml = loadYaml(file.readAsStringSync(), sourceUrl: fileName);

      final lints = List<String>.from(yaml['linter']['rules']);
      expect(lints, isNotEmpty);

      final severities = Map<String, String>.from(yaml['analyzer']['errors']);
      for (final lint in lints) {
        expect(severities, containsPair(lint, 'error'));
      }
    });
  }
}
