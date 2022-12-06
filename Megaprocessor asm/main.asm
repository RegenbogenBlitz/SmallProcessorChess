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
// draw_piece

include "draw_piece.asm";

// *************************************
// Constants

SQUARE_INDEX_A8 EQU 21;

// *************************************
// The program....

draw_board_loop_rank_index: DB;
draw_board_loop_file_index: DB;
draw_board_square_index: DB;

start:
LD.B R0, #8;
ST.B draw_board_loop_rank_index, R0; // loop_rank_index = 8;
ST.B draw_board_loop_file_index, R0; // loop_file_index = 8;

LD.B R1, #SQUARE_INDEX_A8;           // square_index = SQUARE_INDEX_A8;
draw_board_loop:
                                     // do
                                     // {
ST.B draw_board_loop_rank_index, R0;
ST.B draw_board_square_index, R1;
LD.W R0, #return_board_loop;
JMP draw_piece;                      //     draw_piece(Square.A8)
return_board_loop:
LD.B R1, draw_board_square_index;
INC R1;                              //     square_index++;
LD.B R0, draw_board_loop_rank_index;
DEC R0;                              //     loop_rank_index--;
BNE draw_board_loop;                 //     if (loop_rank_index != 0) { continue; }
                                     //     else {
LD.B R0, #8;                         //         loop_rank_index = 8;
ADDQ R1,#2;                          //         square_index += 2;
LD.B R2, draw_board_loop_file_index;
DEC R2;
ST.B draw_board_loop_file_index, R2; //         loop_file_index--;
BNE draw_board_loop;                 //         if (loop_file_index != 0) { continue; } else { break; }
                                     //     }
                                     // }

LD.W R0,#0b0000000000000000;
ST.W (0xA0E0),R0;
ST.W (0xA0E2),R0;
ST.W (0xA0E4),R0;
ST.W (0xA0E6),R0;
ST.W (0xA0E8),R0;
ST.W (0xA0EA),R0;
ST.W (0xA0EC),R0;
ST.W (0xA0EE),R0;
ST.W (0xA0F0),R0;
ST.W (0xA0F2),R0;
ST.W (0xA0F4),R0;
ST.W (0xA0F6),R0;
ST.W (0xA0F8),R0;
ST.W (0xA0FA),R0;
ST.W (0xA0FC),R0;
ST.W (0xA0FE),R0;

infinite_loop:
NOP;
JMP infinite_loop;