from __future__ import annotations

import json
import pathlib
import re


def collect_translation_keys(root: pathlib.Path) -> list[str]:
    """Scan Dart files under root and extract literal keys used with .tr()."""
    pattern = re.compile(r"(['\"])(.+?)\1\.tr")
    keys: set[str] = set()

    for dart_file in root.rglob("*.dart"):
        text = dart_file.read_text(encoding="utf-8")
        for match in pattern.finditer(text):
            key = match.group(2)
            # Skip interpolated strings like '${foo}' which are dynamic keys.
            if key.startswith("${") and key.endswith("}"):
                continue
            keys.add(key)

    return sorted(keys)


if __name__ == "__main__":
    lib_path = pathlib.Path(__file__).resolve().parents[1] / "lib"
    keys = collect_translation_keys(lib_path)
    print(json.dumps(keys, ensure_ascii=False, indent=2))

