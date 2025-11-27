import 'dart:convert';
import 'dart:io';

void main() {
  final libDir = Directory('lib');
  final pattern = RegExp(r'''(["'])(.+?)\1\.tr''');
  final keys = <String>{};

  if (!libDir.existsSync()) {
    stderr.writeln('lib directory not found');
    exit(1);
  }

  for (final entity in libDir.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final content = entity.readAsStringSync();
    for (final match in pattern.allMatches(content)) {
      final key = match.group(2);
      if (key == null) continue;
      if (key.startsWith(r'${') && key.endsWith('}')) continue;
      keys.add(key);
    }
  }

  final sortedKeys = keys.toList()..sort();
  final encoder = const JsonEncoder.withIndent('  ');
  stdout.writeln(encoder.convert(sortedKeys));
}

