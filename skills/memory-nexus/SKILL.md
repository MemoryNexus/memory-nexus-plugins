# Memory Nexus

Store context, retrieve briefings, and maintain continuity across sessions with Memory Nexus.

## Commands

### /memory-nexus status
Check your Memory Nexus account status, including active tier and remaining quota.

```
/memory-nexus status
```

### /memory-nexus search [query]
Search your stored memories by semantic meaning.

```
/memory-nexus search "how to set up authentication"
```

### /memory-nexus forget [id]
Delete a stored memory by ID.

```
/memory-nexus forget memory-12345
```

### /memory-nexus briefing
Get a structured briefing including directives, objectives, and contextual knowledge for your current project.

```
/memory-nexus briefing
```

### /memory-nexus account
Manage your account, view tier, and billing information.

```
/memory-nexus account
```

## How It Works

When you start a new Claude Code session:
1. **Automatic Detection**: The plugin detects your git project and generates a unique hash
2. **Session Start**: Memory Nexus retrieves your project's knowledge and context
3. **Briefing Injection**: Structured directives, objectives, and knowledge are injected as context
4. **Seamless Continuity**: Switch between Claude, Codex, or any other platform using the same API key

## Pricing

| Tier | Cost | Monthly Quota |
|------|------|---------------|
| Solo | $7/month | 50 memories, 10 briefings |
| Crew | $49/month | 500 memories, 100 briefings |
| Fleet | $199/month | 5000 memories, 1000 briefings |

No free tier. No free trial.

## Getting Started

1. Create an account at [memory-nexus.org](https://memory-nexus.org)
2. Generate an API key from your account dashboard
3. Set `MEMORY_NEXUS_API_KEY` environment variable
4. Optionally set `MEMORY_NEXUS_API_BASE` (defaults to `https://api.memory-nexus.org`)
5. Start a new Claude Code session — Memory Nexus will automatically load your project context
