// *************************************
// Sprites

black_square_sprite:
DB 0b00000000; // left
DB 0b00001010;
DB 0b00000100;
DB 0b00001010;
DB 0b00000100;
DB 0b00001010;
DB 0b00000100;

DB 0b00000000; // right
DB 0b10100000;
DB 0b01000000;
DB 0b10100000;
DB 0b01000000;
DB 0b10100000;
DB 0b01000000;

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

white_square_sprite:
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

white_pawn_sprite:
DB 0b00000000; // left
DB 0b00000000;
DB 0b00000100; //  █
DB 0b00001010; // █ █
DB 0b00000110; // ██
DB 0b00000010; // █
DB 0b00000010; // █

DB 0b00000000; // right
DB 0b00000000;
DB 0b01000000; //  █
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
DB 0b00001100; //  ██
DB 0b00001010; // █ █
DB 0b00001100; //  ██
DB 0b00001000; //   █
DB 0b00001000; //   █

DB 0b00000000; // right
DB 0b00000000;
DB 0b11000000; //  ██
DB 0b10100000; // █ █
DB 0b11000000; //  ██
DB 0b10000000; //   █
DB 0b10000000; //   █

piece_sprite_addresses:
DW black_square_sprite;
DW black_pawn_sprite;
DW black_king_sprite;
DW black_knight_sprite;
DW black_bishop_sprite;
DW black_rook_sprite;
DW black_queen_sprite;
DW;
DW white_square_sprite;
DW white_pawn_sprite;
DW white_king_sprite;
DW white_knight_sprite;
DW white_bishop_sprite;
DW white_rook_sprite;
DW white_queen_sprite;


// *************************************
// Constants

INT_RAM_START EQU 0xA000;

// *************************************

draw_piece_return_address: DW;
draw_piece_sprite_address: DW;
NOP;
NOP;
NOP;

draw_piece:
                                            // void draw_piece(square_index) R0 return_address, R1 square_index
                                            // {
ST.W draw_piece_return_address, R0;

LD.B R2, #board;
ADD R2,R1;
LD.B R0, (R2);                              //     board_value = board[square_index]; 

LD.B R3, #0b00001111;
AND R0, R3;                                 //     piece_value = board_value & 0b00001111;
BNE draw_piece_empty_square_check_end;      //     if (piece_value != 0) {}
                                            //     else
                                            //     {
LD.B R3, #0b00000001;
AND R3, R1;
BEQ draw_piece_even_square_check_end;       //         if (square_index % 2 == 0) {}
                                            //         else {
LD.B R3, #0b00001000;
XOR R0, R3;                                 //             piece_value ^= 0b1000;
                                            //         }
draw_piece_even_square_check_end:

MOVE R2,R1;                                 //         for(n = square_index; square_index > 0; n-=10)
draw_piece_square_colour_loop:              //         {
LD.B R3, #0b00001010;
SUB R2,R3;
BMI draw_piece_empty_square_check_end;
LD.B R3, #0b00001000;
XOR R0, R3;                                 //             piece_value ^= 0b1000;
JMP draw_piece_square_colour_loop;          //         }
                                            //     }
draw_piece_empty_square_check_end:



LD.W R2, #piece_sprite_addresses;
ADD R2,R0;
ADD R2,R0; // twice because each address is a word
LD.W R0, (R2);
ST.W draw_piece_sprite_address,R0;          //     piece_sprite_address = piece_sprite_addresses[piece_value]; 

LD.W R2, #INT_RAM_START;                    //     led_byte_address = INT_RAM_START;

LD.B R0, #21;
SUB R1, R0;  // (square_index - 21) will send A8 to 0, B8 to 1 .... A7 to 10 .... A1 to 70 etc.

MOVE R0, R1; // move R1 to R0
LD.B R3, #40;
SUB R0,R3;
BMI draw_piece_rank_is_8_7_6_5;             //     if (square_index < 40) {}
                                            //     else
                                            //     {
MOVE R1,R0;                                 //         square_index -= 40;
LD.W R3,#0x0070;
ADD R2,R3;                                  //         led_byte_address += 0x0070;
draw_piece_rank_is_8_7_6_5:                 //     }

MOVE R0, R1; // move R1 to R0
LD.B R3, #20;
SUB R0,R3;
BMI draw_piece_rank_is_8_7_4_3;             //     if (square_index < 20) {}
                                            //     else
                                            //     {
MOVE R1,R0;                                 //         square_index -= 20;
LD.W R3,#0x0038;
ADD R2,R3;                                  //         led_byte_address += 0x0038;
draw_piece_rank_is_8_7_4_3:                 //     }

MOVE R0, R1; // move R1 to R0
LD.B R3, #10;
SUB R0,R3;
BMI draw_piece_rank_is_8_6_4_2;             //     if (square_index < 10) {}
                                            //     else
                                            //     {
MOVE R1,R0;                                 //         square_index -= 10;
LD.W R3,#0x001C;
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

JMP draw_piece_end_draw_sprite;
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
draw_piece_end_draw_sprite:


LD.W R0, draw_piece_return_address;
JMP (R0);                                   //     return;
                                            // }