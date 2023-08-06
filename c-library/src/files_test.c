#include "Aarya/files.h"

int tests_passed = 0;
int tests_total = 0;

void test_resolve_path_helper(char *path, char *expected) {
  char *resolved = resolve_path(path);

  log_info("TEST: resolve_path(\"%s\")", path);

  if (strcmp(resolved, expected) != 0) {
    log_warn("FAIL: \"%s\" != \"%s\"", resolved, expected);
  } else {
    log_info("PASS: \"%s\" == \"%s\"", resolved, expected);
    tests_passed++;
  }

  tests_total++;
}

int test_resolve_path() {
  test_resolve_path_helper("/", "/");
  test_resolve_path_helper("~", "/home/aarya");
  test_resolve_path_helper(".", "/home/aarya/dotfiles/scripts/c-library");
  test_resolve_path_helper("..", "/home/aarya/dotfiles/scripts");
  test_resolve_path_helper("./", "/home/aarya/dotfiles/scripts/c-library");
  test_resolve_path_helper("hello.pdf",
                           "/home/aarya/dotfiles/scripts/c-library/hello.pdf");
  test_resolve_path_helper("../hello", "/home/aarya/dotfiles/scripts/hello");
  test_resolve_path_helper("./../hello.txt",
                           "/home/aarya/dotfiles/scripts/hello.txt");
  test_resolve_path_helper("~/test/test1/../hello", "/home/aarya/test/hello");
  test_resolve_path_helper("~/test/test1/hello",
                           "/home/aarya/test/test1/hello");
  test_resolve_path_helper(
      "data/test1/test2/hello",
      "/home/aarya/dotfiles/scripts/c-library/data/test1/test2/hello");
  test_resolve_path_helper("/home/aarya/hello", "/home/aarya/hello");
  test_resolve_path_helper("~/hello", "/home/aarya/hello");
  test_resolve_path_helper("/tmp/hello", "/tmp/hello");
  test_resolve_path_helper(".../hello",
                           "/home/aarya/dotfiles/scripts/c-library/.../hello");
  test_resolve_path_helper("///", "/");
  test_resolve_path_helper("./..//~/~/~//", "/home/aarya");

  assert(tests_passed <= tests_total);
  if (tests_passed == tests_total) {
    log_info("Result: All tests passed!");
    return 0;
  } else {
    log_warn("Result: %d tests passed, %d tests failed", tests_passed,
             tests_total - tests_passed);
    return 1;
  }
}

int test_mkdirs() {
  mkdirs("/home/aarya/file1");
  mkdirs("data/test1/test2/test3");
  mkdirs("data/test2/test3/../test4");
  return 0;
}

int main(int argc, char *argv[]) {
  int done[32] = {0};
  int status = 0;
  for (int i = 1; i < argc; i++) {
    int test_num = atoi(argv[i]);
    switch (test_num) {
    case 1:
      if (!done[1]) {
        status |= test_resolve_path();
      }
      done[1] = 1;
      break;
    case 2:
      if (!done[2]) {
        status |= test_mkdirs();
      }
      done[2] = 1;
      break;
    }
  }

  return status;
}
