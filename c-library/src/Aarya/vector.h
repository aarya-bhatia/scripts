#pragma once

#include "common.h"

typedef struct Vector {
  void **elems;
  size_t size;
  size_t capacity;
  elem_copy_type elem_copy;
  elem_free_type elem_free;
} Vector;

Vector *Vector_alloc(elem_copy_type elem_copy, elem_free_type elem_free);
void Vector_free(Vector *);
void *Vector_at(Vector *, size_t index);
size_t Vector_size(Vector *);
size_t Vector_capacity(Vector *);
void Vector_reserve(Vector *, size_t capacity);
bool Vector_contains(Vector *, const void *target, elem_compare_type compare);
void Vector_remove(Vector *, size_t index, void **elem_out);
void Vector_push(Vector *, void *elem);
void Vector_foreach(Vector *, void (*callback)(void *elem_ptr));
Vector *Vector_filter(Vector *, elem_filter_type filter);
Vector *Vector_clear(Vector *);
