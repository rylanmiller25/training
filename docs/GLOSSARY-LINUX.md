# Glossary — Linux & CLI

Running list of Linux commands, programs, and shell concepts. Add entries as you encounter them. Format: **command/term** — what it does (one sentence; note any important flags).

---

## A

**`awk`** — Text processing tool for pattern scanning and field extraction; common for processing columnar data (`awk '{print $2}' file`).

## C

**`cat`** — Concatenate and print file contents to stdout (`cat file.txt`).

**`cd`** — Change directory (`cd /path/to/dir`; `cd ..` goes up one level; `cd ~` goes home).

**`chmod`** — Change file permissions (`chmod 755 script.sh`; `+x` adds execute permission).

**`chown`** — Change file ownership (`chown user:group file`).

**`cp`** — Copy files or directories (`cp src dst`; `-r` for recursive directory copy).

**`curl`** — Transfer data to/from a URL; used for making HTTP requests from the terminal (`curl -X POST -H "Content-Type: application/json" -d '{}' url`).

## D

**`df`** — Report disk space usage (`df -h` for human-readable sizes).

**`diff`** — Show line-by-line differences between two files.

**`du`** — Estimate file/directory space usage (`du -sh dir/` for summary).

## E

**`echo`** — Print text to stdout (`echo "hello"`; `echo $VAR` prints a variable).

**`env`** — Print all environment variables, or run a command with a modified environment.

**`export`** — Mark a shell variable for export to child processes (`export API_KEY=abc123`).

## F

**`find`** — Search for files by name, type, size, or other criteria (`find . -name "*.ts"` finds TypeScript files).

**`grep`** — Search file contents for a pattern (`grep -r "TODO" .` searches recursively; `-n` shows line numbers).

## H

**`head`** — Print the first N lines of a file (`head -20 file.txt`).

**`history`** — Show command history; `!N` re-runs command number N.

## J

**`jq`** — Command-line JSON processor; filter and transform JSON (`curl url | jq '.data[]'`).

## K

**`kill`** — Send a signal to a process by PID (`kill -9 PID` force-kills).

**`killall`** — Kill all processes with a given name (`killall node`).

## L

**`less`** — Page through file contents interactively (q to quit, / to search).

**`ln`** — Create hard or symbolic links (`ln -s target link` creates a symlink).

**`ls`** — List directory contents (`-l` for long format, `-a` shows hidden files, `-h` for human sizes).

## M

**`man`** — Display the manual page for a command (`man grep`).

**`mkdir`** — Create a directory (`mkdir -p path/to/nested/dir` creates intermediate dirs).

**`mv`** — Move or rename files and directories (`mv old new`).

## P

**`PATH`** — Environment variable listing directories where the shell searches for executables; colon-separated.

**`ping`** — Send ICMP echo requests to test network connectivity (`ping google.com`).

**`ps`** — Report running processes (`ps aux` lists all processes with CPU/memory usage).

**`pwd`** — Print the current working directory.

## R

**`rm`** — Remove files or directories (`rm -rf dir/` removes recursively — irreversible, use with care).

**`rsync`** — Efficiently sync files between locations (`rsync -avz src/ user@host:dst/`).

## S

**`sed`** — Stream editor for filtering and transforming text (`sed 's/old/new/g' file` replaces all occurrences).

**`set`** — Show or set shell options and positional parameters; `set -e` exits on any error (useful in scripts).

**`sort`** — Sort lines of text (`-n` for numeric, `-r` for reverse, `-u` for unique).

**`ssh`** — Secure Shell; connect to a remote machine (`ssh user@host`; `-i key.pem` for key auth).

**`sudo`** — Execute a command as superuser (`sudo apt install package`).

## T

**`tail`** — Print the last N lines of a file (`tail -f file` follows the file live — useful for logs).

**`tar`** — Archive files (`tar -czf archive.tar.gz dir/` creates; `tar -xzf archive.tar.gz` extracts).

**`top`** / **`htop`** — Interactive process viewer showing CPU and memory usage in real time.

**`touch`** — Create an empty file or update a file's timestamp (`touch newfile.txt`).

**`tr`** — Translate or delete characters (`tr '[:upper:]' '[:lower:]'` lowercases input).

## U

**`uniq`** — Remove or report duplicate adjacent lines (usually piped after `sort`).

## W

**`wc`** — Count lines, words, or characters (`wc -l file` counts lines).

**`which`** — Show the full path of a command (`which node` tells you which node binary is being used).

**`whoami`** — Print the current user name.

## X

**`xargs`** — Build and execute commands from stdin (`find . -name "*.log" | xargs rm`).

---

## Shell concepts

**Pipe (`|`)** — Pass stdout of one command as stdin to the next (`cat file | grep pattern | wc -l`).

**Redirect (`>`, `>>`)** — Write stdout to a file (`>` overwrites; `>>` appends).

**Stdin / Stdout / Stderr** — Standard input (0), output (1), and error (2) streams; redirect stderr with `2>`.

**Shebang (`#!/bin/bash`)** — First line of a script declaring which interpreter to use.

**Exit code** — Integer returned by a command; 0 = success, non-zero = error. Access with `$?`.

**Environment variable** — Named value available to processes (`$HOME`, `$USER`, `$PATH`).

**Glob** — Shell wildcard pattern (`*.ts` matches all TypeScript files; `**` matches recursively in some shells).

**`&&` and `||`** — Chain commands: `&&` runs the next only if the previous succeeded; `||` runs if it failed.

---

*Add commands here as you encounter them during the cli-linux module and beyond.*
