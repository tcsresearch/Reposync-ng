### Duplicate Detection With Ignore For WhiteSpace

To ignore leading and trailing whitespace while checking excludes.list for duplicates, trim the spaces using sed or awk before piping to sort | uniq -d.

<hr>

#### 1. Quick One-Liner (Trims whitespace, ignores comments & blank lines)


```sed -E 's/^[[:space:]]+|[[:space:]]+$//g' excludes.list | grep -vE '^($|#)' | sort | uniq -d```
Use code with caution.

• ```sed -E 's/^[[:space:]]+|[[:space:]]+$//g'``` strips all leading and trailing spaces or tabs from every line.
• ```grep -vE '^($|#)'``` filters out empty lines and ```#``` comments (now simplified since leading whitespace is already gone).
• ```sort | uniq -d``` finds and displays the duplicate entries.

<hr>

#### 2. Inside a Bash Script

To keep your script ShellCheck-clean (avoiding SC2155 by separating variable declaration from command assignment):

```
#!/usr/bin/env bash

EXCLUDES_FILE="excludes.list"

local duplicates
duplicates=$(sed -E 's/^[[:space:]]+|[[:space:]]+$//g' "$EXCLUDES_FILE" | grep -vE '^($|#)' | sort | uniq -d)

if [[ -n "$duplicates" ]]; then
    echo "Duplicate entries found in $EXCLUDES_FILE:"
    echo "$duplicates"
    # return 1 or exit 1
fi
```

Use code with caution.

(Note: Remove local if you are placing this directly in the main body of a script rather than inside a function.)

<hr>

#### 3. Automatically Clean & Trim in Place (Preserving Order)

If you want to normalize the file by trimming extra whitespace and removing duplicates while keeping your comments and original order intact:

```
awk '{
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", $0)
    if ($0 !~ /^($|#)/ && seen[$0]++) next
    print
}' excludes.list > excludes.list.tmp && mv excludes.list.tmp excludes.list
```

Use code with caution.

• ```gsub(...)``` trims leading and trailing spaces from the current line.
• ```if ($0 !~ /^($|#)/ && seen[$0]++) next``` skips the line if it is a non-comment, non-blank duplicate.
• ```print``` outputs the cleaned line, preserving your file's structure.


