CC = gcc
CFLAGS = -Wall -Wextra -pedantic
LDFLAGS =

BISON = bison
FLEX = flex

SRC_PARSER = nc_parser.y
SRC_LEXER = nc_lexer.l

TARGET = nc_parser
OUTPUT_DIR = result

all: $(OUTPUT_DIR)/$(TARGET)

$(OUTPUT_DIR)/$(TARGET): $(OUTPUT_DIR)/nc_parser.tab.c $(OUTPUT_DIR)/lex.yy.c | $(OUTPUT_DIR)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(OUTPUT_DIR)/nc_parser.tab.c $(OUTPUT_DIR)/nc_parser.tab.h: $(SRC_PARSER) | $(OUTPUT_DIR)
	$(BISON) -d -o $(OUTPUT_DIR)/nc_parser.tab.c $(SRC_PARSER)

$(OUTPUT_DIR)/lex.yy.c: $(SRC_LEXER) $(OUTPUT_DIR)/nc_parser.tab.h | $(OUTPUT_DIR)
	$(FLEX) -o $@ $(SRC_LEXER)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: all clean