CC=gcc
INCLUDES=-Isrc -Isrc/Aarya
CFLAGS=-std=gnu99 -Wall -Wextra -Wno-pointer-arith -pedantic -gdwarf-4 -MMD -MP -O0 -D_GNU_SOURCE -c $(INCLUDES)
OBJDIR=.obj
FILES=$(shell find src/Aarya -type f -name "*.c")
OBJ=$(FILES:src/%.c=$(OBJDIR)/%.o)

all: bulkrename files_test

bulkrename: $(OBJDIR)/bulkrename.o $(OBJ)
	$(CC) -std=gnu99 $^ -o $@

files_test: $(OBJDIR)/files_test.o $(OBJ)
	$(CC) -std=gnu99 $^ -o $@

$(OBJDIR)/%.o: src/%.c
	@mkdir -p $(dir $@);
	$(CC) $(CFLAGS) $< -o $@

.PHONY: memcheck
memcheck:
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./main $(shell ls)

.PHONY: clean
clean:
	rm -rf $(OBJDIR) main

-include $(OBJDIR)/*.d

