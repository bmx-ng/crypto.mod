"""Regenerate the BlitzMax fixture from the pinned, official BLAKE3 vectors."""
import json
from pathlib import Path

directory = Path(__file__).resolve().parent
vectors = json.loads((directory / "test_vectors.json").read_text(encoding="utf-8"))
lines = ["' Generated from the unmodified official BLAKE3 1.8.7 test_vectors.json."]
for case in vectors["cases"]:
    lines.append(
        f'Vector({case["input_len"]}, "{case["hash"]}", '
        f'"{case["keyed_hash"]}", "{case["derive_key"]}")'
    )
(directory / "vectors.bmx").write_text("\n".join(lines) + "\n", encoding="utf-8")
