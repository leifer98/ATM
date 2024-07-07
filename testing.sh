#!/bin/bash

ASM_FILE=$1
TEST_FILE=$2

# Assemble the ASM file
nasm -f elf64 -o output.o $ASM_FILE
if [ $? -ne 0 ]; then
    echo "Assembly failed"
    exit 1
fi

# Link the object file
ld -o output output.o
if [ $? -ne 0 ]; then
    echo "Linking failed"
    exit 1
fi

# Run the output binary with the test file
./output < $TEST_FILE
