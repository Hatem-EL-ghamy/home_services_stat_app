import 'dart:io';

final _pattern = RegExp(r"'([^']*[A-Za-z][^']*)'");

void main() {
  final libDir = Directory('lib');
  final results = <String, List<String>>{};

  for (final entity in libDir.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final path = entity.path.replaceAll('\\', '/');
    if (path.endsWith('.g.dart') ||
        path.endsWith('.freezed.dart') ||
        path.contains('/generated/')) {
      continue;
    }
    final content = entity.readAsStringSync();

    final fileResults = <String>{};
    for (final match in _pattern.allMatches(content)) {
      final fullMatch = match.group(0)!;
      final key = match.group(1)!;

      if (_shouldSkip(key)) continue;

      final after = _peekAfter(content, match.end);
      if (after.trimLeft().startsWith('.tr')) {
        continue;
      }

      fileResults.add(key);
    }

    if (fileResults.isNotEmpty) {
      results[entity.path] = fileResults.toList();
    }
  }

  if (results.isEmpty) {
    print('All strings appear localized.');
    return;
  }

  results.forEach((path, keys) {
    print('File: $path');
    for (final key in keys) {
      print('  $key');
    }
  });
}

bool _shouldSkip(String key) {
  final trimmed = key.trim();
  if (trimmed.isEmpty) return true;
  if (trimmed.startsWith(r'$')) return true;
  final lower = trimmed.toLowerCase();
  if (lower.contains('http') ||
      lower.contains('assets/') ||
      lower.contains('package:') ||
      lower.endsWith('.dart') ||
      lower.contains('dart:')) {
    return true;
  }
  if (trimmed.contains(RegExp(r'[{}]'))) return true;
  if (!RegExp(r'[A-Za-z]').hasMatch(trimmed)) return true;

  final isSingleWord = !trimmed.contains(' ');
  if (isSingleWord && !RegExp(r'^[A-Z][A-Za-z0-9&]+$').hasMatch(trimmed)) {
    return true;
  }

  return false;
}

String _peekAfter(String content, int start) {
  final end = start + 5;
  return content.substring(start, end > content.length ? content.length : end);
}

