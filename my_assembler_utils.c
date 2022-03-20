/*****************************************************************
 * BUAA Fall 2021 Fundamentals of Computer Hardware
 * Project7 Assembler and Linker
 *****************************************************************
 * my_assembler_utils.c
 * Assembler Submission
 * hua kai yi ji ye luo yi di
 *****************************************************************/
#include "my_assembler_utils.h"
#include "assembler-src/assembler_utils.h"
#include "lib/translate_utils.h"

#include <string.h>
#include <stdlib.h>

#define MAXL (1086)

/*
 * This function reads .data symbol from INPUT and add them to the SYMTBL
 * Note that in order to distinguish in the symbol table whether a symbol
 * comes from the .data segment or the .text segment, we append a % to the
 * symbol name when adding the .data segment symbol. Since only underscores and
 * letters will appear in legal symbols, distinguishing them by adding % will
 * not cause a conflict between the new symbol and the symbol in the assembly file.
 *
 * Return value:
 * Return the number of bytes in the .data segment.
 */
int read_data_segment(FILE *input, SymbolTable *symtbl)
{
    char str[MAXL];
    char *token;
    int data_sz = 0;
    fgets(str, MAXL, input); // ".data"
    while (fgets(str, MAXL, input))
    {
        if (str[0] == '\n')
            break;
        skip_comment(str);
        token = strtok(str, ASSEMBLER_IGNORE_CHARS); // "Label:"
        if (token == NULL)
            continue;
        token[strlen(token) - 1] = '\0'; // "Label"
        if (is_valid_label(token))
        {
            char sym_name[MAXL] = "%";
            strcat(sym_name, token); // "%Label"
            add_to_table(symtbl, sym_name, data_sz);
            token = strtok(NULL, ASSEMBLER_IGNORE_CHARS); // ".space"
            token = strtok(NULL, ASSEMBLER_IGNORE_CHARS); // "number_of_bytes"
            long int add_data_sz;
            translate_num(&add_data_sz, token, INT16_MIN, INT16_MAX);
            data_sz += add_data_sz;
        }
    }
    return data_sz;
}

/* Adds a new symbol and its address to the SymbolTable pointed to by TABLE.
 * ADDR is given as the byte offset from the first instruction. The SymbolTable
 * must be able to resize itself as more elements are added.
 *
 * Note that NAME may point to a temporary array, so it is not safe to simply
 * store the NAME pointer. You must store a copy of the given string.
 *
 * If ADDR is not word-aligned, you should call addr_alignment_incorrect() and
 * return -1. If the table's mode is SYMTBL_UNIQUE_NAME and NAME already exists
 * in the table, you should call name_already_exists() and return -1. If memory
 * allocation fails, you should call allocation_failed().And alloction_failed()
 * will print error message and exit with error code 1.
 *
 * Otherwise, you should store the symbol name and address and return 0.
 */
int add_to_table(SymbolTable *table, const char *name, uint32_t addr)
{
    /* If ADDR is not word-aligned, 
     * you should call addr_alignment_incorrect() and return -1.
     */
    if (addr % 4)
    {
        addr_alignment_incorrect();
        return -1;
    }

    /* If the table's mode is SYMTBL_UNIQUE_NAME and NAME already exists in the table, 
     * you should call name_already_exists() and return -1.
     */
    if (table->mode == SYMTBL_UNIQUE_NAME && get_addr_for_symbol(table, name) != -1)
    {
        name_already_exists(name);
        return -1;
    }

    // for (int i = 0; i < table->len; i++)
    //     if (strcmp(t[i].name, name) == 0 && table->mode)
    //     {
    //         name_already_exists(name);
    //         return -1;
    //     }

    /* If table is full.
     * If memory allocation fails, you should call allocation_failed(). 
     * And alloction_failed() will print error message and exit with error code 1.
     */
    if (table->len == table->cap)
    {
        table->cap *= SCALING_FACTOR;
        table->tbl = (Symbol *)realloc(table->tbl, table->cap * sizeof(Symbol));
        if (table->tbl == NULL)
        {
            allocation_failed();
            return -1;
        }
    }

    char *copy_name = create_copy_of_str(name);
    Symbol sym;
    sym.addr = addr;
    sym.name = copy_name;
    table->tbl[table->len++] = sym;

    // Symbol *temp = (Symbol *)malloc(sizeof(Symbol));
    // // temp->name = (char *)malloc(sizeof(name) * 4 + 1);
    // // strcpy(temp->name, name);
    // temp->name = create_copy_of_str(name);
    // temp->addr = addr;
    // table->tbl[table->len++] = *temp;

    return 0;
}

/*
 * Convert lui instructions to machine code. Note that for the imm field of lui,
 * it may be an immediate number or a symbol and needs to be handled separately.
 * Output the instruction to the **OUTPUT**.(Consider using write_inst_hex()).
 * 
 * Return value:
 * 0 on success, -1 otherwise.
 * 
 * Arguments:
 * opcode:     op segment in MIPS machine code
 * args:       args[0] is the $rt register, and args[1] can be either an imm field or 
 *             a .data segment label. The other cases are illegal and need not be considered
 * num_args:   length of args array
 * addr:       Address offset of the current instruction in the file
 */
int write_lui(uint8_t opcode, FILE *output, char **args, size_t num_args, uint32_t addr, SymbolTable *reltbl)
{
    int rt = translate_reg(args[0]);
    long imm16 = 0;
    unsigned op = opcode;
    if (translate_num(&imm16, args[1], INT32_MIN, INT32_MAX))
    {
        imm16 = 0;
        char *label = create_copy_of_str(args[1]);
        label[strlen(label) - 3] = '\0'; // delete "@Hi"
        if (is_valid_label(label))
            add_to_table(reltbl, args[1], addr);
    }

    unsigned instr = 0;
    instr |= (imm16 & 0xffff);
    instr |= (rt << 16);
    instr |= (op << 26);
    write_inst_hex(output, instr);

    return 0;
}
