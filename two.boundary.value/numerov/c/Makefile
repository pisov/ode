FC=gcc
CFLAGS=-O3
LDFLAGS=
EXE=fw.x
SRC=fw_numerov.c
OBJ=$(SRC:.c=.o)

all: $(SRC) $(EXE)

$(EXE): $(OBJ)
	$(FC) $(LDFLAGS) $(OBJ) -o $(EXE)


%.o: %.c 
	$(FC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.mod $(OBJ) $(EXE)
