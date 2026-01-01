#!/usr/bin/env python3
import argparse
import re
from pathlib import Path


BLOCK_RE = re.compile(
    r"(?P<config>(?P<comment>^#[^\n]*\n)?^[ \t]*[^\s#][^{\n]*[ \t]*\{.*?^\s*}\s*)",
    re.MULTILINE | re.DOTALL,
)
NAME_RE = re.compile(r"^\s*name\s*=\s*([^\s#}]+)", re.MULTILINE)


def sort_blocks(text: str) -> str:
    matches = list(BLOCK_RE.finditer(text))
    if not matches:
        return text

    sortable = []
    sortable_indexes = set()
    for idx, match in enumerate(matches):
        name_match = NAME_RE.search(match.group("config"))
        if not name_match:
            continue
        name = name_match.group(1)
        sortable.append((name, match.group("config")))
        sortable_indexes.add(idx)

    if not sortable:
        return text

    sortable.sort(key=lambda item: (item[0].lower(), item[0]))
    sorted_iter = iter([item[1] for item in sortable])

    result = []
    last = 0
    for idx, match in enumerate(matches):
        result.append(text[last:match.start()])
        if idx in sortable_indexes:
            result.append(next(sorted_iter))
        else:
            result.append(match.group("config"))
        last = match.end()
    result.append(text[last:])

    return "".join(result)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Sort Hyprland-style config blocks by their name field."
    )
    parser.add_argument("path", help="Path to the config file")
    parser.add_argument(
        "--stdout",
        action="store_true",
        help="Write the sorted content to stdout instead of modifying the file",
    )
    args = parser.parse_args()

    path = Path(args.path)
    original = path.read_text(encoding="utf-8")
    updated = sort_blocks(original)

    if args.stdout:
        print(updated, end="")
        return 0

    if updated != original:
        path.write_text(updated, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
