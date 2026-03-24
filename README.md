# Memory Nexus for Claude Code

Persistent knowledge layer for Claude Code. Store context, retrieve briefings, and maintain continuity across sessions.

[![Memory Nexus MCP server](https://glama.ai/mcp/servers/MemoryNexus/memory-nexus-plugins/badges/card.svg)](https://glama.ai/mcp/servers/MemoryNexus/memory-nexus-plugins)

## Installation

1. Create an account at [memory-nexus.org](https://memory-nexus.org)
2. Generate an API key from your account dashboard
3. Set your API key as an environment variable:
   ```bash
   export MEMORY_NEXUS_API_KEY="your-api-key-here"
   ```
4. Add this plugin to Claude Code

## Features

- **Automatic Project Detection**: Recognizes your git project and loads relevant context
- **Session Briefings**: Get structured directives, objectives, and knowledge at session start
- **Semantic Search**: Find memories by meaning, not keywords
- **Continuity**: Switch between Claude, Codex, or any other platform while maintaining context
- **Multi-tier Subscriptions**: Solo ($7/month), Crew ($49/month), Fleet ($199/month)

## Available Commands

- `/memory-nexus status` — Check account status and quota
- `/memory-nexus search [query]` — Search stored memories
- `/memory-nexus forget [id]` — Delete a memory
- `/memory-nexus briefing` — Get project briefing
- `/memory-nexus account` — Manage account and billing

## How It Works

When you start a new Claude Code session:

1. **Automatic Project Detection**: The plugin detects your git repository and generates a unique project hash
2. **Session Start Hook**: Your project's stored context is retrieved from Memory Nexus
3. **Briefing Injection**: Directives (rules), objectives (intent), and knowledge (context) are automatically injected as additional context
4. **Seamless Continuity**: You can switch to another Claude instance or Codex, use the same API key, and get a coherent handoff without manual recap

## Pricing

| Tier | Cost | Features |
|------|------|----------|
| Solo | $7/month | 50 memories, 10 briefings/month, personal projects |
| Crew | $49/month | 500 memories, 100 briefings/month, team projects |
| Fleet | $199/month | 5000 memories, 1000 briefings/month, enterprise |

No free tier. No free trial.

## Configuration

Set these environment variables:

- `MEMORY_NEXUS_API_KEY` (required) — Your API key from the dashboard
- `MEMORY_NEXUS_API_BASE` (optional) — API endpoint, defaults to `https://api.memory-nexus.org`

## Architecture

This plugin includes:

- **SessionStart Hook** (`hooks/session_start_hook.sh`) — Detects project, calls `session_start` endpoint, injects briefing
- **MCP Server Bridge** (`.mcp.json`) — Connects to Memory Nexus Python MCP server for tool calls
- **Skill Definition** (`skills/memory-nexus/SKILL.md`) — User-facing commands and documentation
- **Plugin Metadata** (`.claude-plugin/plugin.json`) — Plugin registration with Claude Code

## Troubleshooting

**"No API key found"**
- Set `MEMORY_NEXUS_API_KEY` environment variable and restart Claude Code

**"Project hash not detected"**
- Make sure you're working in a git repository
- The hook will silently skip if not in a git project

**"Briefing is empty"**
- This is the first session for your project. Start storing memories with `/memory-nexus` commands.
- The briefing will grow as you add context.

## Learn More

Visit [memory-nexus.org](https://memory-nexus.org) for the full documentation.