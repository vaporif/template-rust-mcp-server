use rmcp::handler::server::tool::ToolRouter;
use rmcp::handler::server::wrapper::Parameters;
use rmcp::model::{CallToolResult, Content, Implementation, ServerCapabilities, ServerInfo};
use rmcp::{ErrorData as McpError, ServerHandler, tool, tool_handler, tool_router};
use schemars::JsonSchema;
use serde::Deserialize;

use crate::errors::Error;

fn to_json_result(body: &impl serde::Serialize) -> Result<CallToolResult, McpError> {
    let json = serde_json::to_string_pretty(body).map_err(Error::from)?;
    Ok(CallToolResult::success(vec![Content::text(json)]))
}

#[derive(Clone)]
pub struct McpServer {
    tool_router: ToolRouter<Self>,
}

impl Default for McpServer {
    fn default() -> Self {
        Self {
            tool_router: Self::tool_router(),
        }
    }
}

impl McpServer {
    #[must_use]
    pub fn new() -> Self {
        Self::default()
    }
}

#[derive(Deserialize, JsonSchema)]
pub struct HelloParams {
    /// Name to greet
    pub name: String,
}

#[tool_router]
impl McpServer {
    #[tool(
        name = "hello",
        description = "Say hello to someone. This is a sample tool — replace it with your own."
    )]
    async fn hello(
        &self,
        Parameters(params): Parameters<HelloParams>,
    ) -> Result<CallToolResult, McpError> {
        tracing::debug!(name = %params.name, "hello");
        to_json_result(&serde_json::json!({
            "message": format!("Hello, {}!", params.name),
        }))
    }
}

#[tool_handler]
impl ServerHandler for McpServer {
    fn get_info(&self) -> ServerInfo {
        ServerInfo::new(ServerCapabilities::builder().enable_tools().build())
            .with_server_info(Implementation::new("REPLACE_ME", env!("CARGO_PKG_VERSION")))
    }
}
