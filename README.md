# codex-consult

A [Claude Code skill](https://docs.anthropic.com/en/docs/claude-code/skills) that lets Claude ask OpenAI's Codex CLI for a second opinion.

When you're stuck on a bug or want a fresh perspective, Claude can consult Codex (GPT-5.3-codex, xhigh reasoning) to diagnose the problem — without modifying any files.

## Install

```bash
npx skills add EndlessHoper/codex-consult
```

Or manually:

```bash
git clone https://github.com/EndlessHoper/codex-consult ~/.claude/skills/codex-consult
```

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- [Codex CLI](https://github.com/openai/codex) installed and authenticated (`codex login`)

## Usage

**Let Claude invoke it automatically** by saying things like:
- "Ask codex about this bug"
- "Get a second opinion on this"
- "What does codex think?"

**Or invoke it directly:**
```
/codex-consult why is the widget not rendering correctly?
```

## How it works

Claude gathers context about the problem (code snippets, errors, what's been tried), then runs:

```bash
codex exec \
  -m gpt-5.3-codex \
  -c 'model_reasoning_effort="xhigh"' \
  -s read-only \
  -C /path/to/project \
  "diagnostic prompt"
```

Key constraints:
- **Read-only sandbox** (`-s read-only`) — Codex can read your code but never writes or executes
- **Diagnosis only** — the prompt explicitly instructs Codex to analyze, not fix
- **Claude decides** — Codex's response is input for Claude to evaluate, not instructions to follow blindly

## Configuration

The helper script defaults to:
- **Model**: `gpt-5.3-codex`
- **Reasoning effort**: `xhigh`
- **Binary**: `codex` (must be on PATH, or override with `CODEX_BIN` env var)

Edit `scripts/codex_consult.sh` to change defaults.

## License

MIT
