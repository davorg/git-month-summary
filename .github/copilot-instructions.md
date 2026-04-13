# Copilot Instructions for git-month-summary

## What this repository is

`git-month-summary` is a single-file Perl CLI tool (`bin/git-month-summary`) that:

1. Scans a root directory tree for Git repositories.
2. Runs `git log` for a given month/year across each repository found.
3. Sends the log output to the OpenAI Chat Completions API.
4. Prints a concise, bullet-point Markdown summary of each repository's activity for that month to stdout.

The `docs/` directory contains sample output — `docs/index.md` links to monthly sub-directories (e.g. `docs/2026-03/index.md`) that hold real generated summaries. These are useful as reference examples when modifying the prompt or output format.

## Language and runtime

- **Perl 5.40+** — the shebang is `#!/usr/bin/env -S perl -CS` and the script begins with `use v5.40;`.
- Modern Perl features are used throughout: `use utf8`, named subroutine signatures, `say`, etc.
- Do **not** use Perl features that require a version newer than 5.40.

## Dependencies

Dependencies are declared in `cpanfile` and installed with `cpanm`:

```
requires 'Getopt::Long';      # core
requires 'File::Find';        # core
requires 'File::Spec';        # core
requires 'Cwd';               # core
requires 'Git::Repository';          # CPAN
requires 'OpenAPI::Client::OpenAI';  # CPAN
```

The non-core dependencies are `Git::Repository`, which provides an object-oriented interface to Git repositories, and `OpenAPI::Client::OpenAI`, which wraps the OpenAI REST API.

## Environment variables

- `OPENAI_API_KEY` — **required** at runtime. The script dies immediately if this is not set. For CI or agent use, configure this as a secret in the `copilot` GitHub Actions environment.

## CLI usage

```
git-month-summary --month <1-12> --year <YYYY> [--dir <PATH>] [--model <MODEL>] [--max-input-len <N>]
```

| Option | Default | Description |
|---|---|---|
| `--month` | *(required)* | Month number 1–12 |
| `--year` | *(required)* | Four-digit year |
| `--dir` | `$HOME/git` | Root directory to search for Git repos |
| `--model` | `gpt-5.4-mini` | OpenAI model name |
| `--max-input-len` | `30000` | Max characters of `git log` sent to the model |

Output is Markdown to stdout. Each repository gets a `## repo-name` heading followed by bullet points and a `---` separator.

## Code layout

```
bin/git-month-summary   # The entire tool — one Perl script, ~290 lines
cpanfile                # CPAN dependency declarations
docs/                   # Sample output (Markdown)
  index.md              # Top-level index linking to monthly subdirectories
  2026-03/index.md      # Example output for March 2026
.github/
  workflows/
    copilot-setup-steps.yml  # Pre-installs Perl 5.40 + cpan deps for agent use
```

There is currently **no test suite** and no linter configuration. When adding tests, place them in a `t/` directory using standard Perl test conventions (`Test::More` or `Test2::V0`).

## Setting up the development environment

The `copilot-setup-steps.yml` workflow handles environment setup automatically. It:

1. Checks out the repository.
2. Installs Perl 5.40 via `shogo82148/actions-setup-perl@v1`.
3. Runs `cpanm --installdeps --with-develop --notest .` to install all `cpanfile` dependencies.

To set up locally:

```sh
cpanm --installdeps --with-develop --notest .
```

## Key implementation details

- **Repository discovery** (`find_git_repos`): Uses `File::Find` to walk the root directory looking for `.git` subdirectories. Prunes descent once a repo is found to avoid walking into nested repos.
- **Git log format** (`git_month_log`): Runs `git log --no-merges --since=... --until=... --stat=120,80` with a custom `--pretty=format` that includes commit hash, author, date, subject and body. Merge commits are excluded.
- **Truncation** (`truncate_text`): Logs exceeding `--max-input-len` characters are silently truncated before being sent to the model. A notice is appended to the truncated text.
- **Prompt** (`summarise_repo_changes`): Instructs the model to write in British English, produce 2–5 bullet points, focus on what changed (not commit mechanics), and not to invent anything unsupported by the log.
- **External command execution** (`_git_month_log`, `_repo_has_commits`): Uses `Git::Repository` to interact with Git repositories. `Git::Repository->new(work_tree => $path)` creates a repository object and `$repo->run(@cmd)` runs a git command returning the output as a string (throwing a `Git::Repository::Exception` on non-zero exit, caught via `try`/`catch`).

## Errors and known workarounds

- If `OPENAI_API_KEY` is not set, the script dies with a clear message. Always set this before running.
- Repositories with no commits (empty repos) are silently skipped via `repo_has_commits`.
- If `git log` returns no output for the requested period, that repository is skipped.
- If the OpenAI API call fails (network error, quota, bad key), a warning is printed to stderr and that repository is skipped; processing continues for remaining repos.
- The default `--dir` of `$HOME/git` will not exist in most CI/agent environments — always pass `--dir` explicitly when running outside a developer's personal machine.
