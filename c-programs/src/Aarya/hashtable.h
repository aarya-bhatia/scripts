#pragma once

#include "common.h"

#define HT_DENSITY 0.6
#define HT_INITIAL_CAPACITY 11

typedef struct HTNode {
  void *key;
  void *value;
  struct HTNode *next;
} HTNode;

typedef struct Hashtable {
  HTNode **table;
  size_t size;
  size_t capacity;
  unsigned int seed;
  copy_type key_copy;
  free_type key_free;
  compare_type key_compare;
  copy_type value_copy;
  free_type value_free;
  hash_type hash;
} Hashtable;

typedef struct HashtableIter {
  Hashtable *hashtable;
  size_t index;
  HTNode *node;
  bool start;
} HashtableIter;

#define HASHTABLE_FOR_EACH(hashtable, iterator, key_ptr, value_ptr, callback)  \
  ht_iter_init(&iterator, hashtable);                                          \
  while (ht_iter_next(&iterator, (void **)key, (void **)value)) {              \
    callback;                                                                  \
  }

Hashtable *ht_alloc_string_to_shallow();
Hashtable *ht_alloc_int_to_shallow();

Hashtable *ht_alloc(copy_type key_copy, free_type key_free,
                    compare_type key_compare, hash_type key_hash,
                    copy_type value_copy, free_type value_free);

void ht_print(Hashtable *, to_string_type key_to_string,
              to_string_type value_to_string);
void ht_free(Hashtable *);

size_t ht_size(Hashtable *);
size_t ht_capacity(Hashtable *);

void *ht_get(Hashtable *, const void *key);
void ht_set(Hashtable *, void *key, void *value);
bool ht_remove(Hashtable *, const void *key, void **key_out, void **value_out);
bool ht_contains(Hashtable *, const void *key);
HTNode *ht_find(Hashtable *, const void *key);
void ht_iter_init(HashtableIter *itr, Hashtable *ht);
bool ht_iter_next(HashtableIter *itr, void **key_out, void **value_out);
void ht_foreach(Hashtable *, void (*callback)(void *key, void *value));

size_t djb2hash(const void *key, int len, uint32_t seed);
uint32_t jenkins_hash(const void *key, size_t len);
uint32_t fnv_hash(const void *key, size_t len);

size_t int_hash(void *int_ptr);
size_t string_hash(void *string_ptr);
