# Module: Linux + CLI Fluency

**Phase:** 1  
**Slug:** `cli-linux`  
**Status:** not started  

---

## What it is / how to think about it

The terminal is the universal control surface for every tool you'll use: git, docker, cloud CLIs, package managers, scripts, servers. Think of it as "text that runs programs." You don't need to memorize everything — you need to know what's possible and how to look things up fast.

**Mental model:** The shell is a loop — read a command, find the program, run it, print output, repeat. Everything is a file or a stream of text.

---

## Prerequisites
- None — this is the starting point.

---

## Best resources

**Primary:**
1. [The Missing Semester of Your CS Education](https://missing.csail.mit.edu/) (MIT, free) — lectures 1–5 cover shell, scripting, environment, and tools. Start here.
2. [Linux Command Line and Shell Scripting Bible](https://www.wiley.com/en-us/Linux+Command+Line+and+Shell+Scripting+Bible%2C+4th+Edition-p-9781119826330) — chapters 1–10 as reference (skip if missing semester is enough)

**Supporting:**
- [ExplainShell](https://explainshell.com/) — paste any command to understand each flag
- [tldr pages](https://tldr.sh/) — human-friendly man pages (`brew install tldr`)
- [Bash cheat sheet](https://devhints.io/bash) — devhints.io reference

**YouTube:**
- [The Missing Semester – Shell Tools and Scripting](https://www.youtube.com/watch?v=e8BO_dYxk5c) (MIT lecture, 50 min)
- [Shell scripting crash course – Traversy Media](https://www.youtube.com/watch?v=v-F3YLd6oMw) (40 min)

**Why these:** MIT Missing Semester is the canonical modern intro — it covers the parts CS courses skip. ExplainShell is invaluable when you hit a command you don't understand.

---

## Core concepts to cover

### Navigation + file system
```
pwd, ls, ls -la, cd, mkdir -p, touch, rm, rm -rf, cp, mv
find . -name "*.ts"
tree (brew install tree)
cat, less, head, tail
```

### Text manipulation
```
grep, grep -r, rg (ripgrep — faster grep)
pipe |, redirect >, >>
wc -l
sort, uniq, cut
jq (for JSON)
```

### Environment + shell config
```
echo $VAR
export VAR=value
.zshrc / .bashrc — what they do, when they run
$PATH — what it is, how to add to it
which <command> — find where a binary lives
source ~/.zshrc
```

### Processes + system
```
ps aux, top, htop
kill <PID>, kill -9
Ctrl+C, Ctrl+Z, fg, bg
jobs
```

### Shell scripting basics
```bash
#!/bin/bash
# variables, if/then, for loops, functions
# $1, $2 positional arguments
# exit codes: 0 = success, non-zero = failure
```

### Useful tools to install
```
brew install ripgrep jq tldr tree htop
```

---

## Exercises

**Set 1 — Navigation (15–20 min):**
1. Open terminal. Navigate to your home directory. List all files including hidden ones.
2. Create a directory `training-scratch/` with three subdirectories inside it.
3. Create a file `notes.txt` inside one of them, add text with `echo "hello" > notes.txt`.
4. Move the file to a different subdirectory, then delete the empty one.
5. Find all `.txt` files in `training-scratch/` using `find`.

**Set 2 — Pipes + text manipulation (20 min):**
1. Run `ls -la /usr/bin | head -20` — understand the output.
2. Run `ls /usr/bin | wc -l` — how many binaries?
3. Run `ps aux | grep node` — find any running Node processes.
4. Create a file with 10 lines, sort it, count unique lines: `sort file.txt | uniq | wc -l`

**Set 3 — Environment variables (15 min):**
1. `echo $HOME` — what does it print?
2. `export MY_NAME="YourName"` then `echo $MY_NAME`.
3. Open `~/.zshrc` in VS Code (`code ~/.zshrc`). Add an alias: `alias ll='ls -la'`. Run `source ~/.zshrc` and test it.
4. `echo $PATH` — identify what directories are listed.

**Set 4 — Shell script (30 min):**
Write a script `docs/projects/hello-cli.sh` that:
- Takes a name as argument (`$1`)
- Prints "Hello, [name]!" 
- If no argument given, prints "Usage: hello-cli.sh <name>"
- Make it executable: `chmod +x hello-cli.sh`

---

## Checks — you understand this when you can:
- [ ] Navigate the file system confidently without a GUI
- [ ] Pipe commands together to filter and transform text output
- [ ] Explain what `$PATH` is and why it matters
- [ ] Read and modify your `.zshrc` file
- [ ] Write a basic shell script with arguments and conditionals
- [ ] Use `grep`/`rg` to search files by content
- [ ] Explain what a process is and how to kill one

---

## Artifacts to commit
- [ ] `docs/projects/hello-cli.sh` — your first shell script
- [ ] Notes added to `docs/glossary.md` for: shell, PATH, environment variable, pipe, stdin/stdout
- [ ] Log entry in `docs/log.md` after completing this module
