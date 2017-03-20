CFLAGS = -msse2 --std gnu99 -O0 -Wall -Wextra

GIT_HOOKS := .git/hooks/applied

EXEC = naive sse sse_prefetch verify

all: $(GIT_HOOKS) $(EXEC)

verify: $(GIT_HOOKS) main.c
	$(CC) $(CFLAGS) -DVERIFY -o verify main.c

naive: $(GIT_HOOKS) main.c
	$(CC) $(CFLAGS) -DNAIVE -o naive main.c

sse: $(GIT_HOOKS) main.c
	$(CC) $(CFLAGS) -DSSE -o sse main.c

sse_prefetch: $(GIT_HOOKS) main.c
	$(CC) $(CFLAGS) -DSSE_PREFETCH -o sse_prefetch main.c

stat:
	perf stat cache-misses,cache-references,instructions,cycles ./main

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

clean:
	$(RM) $(EXEC) perf.*
