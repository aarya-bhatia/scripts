#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "Aarya/common.h"
#include "Aarya/files.h"
#include "Aarya/hashtable.h"

/**
 * To rename the original filenames to the modified filenames.
 *
 * The number of filenames in the tmpfile must match the num_files,
 * or else this operation will fail.
 *
 * Overwriting files is not allowed.
 *
 * @param tmpfile The temporary file containing the modified file names line by
 * line
 * @param filenames The original filenames given by their relative paths
 * @param num_files Length of the original filenames array
 */
void check_and_rename_files(const char *tmpfile, char **filenames,
                            size_t num_files) {
  FILE *handle = fopen(tmpfile, "r");

  if (!handle) {
    log_error("Failed to open temp file: %s", tmpfile);
    return;
  }

  char *line = NULL;
  size_t line_cap = 0;
  ssize_t n_read = 0;
  int flag = 1;

  // An array to store the names of modified file names
  char **names = calloc(8, sizeof *names);
  size_t cap = 8;
  size_t size = 0;

  // A hashmap to check if all file names are unique
  Hashtable *hashtable = ht_alloc(shallow_copy, shallow_free, shallow_compare,
                                  string_hash, shallow_copy, shallow_free);

  // Read file line by line
  while ((n_read = getline(&line, &line_cap, handle)) > 0) {
    assert(line);

    size_t n = strlen(line);
    assert(n > 0);

    if (line[n - 1] == '\n') {
      line[n - 1] = 0;
    }

    // Resize the array if required
    if (size == cap) {
      names = realloc(names, (size + 8) * sizeof(*names));
      cap += 8;
    }

    n = strlen(line);
    if (line[n - 1] == '/') {
      log_error("Error: File name cannot end with slash");
      flag = 0;
      break;
    }

    names[size] = resolve_path(line);
    log_debug("Resolved path: %s", names[size]);

    if (ht_get(hashtable, names[size]) != NULL) {
      log_error("Error: File names must be unique");
      flag = 0;
      break;
    }

    ht_set(hashtable, names[size], NULL);

    size++;
    assert(ht_size(hashtable) == size);

    if (size > num_files) {
      log_error("Error: The number of files have changed");
      flag = 0;
      break;
    }
  }

  ht_free(hashtable);
  hashtable = NULL;

  fclose(handle);

  if (flag) {
    log_info("OK to rename (%zu files)", size);

    for (size_t i = 0; i < size; i++) {
      char *original_filepath = filenames[i];
      char *new_filepath = names[i];

      if (strcmp(original_filepath, new_filepath) == 0) {
        continue;
      }

      log_info("Renaming file \"%s\" to \"%s\"", original_filepath, new_filepath);

      mkdirs(new_filepath);

      if (rename(filenames[i], names[i]) == -1) {
        log_error("Failed to rename file: %s", filenames[i]);
      }
    }
  }

  for (size_t i = 0; i < size; i++) {
    xfree(names[i]);
  }

  xfree(names);
  xfree(line);
}

int main(int argc, char *argv[]) {
  if (argc == 1) {
    log_warn("No files specified in arguments...");
    return 0;
  }

  struct stat st = {0};
  if (stat("/tmp/lf", &st) == -1) {
    int fd = mkdir("/tmp/lf", 0700);
    if (fd == -1) {
      log_error("Failed to create temporary directory");
      return 1;
    }
    close(fd);
    log_info("Created temporary directory");
  }

  char tmpfile[64];
  sprintf(tmpfile, "/tmp/lf/bulkrename-edit-XXXXXX");
  int fd = mkstemp(tmpfile);

  if (fd == -1) {
    log_error("Failed to create temporary file");
    return 1;
  }

  log_info("Created temporary file: %s", tmpfile);

  assert(argc > 1);
  char **filenames = calloc(argc, sizeof(*filenames));
  size_t num_files = 0;
  assert(filenames);

  // Write filenames to temp file
  for (int i = 1; i < argc; i++) {
    char *filename = realpath(argv[i], NULL);

    memset(&st, 0, sizeof st);
    if (stat(filename, &st) == -1) {
      log_warn("Skipped invalid file: %s", filename);
      xfree(filename);
      continue;
    } else if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
      filenames[num_files++] = filename;
      assert(filename);
      log_debug("Recevied file: %s", filename);
      write(fd, filename, strlen(filename));
      write(fd, "\n", 1);
    } else {
      log_warn("Not a regular file or link: %s", filename);
      xfree(filename);
    }
  }

  close(fd);

  int pid = fork();

  if (pid < 0) {
    perror("fork");
    exit(1);
  }

  if (pid == 0) {
    char *editor = getenv("EDITOR");
    if (!editor) {
      editor = "vim";
    }
    execlp(editor, editor, tmpfile, NULL);
    perror("execlp");
    exit(1);
  } else {
    int status;
    waitpid(pid, &status, 0);

    if (WIFEXITED(status)) {
      log_debug("Process has exited with status: %d\n", WEXITSTATUS(status));

      if (WEXITSTATUS(status) == 0) {
        check_and_rename_files(tmpfile, filenames, num_files);
      }
    }
  }

  for (size_t i = 0; i < num_files; i++) {
    xfree(filenames[i]);
  }
  xfree(filenames);

  remove(tmpfile);

  return 0;
}
