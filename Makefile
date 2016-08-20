cc ?= g++
flex ?= flex
bison ?= bison

test_file=

# Flex variables
flex_ext= .flex

flex_src= $(wildcard *$(flex_ext))
flex_outfile= test-lex.cc

FLIB= -lfl
FLIB_PATH=
FFLAGS= -d -o${flex_outfile}

# C stuff
csrc= $(wildcard *.c)
cppsrc= $(wildcard *.cpp)

CFLAGS= -g -Wall -Wno-unused -Wno-write-strings

# other
EXE_EXT=

ifeq ($(OS), Windows_NT)
  FLIB_PATH= "C:/msys/usr/lib"
  EXT_EXT= $(flex_src:$(flex_ext)=.exe)
endif

lexer=lexer$(EXE_EXT)

.PHONY: clean distclean
all: lexer

$(lexer) : $(flex_src)
	$(flex) $<
	$(cc) $(CFLAGS) -o $@ lex.yy.c -L$(FLIB_PATH) $(FLIB)

$(flex_outfile) : $(flex_src)
	$(flex) $(FFLAGS) $< $@

test: $(lexer)
	./$(lexer) < $(test_file)

clean:
	$(RM) *.s *.o lex.yy.c *~

distclean: clean
	$(RM) *.exe *.out
