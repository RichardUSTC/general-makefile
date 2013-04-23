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
CXX_SRC = $(wildcard *.cpp)
CXX_TARGET = $(patsubst %.cpp, %, ${CXX_SRC})
CXX_DUMP= $(patsubst %.cpp, %.dump, ${CXX_SRC})
TARGET = ${C_TARGET} ${CXX_TARGET}
DUMP = ${C_DUMP} ${CXX_DUMP}

all: ${TARGET}

dump: ${DUMP} ${TARGET}

clean:
	@rm -f ${TARGET} ${DUMP}

${C_TARGET}: %: %.c
	${CC} -o $@ $< ${CFLAGS} ${LDFLAGS} ${LIBS}

${CXX_TARGET}: %: %.cpp
	${CXX} -o $@ $< ${CXXFLAGS} ${LDFLAGS} ${LIBS}

${DUMP}: %.dump: %
	${OBJDUMP} ${DUMP_FLAGS} $< > $@
