# Rust MCP Server Template

A template for building [MCP](https://modelcontextprotocol.io/) servers in Rust.

Single binary, zero runtime dependencies, stdio + HTTP transports out of the box.

## What's Included

- **[rmcp](https://github.com/anthropics/rust-mcp-sdk)** — official Rust MCP SDK with `#[tool]` macro for tool definitions
- **Dual transport** — stdio for local clients, streamable HTTP for hosted deployments
- **Distribution** — uvx (via maturin), rvx, cargo install, Nix flake, Docker
- **CI/CD** — clippy, fmt, cross-compilation (Linux/macOS/Windows), Nix check, cargo-deny, gitleaks
- **Release** — tag-triggered GitHub releases with binaries, crates.io, and PyPI publishing

## Quick Start

1. Click **"Use this template"** on GitHub (or clone the repo)

2. Run the setup script:

```sh
./setup.sh my-mcp-server your-github-username "My awesome MCP server"
```

3. Build and run:

```sh
cargo build
cargo run
```

4. Delete the setup script:

```sh
rm setup.sh
```

## Project Structure

```
src/
├── main.rs      # Entry point, transport setup
├── lib.rs       # Module declarations
├── server.rs    # MCP server, tool definitions
├── config.rs    # CLI args (clap)
└── errors.rs    # Error types
```

## Adding Tools

Edit `src/server.rs`:

```rust
#[derive(Deserialize, JsonSchema)]
pub struct MyParams {
    /// Description shown to the AI model
    pub query: String,
}

#[tool_router]
impl McpServer {
    #[tool(
        name = "my_tool",
        description = "What this tool does"
    )]
    async fn my_tool(
        &self,
        Parameters(params): Parameters<MyParams>,
    ) -> Result<CallToolResult, McpError> {
        // your logic here
        to_json_result(&serde_json::json!({ "result": params.query }))
    }
}
```

## Usage

### Claude Desktop / Claude Code

**With [uvx](https://docs.astral.sh/uv/):**

```json
{
  "mcpServers": {
    "REPLACE_ME": {
      "command": "uvx",
      "args": ["REPLACE_ME"]
    }
  }
}
```

**With [rvx](https://github.com/vaporif/rvx):**

```json
{
  "mcpServers": {
    "REPLACE_ME": {
      "command": "rvx",
      "args": ["REPLACE_ME"]
    }
  }
}
```

<details>
<summary>Other installation methods</summary>

**With Nix:**

```sh
nix run github:REPLACE_ME_GITHUB_OWNER/REPLACE_ME
```

**With cargo:**

```sh
cargo install REPLACE_ME
```

**From releases:**

Download a prebuilt binary from [GitHub Releases](https://github.com/REPLACE_ME_GITHUB_OWNER/REPLACE_ME/releases).

**With Docker:**

```sh
docker run -p 3000:3000 REPLACE_ME
```

</details>

### HTTP Transport

```sh
REPLACE_ME --transport streamable-http --port 3000
```

The server listens on `http://127.0.0.1:3000/mcp`.

### Debugging

```sh
RUST_LOG=debug REPLACE_ME
```

## Development

```sh
nix develop  # or install Rust toolchain manually

just check   # clippy + test + fmt + taplo + typos
just fmt     # auto-format
just deny    # dependency audit
```

## License

MIT
