# Claude Skills Collection

## Introduction

This repository contains a curated collection of professional software development skills for Claude Code, designed to enhance the AI's capabilities in software engineering tasks. Each skill follows the official Claude Skills specification and provides systematic approaches to common development challenges.

The skills are optimized for:

- Concise, actionable guidance
- Systematic workflows rather than general knowledge
- Real-world implementation patterns
- Integration with Claude Code's capabilities
- Professional software engineering practices

## Usage

These skills work with Claude Code to enhance software development workflows. The skills automatically activate when:

- The description in the YAML frontmatter matches the user's request
- The user invokes specific commands related to the skill's domain
- Used as part of larger workflows with other skills

**Example**: When you request "Review this code", the `code-quality-review` skill activates and performs a systematic code review.

## Installation

To use these skills with Claude Code:

1. **Clone the repository**:

```bash
# Create skills directory if needed
mkdir -p ~/.claude/skills

# Clone the skills
git clone https://github.com/pixincreate/claude-skills.git ~/.claude/skills
```

2. **Verify installation**:

```bash
cd ~/.claude/skills
tree
```

The directory structure should look like:

```
~/.claude/skills/
├── architecture
│   └── SKILL.md
├── collaboration
│   └── SKILL.md
├── debugging
│   └── SKILL.md
├── ghostty
│   └── SKILL.md
├── misc
│   └── SKILL.md
├── problem-solving
│   └── SKILL.md
├── research
│   └── SKILL.md
├── starship
│   └── SKILL.md
├── testing
│   └── SKILL.md
├── tmux
│   └── SKILL.md
├── web-browser
│   └── SKILL.md
└── zed
    └── SKILL.md
```

3. **Restart Claude Code** to load the new skills

## Skills

### Debugging

Systematic workflow for identifying, isolating, and fixing bugs. Focuses on methodical investigation over random trial-and-error.

**When to use**: Troubleshooting errors, unexpected behavior, or performance issues.

### Architecture

Software architecture and system design guidance applying SOLID principles and established patterns.

**When to use**: Designing new systems, evaluating architecture, or making technology decisions.

### Research

Systematic technical research and codebase exploration with emphasis on thorough investigation.

**When to use**: Investigating unfamiliar codebases or gathering information for technical decisions.

### Testing

Writing effective tests following the testing pyramid and best practices.

**When to use**: Writing tests, implementing TDD, or ensuring code quality.

### Problem Solving

Systematic approach for complex technical challenges, emphasizing understanding before solving.

**When to use**: Faced with algorithmic problems, performance optimization, or design decisions.

### Misc

Essential development practices including code review, refactoring, and documentation.

**When to use**: Reviewing code, improving quality, or following development standards.

### Collaboration

Effective team collaboration practices emphasizing clear communication.

**When to use**: Working with teams, conducting code reviews, or providing feedback.

### Web Browser

Automated web browsing workflow for unreachable URLs or paywalled content using textise dot iitty.

**When to use**: Accessing blocked content, reading articles behind paywalls, or when direct browser access is not possible.

### Tmux

Terminal multiplexer for persistent sessions and multiple terminal management.

**When to use**: Managing multiple terminals, keeping sessions alive, remote server work, or organizing terminal workspace.

### Starship

Customizable shell prompt for showing relevant context and information.

**When to use**: Setting up shell prompt, customizing prompt appearance, or displaying environment context in terminal.

### Zed

Modern, keyboard-driven code editor with excellent performance and features.

**When to use**: Code editing, project management, multi-file workflows, or when seeking a fast editor experience.

### Ghostty

Modern terminal emulator with GPU acceleration and extensive customization.

**When to use**: Terminal configuration, customizing terminal behavior, or optimizing terminal workflow.

## Contribution

Contributions are welcome! Please:

1. Fork the repository
2. Create a branch for your changes
3. Submit a pull request with clear description

Focus on concise, actionable improvements to existing skills.

## License

This work is licensed under the [Creative Commons Zero v1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/).

## Disclaimer

THE SKILLS PROVIDED IN THIS REPOSITORY ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SKILLS.

THE AUTHOR IS NOT RESPONSIBLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES ARISING FROM THE USE OF THESE SKILLS, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
