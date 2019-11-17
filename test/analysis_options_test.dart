// Copyright 2019 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
