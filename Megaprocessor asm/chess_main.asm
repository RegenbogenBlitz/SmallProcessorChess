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

// Board representation

//  xxxxxxxxxx
//  xxxxxxxxxx
//  xRHBQKBHRx
//  xPPPPPPPPx
//  x........x
//  x........x
//  xppppppppx
//  xrhbqkbhrx
//  xxxxxxxxxx
//  xxxxxxxxxx

// Coordinates
//  x  x  x  x  x  x  x  x  x  x
//  x  x  x  x  x  x  x  x  x  x
//  x 21 22 23 24 25 26 27 28  x
//  x 31 32 33 34 35 36 37 38  x
//  x 41 42 43 44 45 46 47 48  x
//  x 51 52 53 54 55 56 57 58  x
//  x 61 62 63 64 65 66 67 68  x
//  x 71 72 73 74 75 76 77 78  x
//  x 81 82 83 84 85 86 87 88  x
//  x 91 92 93 94 95 96 97 98  x
//  x  x  x  x  x  x  x  x  x  x
//  x  x  x  x  x  x  x  x  x  x

// Main Representation
//  7  7  7  7  7  7  7  7  7  7
//  7  7  7  7  7  7  7  7  7  7
//  7  5  3  4  6  2  4  3  5  7
//  7  1  1  1  1  1  1  1  1  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  9  9  9  9  9  9  9  9  7
//  7 13 11 12 14 10 12 11 13  7
//  7  7  7  7  7  7  7  7  7  7
//  7  7  7  7  7  7  7  7  7  7

// Initial Representation
//  7  7  7  7  7  7  7  7  7  7
//  7  7  7  7  7  7  7  7  7  7
//  7 53 51 52 54 50 52 51 53  7
//  7 49 49 49 49 49 49 49 49  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7  0  0  0  0  0  0  0  0  7
//  7 57 57 57 57 57 57 57 57  7
//  7 61 59 60 62 58 60 59 61  7
//  7  7  7  7  7  7  7  7  7  7
//  7  7  7  7  7  7  7  7  7  7

// 0b000111 offboard
// 0b11xxxx not moved 0b00xxxx already moved
// 0bxx1xxx white     0bxx0xxx black
// 0bxxx001 pawn
// 0bxxx010 king
// 0bxxx011 knight
// 0bxxx100 bishop
// 0bxxx101 rook
// 0bxxx110 queen

board:
DB 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111; // 0-9
DB 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111; // 10-19
DB 0b000111, 0b110101, 0b110011, 0b110100, 0b110110, 0b110010, 0b110100, 0b110011, 0b110101, 0b000111; // 20-29  rank 8
DB 0b000111, 0b110001, 0b110001, 0b110001, 0b110001, 0b110001, 0b110001, 0b110001, 0b110001, 0b000111; // 30-39  rank 7
DB 0b000111, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000111; // 40-49  rank 6
DB 0b000111, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000111; // 50-59  rank 5
DB 0b000111, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000111; // 60-69  rank 4
DB 0b000111, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000000, 0b000111; // 70-79  rank 3
DB 0b000111, 0b111001, 0b111001, 0b111001, 0b111001, 0b111001, 0b111001, 0b111001, 0b111001, 0b000111; // 80-89  rank 2
DB 0b000111, 0b111101, 0b111011, 0b111100, 0b111110, 0b111010, 0b111100, 0b111011, 0b111101, 0b000111; // 90-99  rank 1
DB 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111; // 100-109
DB 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111, 0b000111; // 110-119

// *************************************
// sub_routines

include "draw_piece.asm";
include "draw_board.asm";

// *************************************

// Constants

SQUARE_INDEX_A8 EQU 21;
SQUARE_INDEX_A1 EQU 91;


// To handle the peripherals:
PERIPHERALS_BASE                equ     0x8000;
GEN_IO_BASE                     equ     PERIPHERALS_BASE + 0x30;
GEN_IO_INPUT                    equ     GEN_IO_BASE + 2;

// (Switches are HIGH by "default", and go LOW on being pressed).
IO_SWITCH_FLAG_UP               EQU     0x0001;
IO_SWITCH_FLAG_DOWN             EQU     0x0002;
IO_SWITCH_FLAG_LEFT             EQU     0x0004;
IO_SWITCH_FLAG_RIGHT            EQU     0x0008;

// *************************************
// The program....

global_new_cursor_square: DB SQUARE_INDEX_A1;
global_displayed_cursor_square: DB SQUARE_INDEX_A1;

NOP;
NOP;
NOP;

start:
LD.W R0, #main_return_from_draw_board;
JMP draw_board;                          // draw_board()
main_return_from_draw_board:
NOP;

infinite_loop:                           // do {
NOP;

LD.B R1, global_displayed_cursor_square;
LD.W R0, #main_return_from_draw_piece;
JMP draw_piece;                          //         draw_piece(global_displayed_cursor_square)
main_return_from_draw_piece:
NOP;

include "get_input.asm";                 //         var input = get_input();

JMP infinite_loop;                       // } loop

