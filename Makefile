CC = gcc
CXX = g++
OBJDUMP = objdump

INCLUDES +=
CFLAGS += -g
CXXFLAGS += -g
LDFLAGS +=
LIBS +=
DUMP_FLAGS = -D

ifneq (${INCLUDES}, )
	CFLAGS += -I${INCLUDES}
	CXXFLAGS += -I${INCLUDES}
endif


C_SRC = $(wildcard *.c)
C_TARGET = $(patsubst %.c, %, ${C_SRC})
C_DUMP= $(patsubst %.c, %.dump, ${C_SRC})
CPP_SRC = $(wildcard *.cpp)
CPP_TARGET = $(patsubst %.cpp, %, ${CPP_SRC})
CPP_DUMP= $(patsubst %.cpp, %.dump, ${CPP_SRC})
TARGET = ${C_TARGET} ${CPP_TARGET}
DUMP = ${C_DUMP} ${CPP_DUMP}

all: ${TARGET}

dump: ${DUMP} ${TARGET}

clean:
	@rm -f ${TARGET} ${DUMP}

${C_TARGET}: %: %.c
	${CC} -o $@ $< ${CFLAGS} ${LDFLAGS} ${LIBS}

${CPP_TARGET}: %: %.cpp
	${CXX} -o $@ $< ${CXXFLAGS} ${LDFLAGS} ${LIBS}

${DUMP}: %.dump: %
	${OBJDUMP} ${DUMP_FLAGS} $< > $@
