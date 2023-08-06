#include "common.h"

#include <stdarg.h>
#include <ctype.h>
#include <stdlib.h>

size_t _align_capacity(size_t capacity) {
	size_t i = 1;
	while (i < capacity) {
		i *= 2;
	}
	return i;
}

/**
 * Use this utility function to allocate a string with given format and args.
 * The purpose of this function is to check the size of the resultant string
 * after all substitutions and allocate only those many bytes.
 */
char *make_string(char *format, ...) {
	va_list args;

	// Find the length of the output string

	va_start(args, format);
	int n = vsnprintf(NULL, 0, format, args);
	va_end(args);

	// Create the output string

	char *s = calloc(1, n + 1);

	va_start(args, format);
	vsprintf(s, format, args);
	va_end(args);

	return s;
}

/**
 * Note: This function returns a pointer to a substring of the original string.
 * If the given string was allocated dynamically, the caller must not overwrite
 * that pointer with the returned value, since the original pointer must be
 * deallocated using the same allocator with which it was allocated.  The return
 * value must NOT be deallocated using free() etc.
 *
 */
char *trimwhitespace(char *str) {
	char *end;

	// Trim leading space
	while (isspace((unsigned char)*str)) str++;

	if (*str == 0)	// All spaces?
		return str;

	// Trim trailing space
	end = str + strlen(str) - 1;
	while (end > str && isspace((unsigned char)*end)) end--;

	// Write new null terminator character
	end[1] = '\0';

	return str;
}

/**
 * Return a pointer to the last occurrence of substring "pattern" in
 * given string "string". Returns NULL if pattern not found.
 */
char *rstrstr(char *string, char *pattern) {
	char *next = strstr(string, pattern);
	char *prev = next;

	while (next) {
		next = strstr(prev + strlen(pattern), pattern);

		if (next) {
			prev = next;
		}
	}

	return prev;
}

void *shallow_copy(void *elem_ptr) { return elem_ptr; }
void shallow_free(void *elem_ptr) { (void)elem_ptr; }

int shallow_compare(const void *elem_ptr_1, const void *elem_ptr_2) {
	return elem_ptr_1 - elem_ptr_2;
}

char *shallow_to_string(void *elem_ptr) { return make_string("%p", elem_ptr); }

void *int_copy(void *int_ptr) {
	int *data = calloc(1, sizeof(int));
	memcpy(data, int_ptr, sizeof(int));
	return data;
}

void *double_copy(void *double_ptr) {
	double *data = calloc(1, sizeof(double));
	memcpy(data, double_ptr, sizeof(double));
	return data;
}

void *float_copy(void *float_ptr) {
	float *data = calloc(1, sizeof(float));
	memcpy(data, float_ptr, sizeof(float));
	return data;
}

void *long_copy(void *long_ptr) {
	long *data = calloc(1, sizeof(long));
	memcpy(data, long_ptr, sizeof(long));
	return data;
}

void *char_copy(void *char_ptr) {
	char *data = calloc(1, sizeof(char));
	memcpy(data, char_ptr, sizeof(char));
	return data;
}

int char_compare(const void *char_ptr_1, const void *char_ptr_2) {
	char first = *(char *)char_ptr_1;
	char second = *(char *)char_ptr_2;
	return first - second;
}

int int_compare(const void *int_ptr_1, const void *int_ptr_2) {
	int first = *(int *)int_ptr_1;
	int second = *(int *)int_ptr_2;
	return first - second;
}

int long_compare(const void *long_ptr_1, const void *long_ptr_2) {
	long first = *(long *)long_ptr_1;
	long second = *(long *)long_ptr_2;
	return first - second;
}

int float_compare(const void *float_ptr_1, const void *float_ptr_2) {
	float first = *(float *)float_ptr_1;
	float second = *(float *)float_ptr_2;
	return first - second;
}

int double_compare(const void *double_ptr_1, const void *double_ptr_2) {
	double first = *(double *)double_ptr_1;
	double second = *(double *)double_ptr_2;
	return first - second;
}

char *int_to_string(void *int_ptr) {
	return make_string("%d", *(int *)int_ptr);
}

char *long_to_string(void *long_ptr) {
	return make_string("%ld", *(long *)long_ptr);
}

char *float_to_string(void *float_ptr) {
	return make_string("%f", *(float *)float_ptr);
}

char *double_to_string(void *double_ptr) {
	return make_string("%f", *(double *)double_ptr);
}

char *char_to_string(void *char_ptr) {
	return make_string("%c", *(char *)char_ptr);
}
