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


EMPTY_SQUARE_VALUE EQU 0b00000000;
OFFBOARD_SQUARE_VALUE EQU 0b000111;

PIECE_ENUM_PAWN     EQU 0b00000001;
PIECE_ENUM_QUEEN    EQU 0b00000110;
PIECE_TYPE_MASK     EQU 0b00000111;

// 0b11xxxx not moved 0b00xxxx already moved

PIECE_COLOUR_MASK  EQU 0b00001000;

// 0bxx1xxx white     0bxx0xxx black
// 0bxxx001 pawn
// 0bxxx010 king
// 0bxxx011 knight
// 0bxxx100 bishop
// 0bxxx101 rook
// 0bxxx110 queen

board:
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 0-9
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 10-19
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 20-29  rank 8
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 30-39  rank 7
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 40-49  rank 6
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 50-59  rank 5
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 60-69  rank 4
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 70-79  rank 3
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 80-89  rank 2
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 90-99  rank 1
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 100-109
DB; DB; DB; DB; DB; DB; DB; DB; DB; DB; // 110-119

// *************************************
// sub_routines

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

LD.B R1, #SQUARE_INDEX_E1;
ST.B global_cursor_square_index, R1;
ST.B global_selected_square_index, R1;

LD.W R2, #board;

LD.B R1, #0b000111;
ST.B (R2++), R1; // 0
ST.B (R2++), R1; // 1
ST.B (R2++), R1; // 2
ST.B (R2++), R1; // 3
ST.B (R2++), R1; // 4
ST.B (R2++), R1; // 5
ST.B (R2++), R1; // 6
ST.B (R2++), R1; // 7
ST.B (R2++), R1; // 8
ST.B (R2++), R1; // 9

ST.B (R2++), R1; // 10
ST.B (R2++), R1; // 11
ST.B (R2++), R1; // 12
ST.B (R2++), R1; // 13
ST.B (R2++), R1; // 14
ST.B (R2++), R1; // 15
ST.B (R2++), R1; // 16
ST.B (R2++), R1; // 17
ST.B (R2++), R1; // 18
ST.B (R2++), R1; // 19

ST.B (R2++), R1; // 20
LD.B R1, #0b110101;
ST.B (R2++), R1; // 21
LD.B R1, #0b110011;
ST.B (R2++), R1; // 22
LD.B R1, #0b110100;
ST.B (R2++), R1; // 23
LD.B R1, #0b110110;
ST.B (R2++), R1; // 24
LD.B R1, #0b110010;
ST.B (R2++), R1; // 25
LD.B R1, #0b110100;
ST.B (R2++), R1; // 26
LD.B R1, #0b110011;
ST.B (R2++), R1; // 27
LD.B R1, #0b110101;
ST.B (R2++), R1; // 28
LD.B R1, #0b000111;
ST.B (R2++), R1; // 29

ST.B (R2++), R1; // 30
LD.B R1, #0b110001;
ST.B (R2++), R1; // 31
ST.B (R2++), R1; // 32
ST.B (R2++), R1; // 33
ST.B (R2++), R1; // 34
ST.B (R2++), R1; // 35
ST.B (R2++), R1; // 36
ST.B (R2++), R1; // 37
ST.B (R2++), R1; // 38
LD.B R1, #0b000111;
ST.B (R2++), R1; // 39

ST.B (R2++), R1; // 40
LD.B R1, #0b000000;
ST.B (R2++), R1; // 41
ST.B (R2++), R1; // 42
ST.B (R2++), R1; // 43
ST.B (R2++), R1; // 44
ST.B (R2++), R1; // 45
ST.B (R2++), R1; // 46
ST.B (R2++), R1; // 47
ST.B (R2++), R1; // 48
LD.B R1, #0b000111;
ST.B (R2++), R1; // 49

ST.B (R2++), R1; // 50
LD.B R1, #0b000000;
ST.B (R2++), R1; // 51
ST.B (R2++), R1; // 52
ST.B (R2++), R1; // 53
ST.B (R2++), R1; // 54
ST.B (R2++), R1; // 55
ST.B (R2++), R1; // 56
ST.B (R2++), R1; // 57
ST.B (R2++), R1; // 58
LD.B R1, #0b000111;
ST.B (R2++), R1; // 59

ST.B (R2++), R1; // 60
LD.B R1, #0b000000;
ST.B (R2++), R1; // 61
ST.B (R2++), R1; // 62
ST.B (R2++), R1; // 63
ST.B (R2++), R1; // 64
ST.B (R2++), R1; // 65
ST.B (R2++), R1; // 66
ST.B (R2++), R1; // 67
ST.B (R2++), R1; // 68
LD.B R1, #0b000111;
ST.B (R2++), R1; // 69

ST.B (R2++), R1; // 70
LD.B R1, #0b000000;
ST.B (R2++), R1; // 71
ST.B (R2++), R1; // 72
ST.B (R2++), R1; // 73
ST.B (R2++), R1; // 74
ST.B (R2++), R1; // 75
ST.B (R2++), R1; // 76
ST.B (R2++), R1; // 77
ST.B (R2++), R1; // 78
LD.B R1, #0b000111;
ST.B (R2++), R1; // 79

ST.B (R2++), R1; // 80
LD.B R1, #0b111001;
ST.B (R2++), R1; // 81
ST.B (R2++), R1; // 82
ST.B (R2++), R1; // 83
ST.B (R2++), R1; // 84
ST.B (R2++), R1; // 85
ST.B (R2++), R1; // 86
ST.B (R2++), R1; // 87
ST.B (R2++), R1; // 88
LD.B R1, #0b000111;
ST.B (R2++), R1; // 89

ST.B (R2++), R1; // 90
LD.B R1, #0b111101;
ST.B (R2++), R1; // 91
LD.B R1, #0b111011;
ST.B (R2++), R1; // 92
LD.B R1, #0b111100;
ST.B (R2++), R1; // 93
LD.B R1, #0b111110;
ST.B (R2++), R1; // 94
LD.B R1, #0b111010;
ST.B (R2++), R1; // 95
LD.B R1, #0b111100;
ST.B (R2++), R1; // 96
LD.B R1, #0b111011;
ST.B (R2++), R1; // 97
LD.B R1, #0b111101;
ST.B (R2++), R1; // 98
LD.B R1, #0b000111;
ST.B (R2++), R1; // 99

ST.B (R2++), R1; // 100
ST.B (R2++), R1; // 101
ST.B (R2++), R1; // 102
ST.B (R2++), R1; // 103
ST.B (R2++), R1; // 104
ST.B (R2++), R1; // 105
ST.B (R2++), R1; // 106
ST.B (R2++), R1; // 107
ST.B (R2++), R1; // 108
ST.B (R2++), R1; // 109

ST.B (R2++), R1; // 110
ST.B (R2++), R1; // 111
ST.B (R2++), R1; // 112
ST.B (R2++), R1; // 113
ST.B (R2++), R1; // 114
ST.B (R2++), R1; // 115
ST.B (R2++), R1; // 116
ST.B (R2++), R1; // 117
ST.B (R2++), R1; // 118
ST.B (R2++), R1; // 119

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

