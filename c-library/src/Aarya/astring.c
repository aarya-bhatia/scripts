#include "astring.h"

size_t _GetCapacity(size_t n) {
  size_t c = 1;
  while (c < n) {
    c = c << 1;
  }
  return c;
}

void StringWrite(string_t *this, int fd) {
  write(fd, this->buffer, this->size);
}

/**
 * Creates a new string_tobject with a capacity of at least n characters
 */
string_t *StringConstructor(size_t n) {
  string_t *this = malloc(sizeof *this);
  this->size = 0;
  this->capacity = MAX(_GetCapacity(n), INITIAL_CAPACITY);
  this->buffer = calloc(this->capacity, 1);

  return this;
}

string_t *StringDefaultConstructor() {
  return StringConstructor(INITIAL_CAPACITY);
}

size_t StringSize(const string_t *this) { return this->size; }

size_t StringCapacity(const string_t *this) { return this->capacity; }

/**
 * Adds a single characters to the end of the String
 */
void StringAdd(string_t *this, char c) {
  StringReserve(this, this->size + 1);
  this->buffer[this->size++] = c;
}

/**
 * Adds a c string to the end of the String
 */
void StringAddCstr(string_t *this, char *cstr) {
  assert(this);
  assert(cstr);
  size_t length = strlen(cstr);
  StringReserve(this, this->size + length);
  memcpy(this->buffer + this->size, cstr, length);
  this->size += length;
}

/**
 * Concatenates the string_tother to the String this
 */
void StringAppend(string_t *this, const string_t *other) {
  StringReserve(this, this->size + other->size);
  memcpy(this->buffer + this->size, other->buffer, other->size);
  this->size += other->size;
}

/**
 * Creates a C string from given String
 */
char *StringToCstr(string_t *this) {
  char *cstr = malloc(this->size + 1);
  memcpy(cstr, this->buffer, this->size);
  cstr[this->size] = 0;
  return cstr;
}

/**
 * Creates a string_tobject from a C string
 */
string_t *CstrToString(char *cstr) {
  size_t length = strlen(cstr);
  string_t *this = StringConstructor(length);
  memcpy(this->buffer, cstr, length);
  this->size = length;
  return this;
}

/**
 * Destructor to free up all memory allocated by the string_tincluding itself
 */
void StringDestructor(string_t *this) {
  if (!this) {
    return;
  }

  free(this->buffer);
  free(this);
}

/**
 * Returns a substring (C string) of given string_tin the range [start ... end)
 * Returns NULL if invalid range i.e. end < start
 */
char *StringSlice(string_t *this, size_t start, size_t end) {
  if (end < start || start >= this->size || end > this->size) {
    return NULL;
  }

  size_t length = end - start;
  char *str = calloc(length + 1, 1);
  memcpy(str, this->buffer + start, length);
  return str;
}

/**
 * To change the size of given string_tto specified size.
 * - If new size > old size => This function will expand the string in size and
 * capacity and fill new bytes with 0.
 * - If new size < old size => string_twill destroy the additional bytes and
 * shrink itself to given size and capacity.
 * - This function WILL change the SIZE and CAPACITY of the given String.
 * - The capacity of the string will be at least the minimum capacity, i.e.
 * capacity >= size.
 */
void StringResize(string_t *this, size_t size) {
  if (size == this->size) {
    return;
  }

  this->capacity = _GetCapacity(size);
  this->buffer = realloc(this->buffer, this->capacity);

  if (size > this->size) {
    // zero out the new bytes
    memset(this->buffer + this->size, 0, size - this->size);
  } else {
    // zero out the extra bytes
    memset(this->buffer + size, 0, this->size - size);
  }

  this->size = size;
}

/**
 * - This function will do nothing if new capacity is smaller than old capacity.
 * - It will ensure that the string has space for at least 'capacity' no. of
 * bytes.
 * - It will NOT change the size of the string, but it MAY change its capacity.
 */
void StringReserve(string_t *this, size_t capacity) {
  if (capacity > this->capacity) {
    this->capacity = _GetCapacity(capacity);
    this->buffer = realloc(this->buffer, this->capacity);
  }
}

string_t *wrap_with_quotes(char *str) {
  string_t *s = StringDefaultConstructor();
  StringAdd(s, '"');
  StringAddCstr(s, str);
  StringAdd(s, '"');
  return s;
}
