---
name: slackdump
description: Archive, dump, and query Slack workspace data using slackdump. Use when exporting Slack channels/threads, setting up a local Slack archive, querying archived messages via SQLite, or connecting archived data to AI agents via the MCP server.
triggers:
  - "slackdump"
  - "archive slack"
  - "dump slack channel"
  - "export slack"
  - "slack mcp"
  - "query slack archive"
---

# Slackdump

Archive, dump, and query Slack workspaces. Stores everything in SQLite. Exposes data to AI agents via MCP.

**Official docs**: https://github.com/rusq/slackdump

---

## Installation

```bash
brew install slackdump       # recommended
slackdump --version          # verify
```

Manual (macOS Apple Silicon):
```bash
curl -L -o slackdump https://github.com/rusq/slackdump/releases/latest/download/slackdump_darwin_arm64
chmod +x slackdump && sudo mv slackdump /usr/local/bin/
```

---

## Workspace Setup

Credentials stored in `~/Library/Caches/slackdump/`.

```bash
slackdump workspace new <workspace-name>           # OAuth via browser (recommended)
slackdump workspace new https://<workspace>.slack.com
slackdump workspace list                            # list saved workspaces
slackdump workspace select <name>                   # switch active workspace
slackdump workspace del <name>                      # remove credentials
```

**With an existing token:**
```bash
slackdump -token xoxb-your-token workspace new <name>
```

**With cookie-based auth** (browser → DevTools → Application → Cookies → `d` value):
```bash
slackdump -cookie <d-cookie-value> workspace new <name>
```

**From a `.env` file** (`SLACK_TOKEN=xoxb-...`):
```bash
slackdump workspace import .env
```

---

## Explore

```bash
slackdump list channels
slackdump list channels -chan-types im               # direct messages
slackdump list channels -chan-types mpim             # group DMs
slackdump list channels -chan-types public_channel
slackdump list channels -chan-types private_channel
slackdump list users
```

---

## Archive (Full Workspace → SQLite)

Creates `slackdump_YYYYMMDD_HHMMSS/` containing:
- `slackdump.sqlite` — all messages
- `__uploads/` — file attachments (with `-files`)
- `__avatars/` — user avatars (with `-avatars`)

```bash
slackdump archive                                            # all accessible channels
slackdump archive -o my-archive.zip                          # to ZIP
slackdump archive -member-only                               # only channels you're in
slackdump archive <CHANNEL_ID>                               # specific channel
slackdump archive -channel-users <DM_CHANNEL_ID>             # archive DM + include user/member metadata
slackdump archive -files -avatars                            # include files & avatars
slackdump archive -time-from 2024-01-01T00:00:00
slackdump archive -time-from 2024-01-01T00:00:00 -time-to 2024-12-31T23:59:59
slackdump resume ./slackdump_YYYYMMDD_HHMMSS                 # resume interrupted archive
```

---

## Dump (Specific Conversations → JSON)

```bash
slackdump dump <CHANNEL_ID>
slackdump dump <DM_USER_ID>
slackdump dump -o ./output <CHANNEL_ID>
slackdump dump -time-from 2024-01-01T00:00:00 <CHANNEL_ID>
slackdump dump @conversations.txt                            # batch (one ID/URL per line)
```

**Dump a specific thread:**
```bash
# By URL:
slackdump dump https://<workspace>.slack.com/archives/<CHANNEL_ID>/p<TIMESTAMP>

# By colon notation:
slackdump dump <CHANNEL_ID>:<TIMESTAMP>
```

Thread timestamp: URL `p1234567890123456` → `1234567890.123456` (insert decimal after 10th digit).

---

## Query the Archive

```bash
sqlite3 ./slackdump_YYYYMMDD_HHMMSS/slackdump.sqlite
```

```sql
.tables

SELECT COUNT(*) FROM MESSAGE WHERE CHANNEL_ID = '<CHANNEL_ID>';

SELECT TEXT, USER_ID, TS FROM MESSAGE
WHERE CHANNEL_ID = '<CHANNEL_ID>'
ORDER BY TS DESC LIMIT 10;

SELECT TEXT, CHANNEL_ID, TS FROM MESSAGE
WHERE TEXT LIKE '%keyword%';
```

**Browse via web UI:**
```bash
slackdump view ./slackdump_YYYYMMDD_HHMMSS
```

---

## Convert Archive

```bash
slackdump convert -f dump ./archive_dir          # → JSONL
slackdump convert -f slack-export ./archive_dir  # → Slack Export format
slackdump convert -f chunk ./archive_dir         # → chunk files
```

---

## MCP Server

Exposes archived data to AI agents.

```bash
# Start (HTTP transport — recommended)
slackdump mcp -transport http ./archive/slackdump.sqlite

# Custom port
slackdump mcp -transport http -listen 127.0.0.1:9000 ./archive/slackdump.sqlite

# Without archive (agent loads via load_source)
slackdump mcp -transport http
```

Default: `http://127.0.0.1:8483/mcp`

### OpenCode (`~/.config/opencode/config.json`)

```json
{
  "mcp": {
    "slackdump": {
      "type": "remote",
      "url": "http://localhost:8483/mcp"
    }
  }
}
```

### Claude Desktop (`~/Library/Application Support/Claude/claude_desktop_config.json`)

```json
{
  "mcpServers": {
    "slackdump": {
      "command": "slackdump",
      "args": ["mcp", "/path/to/archive/slackdump.sqlite"]
    }
  }
}
```

### VS Code Copilot (`.vscode/mcp.json`)

```json
{
  "servers": {
    "slackdump": {
      "type": "stdio",
      "command": "slackdump",
      "args": ["mcp", "/path/to/archive/slackdump.sqlite"]
    }
  }
}
```

### Available MCP Tools

| Tool | Description |
|------|-------------|
| `load_source` | Open/switch archive at runtime |
| `list_channels` | List all channels |
| `get_channel` | Get channel details by ID |
| `list_users` | List all users |
| `get_messages` | Read messages (paginated) |
| `get_thread` | Read thread replies |
| `get_workspace_info` | Workspace metadata |

---

## File Locations

| Item | Location |
|------|----------|
| Credentials | `~/Library/Caches/slackdump/` |
| Archive output | `./slackdump_YYYYMMDD_HHMMSS/` |
| Archive DB | `./slackdump_YYYYMMDD_HHMMSS/slackdump.sqlite` |

---

## Troubleshooting

**No workspace selected:**
```bash
slackdump workspace list
slackdump workspace select <name>
```

**Token expired:**
```bash
slackdump workspace new <name>
```

**Rate limiting:**
```bash
slackdump config new
slackdump archive --api-config custom-config.json
```

**Resume interrupted archive:**
```bash
slackdump resume ./slackdump_YYYYMMDD_HHMMSS
```

**Corrupted credentials:**
```bash
slackdump workspace del <name>
slackdump workspace new <name>
# Or disable encryption:
slackdump -no-encryption workspace new <name>
```
