# Contributing

## Setup

```sh
git clone https://github.com/REPLACE_ME_GITHUB_OWNER/REPLACE_ME
cd REPLACE_ME
nix develop  # or install Rust toolchain manually
cargo build
```

## Development

```sh
cargo clippy --workspace -- -D warnings
cargo test --workspace
cargo fmt --all -- --check
```

## Pull Requests

- Fork the repo and create a branch from `main`
- Ensure `cargo clippy`, `cargo test`, and `cargo fmt` pass
- Keep PRs focused — one feature or fix per PR
