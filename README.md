# homebrew-ranma

Homebrew tap for [ranma](https://github.com/typester/ranma), a programmable macOS menu bar overlay.

## Installation

```sh
brew tap typester/ranma
brew install ranma
```

## Usage

```sh
ranma-server start --init /path/to/init-script
ranma add <name> --label "text" --icon "sf.symbol"
```

See [ranma documentation](https://github.com/typester/ranma) for details.

## Uninstall

```sh
brew uninstall ranma
brew untap typester/ranma
```
