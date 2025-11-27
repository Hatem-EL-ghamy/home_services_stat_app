import 'dart:convert';
import 'dart:io';

final _localeKeyPattern =
    RegExp(r"static const [A-Za-z0-9_]+ = '([^']+)';", multiLine: true);

void main() {
  final projectRoot = Directory.current.path;
  final keys = <String>{};

  // Load keys from tr_keys.json
  final trKeysFile = File('tr_keys.json');
  if (trKeysFile.existsSync()) {
    final dynamic data = jsonDecode(trKeysFile.readAsStringSync());
    if (data is List) {
      keys.addAll(data.cast<String>());
    }
  }

  // Load keys from locale_keys.dart
  final localeKeysFile = File('lib/translations/locale_keys.dart');
  if (localeKeysFile.existsSync()) {
    final content = localeKeysFile.readAsStringSync();
    for (final match in _localeKeyPattern.allMatches(content)) {
      keys.add(match.group(1)!);
    }
  }

  if (keys.isEmpty) {
    stderr.writeln('No keys found.');
    exit(1);
  }

  final sortedKeys = keys.toList()..sort();
  final enMap = _buildMap('assets/translations/en.json', sortedKeys);
  final arMap = _buildMap('assets/translations/ar.json', sortedKeys);

  File('assets/translations/en.generated.json')
    ..createSync(recursive: true)
    ..writeAsStringSync(const JsonEncoder.withIndent('  ').convert(enMap));

  File('assets/translations/ar.generated.json')
    ..createSync(recursive: true)
    ..writeAsStringSync(const JsonEncoder.withIndent('  ').convert(arMap));

  stdout.writeln(
      'Generated en.generated.json and ar.generated.json with ${sortedKeys.length} keys.');
}

Map<String, String> _buildMap(String path, List<String> keys) {
  final file = File(path);
  Map<String, dynamic> existing = {};
  if (file.existsSync()) {
    try {
      existing = jsonDecode(file.readAsStringSync())
          as Map<String, dynamic>;
    } catch (_) {}
  }

  final map = <String, String>{};
  for (final key in keys) {
    final trimmedKey = key.trim();
    final value = existing[key]?.toString() ?? trimmedKey;
    map[key] = value;
  }
  return map;
}

