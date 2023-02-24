// **************************************
// vectors

ORG 0;

reset:
JMP start;
NOP;

ext_int:
RETI;
NOP;
NOP;
NOP;

div_zero:
RETI;
NOP;
NOP;
NOP;

illegal:
RETI;
NOP;
NOP;
NOP;


// *************************************
// sub_routines

include "calculate.asm";
include "draw_piece.asm";
include "draw_board.asm";

// *************************************

// Constants

SQUARE_INDEX_A8 EQU 21;
SQUARE_INDEX_E1 EQU 95;

// To handle the peripherals:
PERIPHERALS_BASE                equ     0x8000;
GEN_IO_BASE                     equ     PERIPHERALS_BASE + 0x30;
GEN_IO_INPUT                    equ     GEN_IO_BASE + 2;

// *************************************
// The program....

global_cursor_square_index: DB;
global_selected_square_index: DB;

NOP;
NOP;
NOP;

start:
LD.W R0, #0x8000;
MOVE SP, R0; // reset SP

JSR calculate__reset;

LD.B R1, #SQUARE_INDEX_E1;
ST.B global_cursor_square_index, R1;
ST.B global_selected_square_index, R1;

LD.W R0, #main_return_from_draw_board;
JMP draw_board;                              // draw_board()
main_return_from_draw_board:
NOP;

infinite_loop:                               // do {
NOP;

LD.W R2, draw_piece_selected_flash_state;
INV R2;
ST.W draw_piece_selected_flash_state, R2;    //     draw_piece_selected_flash_state~~;

LD.B R1, global_cursor_square_index;
LD.W R0, #main_return_from_draw_piece_for_cursor_square;
JMP draw_piece;                              //     draw_piece(global_cursor_square_index)
main_return_from_draw_piece_for_cursor_square:

LD.B R1, global_selected_square_index;
LD.W R0, #main_return_from_draw_piece_for_selected_square;
JMP draw_piece;                              //     draw_piece(global_selected_square_index)
main_return_from_draw_piece_for_selected_square:
NOP;

include "get_input.asm";                     //     var input = get_input();

include "handle_input.asm";

JMP infinite_loop;                           // } loop

