# Contributing

## Setup

```sh
git clone https://github.com/REPLACE_ME_GITHUB_OWNER/REPLACE_ME
cd REPLACE_ME
```

### With Nix (recommended)

```sh
nix develop
```

This gives you the full toolchain: Rust, clippy, rustfmt, rust-analyzer, just, taplo, typos, cargo-deny, cargo-nextest, maturin, uv.

### Without Nix

Install manually:

- [Rust](https://rustup.rs/) (stable toolchain with `clippy`, `rustfmt`, `rust-src`, `rust-analyzer`)
- [just](https://github.com/casey/just) — command runner
- [taplo](https://taplo.tamasfe.dev/) — TOML linter/formatter
- [typos](https://github.com/crate-ci/typos) — spell checker
- [cargo-deny](https://embarkstudios.github.io/cargo-deny/) — dependency linter (licenses, advisories, bans)
- [cargo-nextest](https://nexte.st/) — test runner (optional)
- [maturin](https://www.maturin.rs/) — Python wheel builder (for uvx distribution)
- [uv](https://docs.astral.sh/uv/) — Python package manager

## Development

```sh
just check   # clippy + test + fmt + taplo + typos
just fmt     # auto-format Rust and TOML
just test    # run tests
just lint    # clippy only
just deny    # dependency audit (licenses, advisories)
```

## Pull Requests

- Fork the repo and create a branch from `main`
- Run `just check` before pushing
- Keep PRs focused — one feature or fix per PR
