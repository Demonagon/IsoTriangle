#Makefile par Pacôme Perrotin

CODE_FORMAT = cpp
HEADER_FORMAT = h
OBJECT_FORMAT = o
#Dossier contenant les .CODE_FORMAT :
CREP = src
#Dossier contenant les .HEADER_FORMAT :
HREP = src
#Dossier contenant les .OBJECT_FORMAT :
OREP = obj
#Dossier contenant les executables :
BREP = bin
#Nom de l'executable :
BIN = iso-triangle
#Nom du compilateur :
CC = clang++

INCLUDE = -I/usr/local/include -I/usr/include
FLAGS = -L/usr/local/lib -L/usr/lib -L../game-core/lib -Wall -std=c++11 -pthread
LIBS = -lgame-core

#Pour chaque a.c dans CREP, on considère le module a
RAW_CODE = $(shell echo $(CREP)/*.$(CODE_FORMAT))
CODE = $(RAW_CODE:$(CREP)/%.$(CODE_FORMAT)=%)

CFILES = $(CODE:%=%.$(CODE_FORMAT))
HDR = $(CODE:%=%.$(HEADER_FORMAT))

SRC = $(CFILES) $(HDR)

OBJ = $(CODE:%=%.$(OBJECT_FORMAT))
OBJ_OUT = $(OBJ:%=$(OREP)/%)

BIN_OUT = $(BIN:%=$(BREP)/%)

vpath %.$(CODE_FORMAT) $(CREP)
vpath %.$(HEADER_FORMAT) $(HREP)
vpath %.$(OBJECT_FORMAT) $(OREP)

all: $(SRC) $(BIN)

$(BIN): $(OBJ)
	$(CC) $(FLAGS) $(OBJ_OUT) $(INCLUDE) -o $(BREP)/$@ $(LIBS)

%.$(OBJECT_FORMAT): %.$(CODE_FORMAT)
	$(CC) $(FLAGS) $< $(INCLUDE) -c -o $(OREP)/$@ $(LIBS)

clear:
	-rm $(BIN_OUT)
	-rm $(OBJ_OUT)

open :
	gedit src/* &
