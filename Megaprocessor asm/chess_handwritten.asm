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

empty_square_sprite:
DB 0b00000000; // left
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;

DB 0b00000000; // right
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;

black_pawn_sprite:
DB 0b00000000; // left
DB 0b00001110; // ███
DB 0b00001010; // █ █
DB 0b00001110; // ███
DB 0b00000010; // █
DB 0b00000010; // █
DB 0b00000010; // █

DB 0b00000000; // right
DB 0b11100000; // ███
DB 0b10100000; // █ █
DB 0b11100000; // ███
DB 0b00100000; // █
DB 0b00100000; // █
DB 0b00100000; // █

black_king_sprite:
DB 0b00000000; // left
DB 0b00001010; // █ █
DB 0b00001010; // █ █
DB 0b00000110; // ██
DB 0b00001010; // █ █
DB 0b00001010; // █ █
DB 0b00001010; // █ █

DB 0b00000000; // right
DB 0b10100000; // █ █
DB 0b10100000; // █ █
DB 0b01100000; // ██
DB 0b10100000; // █ █
DB 0b10100000; // █ █
DB 0b10100000; // █ █

black_knight_sprite:
DB 0b00000000; // left
DB 0b00001010; // █ █
DB 0b00001010; // █ █
DB 0b00001110; // ███
DB 0b00001010; // █ █
DB 0b00001010; // █ █
DB 0b00001010; // █ █

DB 0b00000000; // right
DB 0b10100000; // █ █
DB 0b10100000; // █ █
DB 0b11100000; // ███
DB 0b10100000; // █ █
DB 0b10100000; // █ █
DB 0b10100000; // █ █

black_bishop_sprite:
DB 0b00000000; // left
DB 0b00001110; // ███
DB 0b00001010; // █ █
DB 0b00000110; // ██
DB 0b00001010; // █ █
DB 0b00001010; // █ █
DB 0b00001110; // ███

DB 0b00000000; // right
DB 0b11100000; // ███
DB 0b10100000; // █ █
DB 0b01100000; // ██
DB 0b10100000; // █ █
DB 0b10100000; // █ █
DB 0b11100000; // ███

black_rook_sprite:
DB 0b00000000; // left
DB 0b00001110; // ███
DB 0b00001010; // █ █
DB 0b00001110; // ███
DB 0b00000110; // ██
DB 0b00001010; // █ █
DB 0b00001010; // █ █

DB 0b00000000; // right
DB 0b11100000; // ███
DB 0b10100000; // █ █
DB 0b11100000; // ███
DB 0b01100000; // ██
DB 0b10100000; // █ █
DB 0b10100000; // █ █

black_queen_sprite:
DB 0b00000000; // left
DB 0b00001110; // ███
DB 0b00001010; // █ █
DB 0b00001010; // █ █
DB 0b00001010; // █ █
DB 0b00000110; // ██
DB 0b00001000; //   █

DB 0b00000000; // right
DB 0b11100000; // ███
DB 0b10100000; // █ █
DB 0b10100000; // █ █
DB 0b10100000; // █ █
DB 0b01100000; // ██
DB 0b10000000; //   █

white_pawn_sprite:
DB 0b00000000; // left
DB 0b00000000;
DB 0b00000110; // ██
DB 0b00001010; // █ █
DB 0b00000110; // ██
DB 0b00000010; // █
DB 0b00000010; // █

DB 0b00000000; // right
DB 0b00000000;
DB 0b01100000; // ██
DB 0b10100000; // █ █
DB 0b01100000; // ██
DB 0b00100000; // █
DB 0b00100000; // █

white_king_sprite:
DB 0b00000000; // left
DB 0b00000000;
DB 0b00000010; // █
DB 0b00000010; // █
DB 0b00001010; // █ █
DB 0b00000110; // ██
DB 0b00001010; // █ █

DB 0b00000000; // right
DB 0b00000000;
DB 0b00100000; // █
DB 0b00100000; // █
DB 0b10100000; // █ █
DB 0b01100000; // ██
DB 0b10100000; // █ █

white_knight_sprite:
DB 0b00000000; // left
DB 0b00000000;
DB 0b00000010; // █
DB 0b00000010; // █
DB 0b00000110; // ██
DB 0b00001010; // █ █
DB 0b00001010; // █ █

DB 0b00000000; // right
DB 0b00000000;
DB 0b00100000; // █
DB 0b00100000; // █
DB 0b01100000; // ██
DB 0b10100000; // █ █
DB 0b10100000; // █ █

white_bishop_sprite:
DB 0b00000000; // left
DB 0b00000000;
DB 0b00000010; // █
DB 0b00000010; // █
DB 0b00000110; // ██
DB 0b00001010; // █ █
DB 0b00000110; // ██

DB 0b00000000; // right
DB 0b00000000;
DB 0b00100000; // █
DB 0b00100000; // █
DB 0b01100000; // ██
DB 0b10100000; // █ █
DB 0b01100000; // ██

white_rook_sprite:
DB 0b00000000; // left
DB 0b00000000;
DB 0b00000000;
DB 0b00000100; //  █
DB 0b00001010; // █ █
DB 0b00000010; // █
DB 0b00000010; // █

DB 0b00000000; // right
DB 0b00000000;
DB 0b00000000;
DB 0b01000000; //  █
DB 0b10100000; // █ █
DB 0b00100000; // █
DB 0b00100000; // █

white_queen_sprite:
DB 0b00000000; // left
DB 0b00000000;
DB 0b00000100; //  █
DB 0b00001010; // █ █
DB 0b00001100; //  ██
DB 0b00001000; //   █
DB 0b00001000; //   █

DB 0b00000000; // right
DB 0b00000000;
DB 0b01000000; //  █
DB 0b10100000; // █ █
DB 0b11000000; //  ██
DB 0b10000000; //   █
DB 0b10000000; //   █

piece_sprite_addresses:
DW empty_square_sprite;
DW black_pawn_sprite;
DW black_king_sprite;
DW black_knight_sprite;
DW black_bishop_sprite;
DW black_rook_sprite;
DW black_queen_sprite;
DW;
DW;
DW white_pawn_sprite;
DW white_king_sprite;
DW white_knight_sprite;
DW white_bishop_sprite;
DW white_rook_sprite;
DW white_queen_sprite;


// *************************************
// Constants

INT_RAM_START EQU 0xA000;

SQUARE_INDEX_A8 EQU 21;

// *************************************
// draw_piece

draw_piece_return_address: DW;
draw_piece_square_index: DB;
draw_piece_sprite_address: DW;
NOP;
NOP;
NOP;

draw_piece:
                                            // void draw_piece(square_index)
                                            // {
ST.W draw_piece_return_address, R0;
ST.B draw_piece_square_index, R1;

LD.B R2, #board;
ADD R2,R1;
LD.B R0, (R2);                              //     board_value = board[square_index]; 

LD.B R3, #0b00001111;
AND R0, R3;                                 //     piece_value = board_value & 0b00001111; 

LD.W R2, #piece_sprite_addresses;
ADD R2,R0;
ADD R2,R0; // twice because each address is a word
LD.W R0, (R2);
ST.B draw_piece_sprite_address,R0;          //     piece_sprite_address = piece_sprite_addresses[piece_value]; 

LD.B R1, draw_piece_square_index;
LD.W R2, #INT_RAM_START;                    //     led_byte_address = INT_RAM_START;

LD.B R0, #21;
SUB R1, R0;  // (square_index - 21) will send A8 to 0, B8 to 1 .... A7 to 10 etc.

MOVE R0, R1; // move R1 to R0
LD.B R3, #40;
SUB R0,R3;
BMI draw_piece_rank_is_8_7_6_5;             //     if (square_index < 40) {}
                                            //     else
                                            //     {
SUB R1,R3;                                  //         square_index -= 40;
ADD R2,R3;                                  //         led_byte_address += 0x0070;
draw_piece_rank_is_8_7_6_5:                 //     }

MOVE R0, R1; // move R1 to R0
LD.B R3, #20;
SUB R0,R3;
BMI draw_piece_rank_is_8_7_4_3;             //     if (square_index < 20) {}
                                            //     else
                                            //     {
SUB R1,R3;                                  //         square_index -= 20;
ADD R2,R3;                                  //         led_byte_address += 0x0038;
draw_piece_rank_is_8_7_4_3:                 //     }

MOVE R0, R1; // move R1 to R0
LD.B R3, #10;
SUB R0,R3;
BMI draw_piece_rank_is_8_6_4_2;             //     if (square_index < 10) {}
                                            //     else
                                            //     {
SUB R1,R3;                                  //         square_index -= 10;
ADD R2,R3;                                  //         led_byte_address += 0x001C;
draw_piece_rank_is_8_6_4_2:                 //     }

BTST R1,#2;
BEQ draw_piece_file_is_A_B_C_D;             //     if (square_index & 00000100 == 0) {}
                                            //     else
                                            //     {
LD.W R3,#0x0002;
ADD R2,R3;                                  //         led_byte_address += 0x0002;
draw_piece_file_is_A_B_C_D:                 //     }

BTST R1,#1;
BEQ draw_piece_rank_is_A_B_E_F;             //     if (square_index & 00000010 == 0) {}
                                            //     else
                                            //     {
LD.W R3,#0x0001;
ADD R2,R3;                                  //         led_byte_address += 0x0001;
draw_piece_rank_is_A_B_E_F:                 //     }

LD.W R3,draw_piece_sprite_address;          //     piece_sprite_row_address = piece_sprite_address;

BTST R1,#0;
BEQ draw_piece_rank_is_A_C_E_G;             //     if (square_index & 00000001 == 0) {}
                                            //     else
                                            //     {
LD.W R1, #7;
ADD R3,R1;                                  //         piece_sprite_row_address += 7;

include "draw_right_sprite_row.asm";        //         piece_sprite_row_address = draw_right_sprite_row(piece_sprite_row_address);
include "draw_right_sprite_row.asm";        //         piece_sprite_row_address = draw_right_sprite_row(piece_sprite_row_address);
include "draw_right_sprite_row.asm";        //         piece_sprite_row_address = draw_right_sprite_row(piece_sprite_row_address);
include "draw_right_sprite_row.asm";        //         piece_sprite_row_address = draw_right_sprite_row(piece_sprite_row_address);
include "draw_right_sprite_row.asm";        //         piece_sprite_row_address = draw_right_sprite_row(piece_sprite_row_address);
include "draw_right_sprite_row.asm";        //         piece_sprite_row_address = draw_right_sprite_row(piece_sprite_row_address);
include "draw_right_sprite_row.asm";        //         piece_sprite_row_address = draw_right_sprite_row(piece_sprite_row_address);

JMP draw_piece_rank_is_end_draw_sprite;
draw_piece_rank_is_A_C_E_G:                 //     }
NOP;
                                            //     if (square_index & 00000001 == 0)
                                            //     {

include "draw_left_sprite_row.asm";          //         piece_sprite_row_address = draw_left_sprite_row(piece_sprite_row_address);
include "draw_left_sprite_row.asm";          //         piece_sprite_row_address = draw_left_sprite_row(piece_sprite_row_address);
include "draw_left_sprite_row.asm";          //         piece_sprite_row_address = draw_left_sprite_row(piece_sprite_row_address);
include "draw_left_sprite_row.asm";          //         piece_sprite_row_address = draw_left_sprite_row(piece_sprite_row_address);
include "draw_left_sprite_row.asm";          //         piece_sprite_row_address = draw_left_sprite_row(piece_sprite_row_address);
include "draw_left_sprite_row.asm";          //         piece_sprite_row_address = draw_left_sprite_row(piece_sprite_row_address);
include "draw_left_sprite_row.asm";          //         piece_sprite_row_address = draw_left_sprite_row(piece_sprite_row_address);

                                            //     }
draw_piece_rank_is_end_draw_sprite:


LD.W R0, draw_piece_return_address;
JMP (R0);                                   //     return;
                                            // }

// *************************************
// The program....
start:

                                            // draw_piece(Square.A8)
LD.B R1, #SQUARE_INDEX_A8;
LD.W R0, #return_start_0;
JMP draw_piece;
return_start_0:
NOP;

infinite_loop:
NOP;
JMP infinite_loop;