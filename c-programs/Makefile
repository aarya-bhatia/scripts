CC=gcc
INCLUDES=-Isrc
CFLAGS=-std=gnu99 -Wall -Wextra -Wno-pointer-arith -pedantic -gdwarf-4 -MMD -MP -O0 -D_GNU_SOURCE -c $(INCLUDES)
LDFLAGS=-Llib -laarya

all: bulkrename

bulkrename: obj/bulkrename.o $(OBJ)
	$(CC) -std=gnu99 $^ $(LDFLAGS) -o $@

obj/%.o: src/%.c
	mkdir -p obj;
	$(CC) $(CFLAGS) $< -o $@

memcheck:
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./bulkrename $(shell ls)

clean:
	rm -rf obj bulkrename

.PHONY: memcheck clean

-include $(OBJDIR)/*.d

