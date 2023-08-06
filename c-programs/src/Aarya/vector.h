#pragma once

#include "common.h"

#define DEFAULT_CAPACITY 8

typedef struct Vector {
  void **elems;
  size_t size;
  size_t capacity;
  copy_type elem_copy;
  free_type elem_free;
} Vector;

Vector *Vector_alloc(copy_type copy, free_type elem_free);
void Vector_free(Vector *);
void *Vector_first(Vector *);
void *Vector_last(Vector *);
void *Vector_at(Vector *, size_t index);
size_t Vector_size(Vector *);
size_t Vector_capacity(Vector *);
void Vector_reserve(Vector *, size_t capacity);
bool Vector_contains(Vector *, const void *target, compare_type compare);
void Vector_remove(Vector *, size_t index, void **elem_out);
void Vector_push(Vector *, void *elem);
void Vector_foreach(Vector *, void (*callback)(void *elem_ptr));
void Vector_clear(Vector *);
