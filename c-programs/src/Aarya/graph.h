#pragma once

#include "include/common.h"
#include "include/hashtable.h"
#include "include/list.h"
#include "include/vector.h"

typedef struct Vertex {
	void *key;
	void *data;
	List *adj; /* List of vertices */
} Vertex;

typedef struct Graph {
	compare_type key_compare;
	hash_type key_hash;
	copy_type key_copy;
	free_type key_free;
	copy_type value_copy;
	free_type value_free;
	Hashtable *nodes; /* Map key to vertex */
} Graph;
