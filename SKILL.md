---
name: codex-consult
description: >
  Ask OpenAI Codex CLI (GPT-5.3, xhigh reasoning) for a second opinion on bugs, architecture
  questions, or tricky problems. Codex runs in read-only mode to diagnose and suggest solutions
  without modifying any files. Use when you want a fresh perspective from a different AI model,
  when stuck on a difficult bug, when you need to validate your diagnosis, or when the user
  asks to "ask codex", "consult codex", "get a second opinion", or "what does codex think".
---

# Codex Consult

Get a diagnostic second opinion from OpenAI Codex CLI (GPT-5.3-codex, xhigh reasoning effort).
Codex runs in **read-only sandbox** — it reads code and analyzes but never writes or executes.

## When to Use

- Stuck on a bug and want a fresh perspective
- Need to validate a diagnosis before implementing a fix
- Architecture question where another viewpoint helps
- User explicitly asks to consult Codex

## How to Consult Codex

### 1. Prepare Context

Gather the relevant context before calling Codex. Good context includes:
- The specific problem or question
- Relevant file paths and key code snippets
- Error messages or unexpected behavior
- What has already been tried

### 2. Craft the Prompt

Write a focused diagnostic prompt. The prompt must instruct Codex to **only diagnose, not fix**.

Template:

```
You are being consulted for a second opinion. DIAGNOSE ONLY — do not write or modify any files.

## Problem
[Clear description of the issue]

## Relevant Code
[Key snippets or file paths for Codex to read]

## What's Been Tried
[Previous attempts, if any]

## Question
[Specific question — e.g. "What's causing X?" or "Which approach would you recommend for Y?"]

Provide your analysis and suggested approach. Do not write code fixes — just explain what you'd do and why.
```

### 3. Run via Script

Use the bundled helper script:

```bash
scripts/codex_consult.sh -C /path/to/project "Your diagnostic prompt here"
```

Flags:
- `-C <dir>` — Set Codex's working directory (so it can read project files)
- `-i <image>` — Attach a screenshot (repeatable)

### 4. Run via Direct Command

Or call codex exec directly:

```bash
codex exec \
  -m gpt-5.3-codex \
  -c 'model_reasoning_effort="xhigh"' \
  -s read-only \
  -C /path/to/project \
  "Your diagnostic prompt here"
```

### 5. Interpret the Response

Codex's response arrives on stdout. Read it, evaluate the diagnosis, and decide whether to adopt
the suggestion. You are the final decision-maker — Codex provides input, not instructions.

## Important Constraints

- **Read-only**: Always use `-s read-only`. Codex must never modify the codebase.
- **Diagnosis only**: The prompt must explicitly say "diagnose only, do not fix".
- **You decide**: Codex's suggestion is input. Evaluate it critically before acting.
- **Token cost**: Each consult is an API call to OpenAI. Use when genuinely helpful, not routinely.
- **Binary path**: `codex` must be on PATH (override with `CODEX_BIN` env var).
