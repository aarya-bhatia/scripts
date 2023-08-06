#include "common.h"
#include "vector.h"

Vector *Vector_alloc(elem_copy_type elem_copy, elem_free_type elem_free) {
	Vector *this = calloc(1, sizeof *this);
	this->elems = calloc(DEFAULT_CAPACITY, sizeof *this->elems);
	this->size = 0;
	this->capacity = DEFAULT_CAPACITY;
	this->elem_copy = elem_copy ? elem_copy : shallow_copy;
	this->elem_free = elem_free ? elem_free : shallow_free;
	return this;
}

void Vector_free(Vector *this) {
	assert(this);

	for (size_t i = 0; i < this->size; i++) {
		this->elem_free(this->elems[i]);
		this->elems[i] = NULL;
	}

	free(this->elems);
	free(this);
}

size_t Vector_size(Vector *this) {
	assert(this);
	return this->size;
}

void *Vector_at(Vector *this, size_t index) {
	assert(this);
	assert(index < this->size);
	return this->elems[index];
}

void Vector_reserve(Vector *this, size_t capacity) {
	assert(this);
	if (capacity <= this->capacity) {
		return;
	}
	this->capacity = _align_capacity(capacity);
	this->elems = realloc(this->elems, this->capacity * sizeof *this->elems);
	memset(this->elems + this->size, 0,
		   (this->capacity - this->size) * sizeof *this->elems);
}

bool Vector_contains(Vector *this, const void *target,
					 elem_compare_type compare) {
	assert(this);
	assert(compare);

	for (size_t i = 0; i < this->size; i++) {
		if (compare(this->elems[i], target) == 0) {
			return true;
		}
	}

	return false;
}

void Vector_remove(Vector *this, size_t index, void **elem_out) {
	assert(this);

	if (index >= this->size) {
		return;
	}

	if (elem_out) {
		*elem_out = this->elems[index];
	} else {
		this->elem_free(this->elems[index]);
	}

	this->elems[index] = NULL;

	if (index < this->size - 1) {
		memmove(this->elems + index, this->elems + index + 1,
				(this->size - index - 1) * sizeof *this->elems);
	}

	this->size--;
}

void Vector_push(Vector *this, void *elem) {
	assert(this);
	Vector_reserve(this, this->size + 1);
	this->elems[this->size++] = this->elem_copy(elem);
}

void Vector_foreach(Vector *this, void (*callback)(void *elem_ptr)) {
	assert(this);
	assert(callback);

	for (size_t i = 0; i < this->size; i++) {
		callback(this->elems[i]);
	}
}

Vector *Vector_filter(Vector *this, elem_filter_type filter) {
	assert(this);
	assert(filter);

	Vector *results = Vector_alloc(this->elem_copy, this->elem_free);

	for (size_t i = 0; i < this->size; i++) {
		if (filter(this->elems[i])) {
			Vector_push(results, this->elem_copy(this->elems[i]));
		}
	}

	return results;
}

Vector *Vector_clear(Vector *this) {
  for(size_t i = 0; i < this->size; i++) {
    this->elem_free(this->elems[i]);
    this->elems[i] = NULL;
  }

  this->size = 0;
}

