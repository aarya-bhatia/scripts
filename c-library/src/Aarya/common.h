#pragma once

#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

#include "log.h"

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

#define xfree(ptr)                                                             \
  free(ptr);                                                                   \
  ptr = NULL;

#define DEFAULT_CAPACITY 8

char *make_string(char *format, ...);
char *rstrstr(char *string, char *pattern);
char *trimwhitespace(char *str);
size_t _align_capacity(size_t capacity);

typedef int (*elem_compare_type)(const void *elem_ptr_1,
                                 const void *elem_ptr_2);
typedef void *(*elem_copy_type)(void *elem_ptr);
typedef void (*elem_free_type)(void *elem_ptr);
typedef char *(*elem_to_string_type)(void *elem_ptr);
typedef size_t (*elem_hash_type)(void *elem_ptr);
typedef void (*elem_callback_type)(void *elem_ptr);
typedef bool (*elem_filter_type)(void *elem_ptr);

#define string_copy ((elem_copy_type)strdup)
#define string_compare ((elem_compare_type)strcmp)

void *shallow_copy(void *elem_ptr);
void shallow_free(void *elem_ptr);
int shallow_compare(const void *_ptr_elem1, const void *_ptr_elem2);
char *shallow_to_string(void *elem_ptr);

void *char_copy(void *char_ptr);
int char_compare(const void *char_ptr_1, const void *char_ptr_2);
char *char_to_string(void *char_ptr);

void *int_copy(void *int_ptr);
int int_compare(const void *int_ptr_1, const void *int_ptr_2);
char *int_to_string(void *int_ptr);

void *long_copy(void *long_ptr);
int long_compare(const void *long_ptr_1, const void *long_ptr_2);
char *long_to_string(void *long_ptr);

void *float_copy(void *float_ptr);
int float_compare(const void *float_ptr_1, const void *float_ptr_2);
char *float_to_string(void *float_ptr);

void *double_copy(void *double_ptr);
int double_compare(const void *double_ptr_1, const void *double_ptr_2);
char *double_to_string(void *double_ptr);
