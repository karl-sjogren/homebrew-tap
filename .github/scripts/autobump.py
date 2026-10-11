import json
import os
import re
import sys
from pathlib import Path


def replace_once(formula: str, pattern: str, replacement: str) -> str:
    updated, count = re.subn(pattern, replacement, formula, count=1, flags=re.MULTILINE)
    if count != 1:
        raise ValueError(f"Expected one formula match for {pattern!r}, found {count}")
    return updated


release_path, formula_path = map(Path, sys.argv[1:3])
release = json.loads(release_path.read_text())
if release["draft"] or release["prerelease"]:
    raise ValueError("Latest upstream release must be published and stable")

version = release["tag_name"]
if not re.fullmatch(r"\d+\.\d+\.\d+", version):
    raise ValueError(f"Unsupported upstream release tag: {version}")

formula = formula_path.read_text()
current_version_match = re.search(
    r'^  @arm64url = "https://github\.com/karl-sjogren/karls-gitflow/releases/download/'
    r'(\d+\.\d+\.\d+)/',
    formula,
    re.MULTILINE,
)
if current_version_match is None:
    raise ValueError("Could not read the formula version")
current_version = current_version_match.group(1)
if tuple(map(int, version.split("."))) <= tuple(map(int, current_version.split("."))):
    print(f"No newer release: formula is {current_version}, upstream is {version}")
    if output := os.environ.get("GITHUB_OUTPUT"):
        with Path(output).open("a") as output_file:
            output_file.write("has_update=false\n")
    sys.exit(0)

assets = {asset["name"]: asset for asset in release["assets"]}
for architecture in ("arm64", "x64"):
    filename = f"karls-gitflow-{version}-osx-{architecture}.zip"
    asset = assets.get(filename)
    digest = asset.get("digest") if asset else None
    if not isinstance(digest, str):
        digest = ""
    digest_match = re.fullmatch(r"sha256:([0-9a-f]{64})", digest)
    if digest_match is None:
        raise ValueError(f"Missing SHA-256 digest for upstream asset {filename}")

    formula = replace_once(
        formula,
        rf'^  @{architecture}url = ".*"$',
        f'  @{architecture}url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/'
        f'{version}/{filename}"',
    )
    formula = replace_once(
        formula,
        rf"^  @{architecture}sha256 = \".*\"$",
        f'  @{architecture}sha256 = "{digest_match.group(1)}"',
    )

formula = replace_once(
    formula,
    r'^    assert_equal ".*", shell_output\("#{bin}/git-flow --version"\)\.strip$',
    f'    assert_equal "{version}", shell_output("#{bin}/git-flow --version").strip',
)
formula_path.write_text(formula)
print(f"Updated karls-gitflow formula from {current_version} to {version}")
if output := os.environ.get("GITHUB_OUTPUT"):
    with Path(output).open("a") as output_file:
        output_file.write(f"has_update=true\nversion={version}\n")
