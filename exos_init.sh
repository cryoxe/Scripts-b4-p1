#!/bin/bash


if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Nope: You need to use this script inside the Intranet repository"
    exit 1
fi

# Storing user's Git identity for restoring
name=$(git config user.name)
email=$(git config user.email)

# Changing Git identity to create Given Files
git config user.name "Tom Nook"
git config user.email "tom.nook@acdc.fr"

echo "Creating save point. Do not turn off the console..."
git switch -c master 1>/dev/null 2>/dev/null
git commit -m "Reset" --allow-dry 1>/dev/null 2>/dev/null

# Simple merge
git switch -c merge_simple 1>/dev/null 2>/dev/null
echo 'Into this branch!' > merge_simple_file
git add merge_simple_file 1>/dev/null 2>/dev/null
git commit -m "feat(simple-merge): add file to simple_merge_branch" 1>/dev/null 2>/dev/null

git switch -c merge_me 1>/dev/null 2>/dev/null
echo 'Merge this branch' > merge_me_file
git add merge_me_file 1>/dev/null 2>/dev/null
git commit -m "feat(simple-merge): add file to merge_me branch" 1>/dev/null 2>/dev/null


# Easy merge conflict
# Setting up branch
git switch master 1>/dev/null 2>/dev/null
git switch -c merge_conflict_1 1>/dev/null 2>/dev/null

echo '#include <stdio.h>' > hello_world.c
{
    echo '';
    echo 'int main(void)';
    echo '{';
    echo '    return 0;';
    echo '}';
} >> hello_world.c

git add hello_world.c 1>/dev/null 2>/dev/null
git commit -m "feat: add hello_world" 1>/dev/null 2>/dev/null

sed -i '5i    printf("Hello World!);"' hello_world.c
git add hello_world.c 1>/dev/null 2>/dev/null
git commit -m "fix: hello_world" 1>/dev/null 2>/dev/null

# Setting up to-be-merged branch
git switch master 1>/dev/null 2>/dev/null
git switch -c hello_world_impl 1>/dev/null 2>/dev/null
echo '#include <stdio.h>' >  hello_world.c
{
    echo 'int main(void)';
    echo '{';
    echo '    puts("Hello World!");';
    echo '    return 0;';
    echo '}';
} >> hello_world.c

git add hello_world.c 1>/dev/null 2>/dev/null
git commit -m "fix(hello): replace printf with puts" 1>/dev/null 2>/dev/null


# Hard merge conflict
git switch master 1>/dev/null 2>/dev/null
git switch -c merge_conflict_2 1>/dev/null 2>/dev/null

echo '#ifndef STACK_H' > stack.h
{
    echo '#define STACK_H';
    echo '';
    echo '#include <stddef.h>';
    echo '';
    echo 'struct stack';
    echo '{';
    echo '    int *list;';
    echo '    size_t size;';
    echo '};';
    echo '';
    echo 'struct stack *init_stack();';
    echo 'struct stack *push(struct stack *stack, int elm);';
    echo 'int pop(struct stack *stack);';
    echo 'int peek(struct stack *stack);';
    echo 'int is_empty(struct stack *stack);';
    echo 'size_t size(struct stack *stack);';
    echo 'void print_stack(struct stack *stack);';
    echo 'void destroy_stack(struct stack *stack);';
    echo '';
    echo '#endif // ! STACK_H';
} >> stack.h

git add stack.h 1>/dev/null 2>/dev/null
git commit -m "feat: add stack.h" 1>/dev/null 2>/dev/null


split_hash=$(git rev-parse HEAD)
git config user.name "Isabelle"
git config user.email "isabelle@acdc.fr"

echo '#include "stack.h"' > stack.c
{
    echo '';
    echo '#include <stdio.h>';
    echo '#include <stdlib.h>';
    echo '';
    echo 'struct stack *init_stack()';
    echo '{';
    echo '    struct stack *stack = malloc(sizeof(struct stack));';
    echo '    stack->list = NULL;';
    echo '    stack->size = 0;';
    echo '';
    echo '    return stack;';
    echo '}';
    echo '';
    echo 'struct stack *push(struct stack *stack, int elm)';
    echo '{';
    echo '    stack->list = realloc(stack->list, (stack->size + 1) * sizeof(int));';
    echo '    stack->list[stack->size] = elm;';
    echo '    stack->size++;';
    echo '';
    echo '    return stack;';
    echo '}';
    echo '';
    echo 'int pop(struct stack *stack)';
    echo '{';
    echo '    if (!stack || stack->size == 0)';
    echo '        return -1;';
    echo '';
    echo '    int last = stack->list[stack->size - 1];';
    echo '    stack->size--;';
    echo '    return last;';
    echo '}';
    echo '';
    echo 'int peek(struct stack *stack)';
    echo '{';
    echo '    if (!stack || stack->size == 0)';
    echo '        return -1;';
    echo '';
    echo '    return stack->list[stack->size - 1];';
    echo '}';
    echo '';
    echo 'int is_empty(struct stack *stack)';
    echo '{';
    echo '    return stack->size == 0;';
    echo '}';
    echo '';
    echo 'size_t size(struct stack *stack)';
    echo '{';
    echo '    return stack->size;';
    echo '}';
    echo '';
    echo 'void print_stack(struct stack *stack)';
    echo '{';
    echo '    if (!stack)';
    echo '    {';
    echo '        printf("[]\n");';
    echo '        return;';
    echo '    }';
    echo '';
    echo '    printf("[");';
    echo '    if (stack->size > 0)';
    echo '        printf("%d", stack->list[0]);';
    echo '';
    echo '    for (size_t i = 1; i < stack->size; i++)';
    echo '    {';
    echo '        printf(", %d", stack->list[i]);';
    echo '    }';
    echo '';
    echo '    printf("]\n");';
    echo '}';
    echo '';
    echo 'void destroy_stack(struct stack *stack)';
    echo '{';
    echo '    free(stack);';
    echo '}';
} >> stack.c

git add stack.c 1>/dev/null 2>/dev/null
git commit -m "feat: added stack.c" 1>/dev/null 2>/dev/null

echo '#include <stdio.h>' > main.c
{
    echo '';
    echo '#include "stack.h"';
    echo '';
    echo 'int main(void)';
    echo '{';
    echo '    puts("Inserting numbers");';
    echo '    struct stack *stack = init_stack();';
    echo '    for (int i = 0; i < 10; ++i)';
    echo '        push(stack, i);';
    echo '';
    echo '    puts("stack: ");';
    echo '    print_stack(stack);';
    echo '';
    echo '    puts("Removing numbers!");';
    echo '    while (!is_empty(stack))';
    echo '        printf("Removing %d\n", pop(stack));';
    echo '';
    echo '    puts("stack: ");';
    echo '    print_stack(stack);';
    echo '    destroy_stack(stack);';
    echo '    return 0;';
    echo '}';
} >> main.c

git add main.c 1>/dev/null 2>/dev/null
git commit -m "feat: added main.c" 1>/dev/null 2>/dev/null

echo 'CC = clang' > Makefile
{
    echo 'CFLAGS = -Wall -Wextra -Wvla -pedantic -std=c99 -Werror';
    echo '';
    echo 'OBJS = \';
    echo '       main.o \';
    echo '       stack.o';
    echo '';
    echo 'BIN = main';
    echo '';
    echo '.PHONY: all run clean';
    echo '';
    echo '$(BIN): $(OBJS)';
    echo '';
    echo 'all: $(BIN)';
    echo '';
    echo 'run: $(BIN)';
    echo '	./$(BIN)';
    echo '';
    echo 'debug: CFLAGS += -g -fsanitize=address';
    echo 'debug: LDLIBS += -lasan';
    echo 'debug: $(BIN)';
    echo '';
    echo '';
    echo 'clean:';
    echo '	$(RM) $(OBJS) $(BIN)';
} >> Makefile

git add Makefile 1>/dev/null 2>/dev/null
git commit -m "build: add Makefile" 1>/dev/null 2>/dev/null

# Now to setup to be merged branch

git config user.name "Tom Nook"
git config user.email "tom.nook@acdc.fr"

git checkout "$split_hash" 1>/dev/null 2>/dev/null
git switch -c add_stack_impl 1>/dev/null 2>/dev/null

echo '#include "stack.h"' > stack.c
{
    echo '';
    echo '#include <stdio.h>';
    echo '#include <stdlib.h>';
    echo '';
    echo 'struct stack *init_stack()';
    echo '{';
    echo '    struct stack *stack = calloc(1, sizeof(struct stack));';
    echo '    if (!stack)';
    echo '        return NULL;';
    echo '';
    echo '    return stack;';
    echo '}';
    echo '';
    echo 'struct stack *push(struct stack *stack, int elm)';
    echo '{';
    echo '    stack->list = realloc(stack->list, (stack->size + 1) * sizeof(int));';
    echo '    if (!stack->list)';
    echo '    {';
    echo '        free(stack);';
    echo '        return NULL;';
    echo '    }';
    echo '    stack->list[stack->size] = elm;';
    echo '    stack->size++;';
    echo '';
    echo '    return stack;';
    echo '}';
    echo '';
    echo 'int pop(struct stack *stack)';
    echo '{';
    echo '    if (!stack || stack->size == 0)';
    echo '        return -1;';
    echo '';
    echo '    int elm = stack->list[0];';
    echo '    for (size_t i = 1; i < stack->size; i++)';
    echo '        stack->list[i - 1] = stack->list[i];';
    echo '';
    echo '    stack->size--;';
    echo '    return elm;';
    echo '}';
    echo '';
    echo 'int peek(struct stack *stack)';
    echo '{';
    echo '    if (!stack || stack->size == 0)';
    echo '        return -1;';
    echo '';
    echo '    return stack->list[0];';
    echo '}';
    echo '';
    echo 'int is_empty(struct stack *stack)';
    echo '{';
    echo '    return !stack || stack->size == 0;';
    echo '}';
    echo '';
    echo 'size_t size(struct stack *stack)';
    echo '{';
    echo '    if (!stack)';
    echo '        return 0;';
    echo '    return stack->size;';
    echo '}';
    echo '';
    echo 'void print_stack(struct stack *stack)';
    echo '{';
    echo '    if (!stack)';
    echo '    {';
    echo '        printf("\n");';
    echo '        return;';
    echo '    }';
    echo '';
    echo '    if (stack->size > 0)';
    echo '        printf("%d\n", stack->list[0]);';
    echo '';
    echo '    for (size_t i = 1; i < stack->size; i++)';
    echo '    {';
    echo '        printf("%d\n", stack->list[i]);';
    echo '    }';
    echo '}';
    echo '';
    echo 'void destroy_stack(struct stack *stack)';
    echo '{';
    echo '    if (stack)';
    echo '        free(stack->list);';
    echo '    free(stack);';
    echo '}';
} >> stack.c

git add stack.c 1>/dev/null 2>/dev/null
git commit -m "feat: add stack.c" 1>/dev/null 2>/dev/null

echo 'CC = gcc' > Makefile
{
    echo 'CFLAGS = -Wall -Wextra -Wvla -pedantic -std=c99 -Werror';
    echo '';
    echo 'OBJS = \';
    echo '       stack.o \';
    echo '       main.o';
    echo '';
    echo 'BIN = main';
    echo '';
    echo '.PHONY: all run clean';
    echo '';
    echo '$(BIN): $(OBJS)';
    echo '';
    echo 'all: $(BIN)';
    echo '';
    echo 'run: $(BIN)';
    echo '	./$(BIN)';
    echo '';
    echo 'debug: CFLAGS += -g -fsanitize=address';
    echo 'debug: LDLIBS += -lasan';
    echo 'debug: $(BIN)';
    echo '';
    echo '';
    echo 'clean:';
    echo '	$(RM) $(OBJS) $(BIN)';
} >> Makefile

git add Makefile 1>/dev/null 2>/dev/null
git commit -m "build: add Makefile" 1>/dev/null 2>/dev/null

echo '# Created by https://www.toptal.com/developers/gitignore/api/c' > .gitignore
{
    echo '# Edit at https://www.toptal.com/developers/gitignore?templates=c';
    echo '';
    echo '### C ###';
    echo '# Prerequisites';
    echo '*.d';
    echo '';
    echo '# Object files';
    echo '*.o';
    echo '*.ko';
    echo '*.obj';
    echo '*.elf';
    echo '';
    echo '# Linker output';
    echo '*.ilk';
    echo '*.map';
    echo '*.exp';
    echo '';
    echo '# Precompiled Headers';
    echo '*.gch';
    echo '*.pch';
    echo '';
    echo '# Libraries';
    echo '*.lib';
    echo '*.a';
    echo '*.la';
    echo '*.lo';
    echo '';
    echo '# Shared objects (inc. Windows DLLs)';
    echo '*.dll';
    echo '*.so';
    echo '*.so.*';
    echo '*.dylib';
    echo '';
    echo '# Executables';
    echo '*.exe';
    echo '*.out';
    echo '*.app';
    echo '*.i*86';
    echo '*.x86_64';
    echo '*.hex';
    echo '';
    echo '# Debug files';
    echo '*.dSYM/';
    echo '*.su';
    echo '*.idb';
    echo '*.pdb';
    echo '';
    echo '# Kernel Module Compile Results';
    echo '*.mod*';
    echo '*.cmd';
    echo '.tmp_versions/';
    echo 'modules.order';
    echo 'Module.symvers';
    echo 'Mkfile.old';
    echo 'dkms.conf';
    echo '';
    echo '# End of https://www.toptal.com/developers/gitignore/api/c';
    echo '';
    echo '# Binaries';
    echo 'main';
} >> .gitignore

git add .gitignore 1>/dev/null 2>/dev/null
git commit -m "chore: add gitignore" 1>/dev/null 2>/dev/null

git switch master 1>/dev/null 2>/dev/null

# Restore Git identity
git config user.name "$name"
git config user.email "$email"

echo "Finished setting up this place! Have fun!"