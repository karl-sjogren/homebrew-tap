# Repository guidance

This repository is a Homebrew tap, not the source repository for the software it distributes. Formulae live in `Formula/`; currently, `karls-gitflow` packages prebuilt release archives from the upstream GitHub project.

## Checks

- Run `brew style Formula/karls-gitflow.rb` to lint the formula.
- Run `brew audit --strict --online Formula/karls-gitflow.rb` to audit it.
- Run `brew test-bot --tap karl-sjogren/tap --testing-formulae karls-gitflow --only-formulae` to run the formula lifecycle, including its test.
- Run `brew test-bot --only-tap-syntax` for the tap syntax check used in CI.
- Run `brew test-bot --only-formulae` to test the tap's formulae, as in the pull request workflow.

## Formula conventions

- Treat upstream release metadata as a coordinated set: update `version`, architecture-specific archive URLs and SHA-256 checksums when bumping a release. Keep bottle metadata only when matching bottles have actually been published; do not leave bottle checksums for an older version.
- Keep architecture selection explicit (`Hardware::CPU.intel?` for Intel, otherwise Apple Silicon) and keep platform restrictions aligned with the requirements of the packaged release.
- Install the archive contents under `libexec` and expose user-facing commands through symlinks in `bin`; keep the formula test focused on the installed command's observable output.
- Formulae use Homebrew's Ruby DSL. Follow the existing formula's layout and use `depends_on`, `conflicts_with`, `bottle`, `install`, and `test` blocks for their respective metadata and behavior.

## Automation

`.github/workflows/tests.yml` runs Homebrew tap syntax checks on pushes to `main` and pull requests; formula tests run on pull requests. `.github/workflows/autobump.yml` schedules Homebrew's autobump workflow daily. `.github/workflows/publish.yml` is manually dispatched to pull bottles for a pull request, attest them, and push the resulting commits.
