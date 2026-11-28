### Duplicate Detection & Removal

To check excludes.list for duplicate entries in Bash, use sort piped into uniq -d.
Because excludes.list files often contain blank lines or # comments, it is best to filter those out first so multiple blank lines don't trigger a false positive.

<hr>

#### 1. Quick One-Liner (Ignores comments & blank lines)

Run this in your terminal to print any duplicate entries:

```grep -vE '^\s*($|#)' excludes.list | sort | uniq -d```

Use code with caution.
• ```grep -vE '^\s*($|#)'``` strips out empty lines, whitespace-only lines, and lines starting with ```#```.
• sort groups identical lines together (required for ```uniq``` to work).
• ```uniq -d``` prints only the lines that appear more than once. (Add ```-c``` as ```uniq -cd``` if you also want to see how many times each duplicate appears.)

<hr>

#### 2. Inside a Bash Script (With Exit Status / Warning)

If you want to validate excludes.list inside an existing script and handle duplicates programmatically:
```
#!/usr/bin/env bash

EXCLUDES_FILE="excludes.list"

# Find duplicates while ignoring comments and blank lines
duplicates=$(grep -vE '^\s*($|#)' "$EXCLUDES_FILE" | sort | uniq -d)

if [[ -n "$duplicates" ]]; then
    echo "Warning: Duplicate entries found in $EXCLUDES_FILE:"
    echo "$duplicates"
    # Optional: exit 1 if you want the script to stop on duplicates
else
    echo "No duplicate entries found in $EXCLUDES_FILE."
fi
Use code with caution.
```

<hr>

#### 3. Automatically Remove Duplicates (Preserving Order)

If you want to clean the file in place without scrambling its original order, you can use awk:

```awk '!/^\s*($|#)/ && seen[$0]++ { next } { print }' excludes.list > excludes.list.tmp && mv excludes.list.tmp excludes.list```

Use code with caution.

(This keeps all comments and blank lines intact while removing any repeated exclusion rules after their first occurrence.)
Would you like to ignore leading/trailing whitespace when checking for duplicates, or integrate this check into a larger backup/sync script?
               
