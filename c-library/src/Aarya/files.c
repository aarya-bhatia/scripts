#include "files.h"

char *join(Vector *vector);
void resolve_path_helper(Vector *vector, char *name);

char *resolve_path(char *path) {
  assert(path);
  if (strlen(path) == 0) {
    return NULL;
  }

  Vector *vector = Vector_alloc(NULL, free);
  assert(vector);

  if (path[0] != '/') {
    Vector_push(vector, getcwd(NULL, 0));
  } else {
    Vector_push(vector, strdup("/"));
  }

  char *s = strstr(path, "/");
  char *t = path;

  while (s) {
    if (s != t) {
      char *tmp = strndup(t, s - t);
      assert(tmp);
      resolve_path_helper(vector, tmp);
    }

    t = s + 1;
    s = strstr(t, "/");
  }

  assert(t);
  if (*t != 0) {
    assert(*t != '/');
    if (strcmp(t, ".") == 0 && Vector_size(vector) == 0) {
      Vector_push(vector, strdup(getenv("HOME")));
    } else {
      resolve_path_helper(vector, t);
    }
  }

  char *result = join(vector);
  Vector_free(vector);

  assert(result[0] == '/');
  assert(strcmp(result, "~") != 0);
  assert(strcmp(result, ".") != 0);
  assert(strcmp(result, "..") != 0);

  return result;
}

void mkdirs(char *filepath) {
  assert(filepath);
  char *resolved = resolve_path(filepath);
  assert(resolved);
  assert(*resolved == '/');

  if (strcmp(resolved, "/") == 0) {
    return;
  }

  char *s = strstr(resolved + 1, "/");
  char *t = resolved;

  struct stat st = {0};
  while (s) {
    *s = 0;
    memset(&st, 0, sizeof st);
    if (stat(resolved, &st) == -1) {
      log_debug("mkdir(\"%s\")", resolved);
      mkdir(resolved, 0750);
    }
    *s = '/';

    t = s;
    s = strstr(t + 1, "/");
  }

  log_debug("%s", resolved);
  free(resolved);
}

char *join(Vector *vector) {
  assert(vector);
  assert(Vector_size(vector) > 0);

  string_t *s = StringDefaultConstructor();
  for (size_t i = 0; i < Vector_size(vector); i++) {
    char *name = Vector_at(vector, i);

    assert(name);
    assert(strlen(name) > 0);

    if (strcmp(name, "/") == 0) {
      if (StringSize(s) == 0) {
        StringAddCstr(s, "/");
        continue;
      }
    }

    if (name[0] == '/') {
      size_t n = strlen(name);

      if (name[n - 1] == '/') {
        name[n - 1] = 0;
      }

      if (StringSize(s) == 0) {
        StringAddCstr(s, name);
      } else {
        assert(strlen(name + 1) > 0);
        StringAddCstr(s, name + 1);
      }
    } else {
      StringAddCstr(s, name);
    }

    if (i + 1 < Vector_size(vector)) {
      StringAddCstr(s, "/");
    }
  }

  char *joined = StringToCstr(s);
  StringDestructor(s);
  return joined;
}

void resolve_path_helper(Vector *vector, char *name) {
  if (strcmp(name, "..") == 0) {
    if (Vector_size(vector) >= 1) {
      char *prev = Vector_at(vector, Vector_size(vector) - 1);
      char *ptr = rstrstr(prev, "/");
      if (!ptr) {
        Vector_remove(vector, Vector_size(vector) - 1, NULL);
      } else {
        *ptr = 0;
      }
    } else {
      log_error("Invalid path");
    }
  } else if (strcmp(name, "~") == 0) {
    Vector_clear(vector);
    Vector_push(vector, strdup(getenv("HOME")));
  } else if (strcmp(name, ".") != 0) {
    Vector_push(vector, strdup(name));
  }
}
