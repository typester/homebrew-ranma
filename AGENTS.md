# AGENTS.md

## Project

Homebrew formula (not cask) for [ranma](https://github.com/typester/ranma), a programmable macOS menu bar overlay that fills the unused center space with custom widgets.

## Repository Structure

```
homebrew-ranma/
├── Formula/
│   └── ranma.rb           # Homebrew Formula definition
├── .github/
│   └── workflows/
│       └── update-formula.yml  # CI for automated formula updates
├── README.md
└── AGENTS.md              # This file
```

## Rules

- All deliverables must be written in English unless explicitly instructed otherwise.
- Keep code comments minimal — only where logic is non-obvious. Never add comments that merely restate the code that follows.
- Do not start work autonomously. Always wait for explicit instructions from the user before proceeding.
- Update this file (AGENTS.md) whenever there is information that should be remembered across sessions.
- Version control uses jj (Jujutsu), not git. Write operations (describe, new, commit, push, etc.) should be left to the user unless explicitly instructed otherwise.

## Formula Update Procedure

When a new ranma version is released:

1. Get the new version tag from GitHub Releases
2. Calculate SHA256 for both architectures:
   ```sh
   curl -sL "https://github.com/typester/ranma/releases/download/v{VERSION}/ranma-arm64-{VERSION}.tar.gz" | shasum -a 256
   curl -sL "https://github.com/typester/ranma/releases/download/v{VERSION}/ranma-x86_64-{VERSION}.tar.gz" | shasum -a 256
   ```
3. Update `Formula/ranma.rb`:
   - Update `version` field
   - Update `sha256` in `on_arm` and `on_intel` blocks
4. Commit with message: `ranma {VERSION}`

## URL Format

- Tag: `v{VERSION}` (e.g., `v0.1.3`)
- arm64: `https://github.com/typester/ranma/releases/download/v{VERSION}/ranma-arm64-{VERSION}.tar.gz`
- x86_64: `https://github.com/typester/ranma/releases/download/v{VERSION}/ranma-x86_64-{VERSION}.tar.gz`

## Release Tarball Contents

Each tarball contains two binaries:
- `ranma` — CLI controller
- `ranma-server` — macOS menu bar application

## Testing

```sh
brew tap typester/ranma /path/to/homebrew-ranma
brew install ranma
ranma --help
brew uninstall ranma
brew untap typester/ranma
```

## CI Integration

The `update-formula.yml` workflow receives `repository_dispatch` events from the upstream ranma repo to automatically update the formula on new releases. It also supports `workflow_dispatch` for manual updates.

The upstream ranma repo needs an `update-homebrew` job in its `release.yml` to dispatch events to this repo. Add the following job after the `build` job:

```yaml
  update-homebrew:
    name: Update Homebrew formula
    needs: [detect-release, build]
    runs-on: ubuntu-latest
    if: needs.detect-release.outputs.should_build == 'true'
    steps:
      - name: Extract version from tag
        id: version
        run: |
          TAG="${{ needs.detect-release.outputs.tag }}"
          VERSION="${TAG#v}"
          echo "version=${VERSION}" >> "$GITHUB_OUTPUT"

      - name: Download release assets and calculate SHA256
        id: sha256
        run: |
          VERSION="${{ steps.version.outputs.version }}"
          TAG="${{ needs.detect-release.outputs.tag }}"

          curl -sL "https://github.com/${{ github.repository }}/releases/download/${TAG}/ranma-arm64-${VERSION}.tar.gz" -o arm64.tar.gz
          ARM64_SHA=$(shasum -a 256 arm64.tar.gz | cut -d ' ' -f 1)
          echo "arm64_sha256=${ARM64_SHA}" >> "$GITHUB_OUTPUT"

          curl -sL "https://github.com/${{ github.repository }}/releases/download/${TAG}/ranma-x86_64-${VERSION}.tar.gz" -o x86_64.tar.gz
          X86_64_SHA=$(shasum -a 256 x86_64.tar.gz | cut -d ' ' -f 1)
          echo "x86_64_sha256=${X86_64_SHA}" >> "$GITHUB_OUTPUT"

      - name: Dispatch update to homebrew-ranma
        env:
          GH_TOKEN: ${{ secrets.HOMEBREW_DISPATCH_TOKEN }}
        run: |
          gh api repos/typester/homebrew-ranma/dispatches \
            -f event_type="update-formula" \
            -f "client_payload[version]=${{ steps.version.outputs.version }}" \
            -f "client_payload[arm64_sha256]=${{ steps.sha256.outputs.arm64_sha256 }}" \
            -f "client_payload[x86_64_sha256]=${{ steps.sha256.outputs.x86_64_sha256 }}"
```

This requires a `HOMEBREW_DISPATCH_TOKEN` secret in the ranma repo with permission to dispatch events to this repo.

## Notes

- ranma uses Homebrew **Formula** (not Cask) because it distributes plain CLI binaries, not a .app bundle.
- The `ranma-server` binary is a native macOS app but is invoked from the command line, not installed as a .app.
