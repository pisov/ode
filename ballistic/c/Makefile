CC=gcc
CFLAGS=-O3
LDFLAGS=-lm
EXE=ballistic.x
SRC=ballistic.c
OBJ=$(SRC:.c=.o)

all: $(SRC) $(EXE)

$(EXE): $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ) -o $(EXE)


%.o: %.c 
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(EXE)
