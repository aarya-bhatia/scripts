# Notes

## `bulkrename`

This program enables us to rename a list of files in our default editor. This
program accepts any number of file names as arguments. It will not accept
directories or non-existent files as input. It will launch an editor such as
Vim and open a temporary file populated with the file names that are valid with
their absolute resolved paths. You may create non-existent directories while
renaming them. However, all file names must be unique. No overwriting of files
is allowed. The renamed file names may accept absolute or relative paths. The
`resolve_path` function can handle a variety of file paths as seen in the [test
file](./src/files_test.c).

Dependencies

- `gcc` compiler

Build:

- Run `make`
- This creates an executable called `bulkrename`

Examples:

- `./bulkrename $(find . -type f)`
- With pipe: `echo $(ls) | xargs ./bulkrename`
- Without logs: `./bulkrename 2>/dev/null`

