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

empty_square_representation:
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;

black_pawn_representation:
DB 0b00000000;
DB 0b11101110; // ███
DB 0b10101010; // █ █
DB 0b11101110; // ███
DB 0b00100010; // █
DB 0b00100010; // █
DB 0b00100010; // █

black_king_representation:
DB 0b00000000;
DB 0b10101010; // █ █
DB 0b10101010; // █ █
DB 0b01100110; // ██
DB 0b10101010; // █ █
DB 0b10101010; // █ █
DB 0b10101010; // █ █

black_knight_representation:
DB 0b00000000;
DB 0b10101010; // █ █
DB 0b10101010; // █ █
DB 0b11101110; // ███
DB 0b10101010; // █ █
DB 0b10101010; // █ █
DB 0b10101010; // █ █

black_bishop_representation:
DB 0b00000000;
DB 0b11101110; // ███
DB 0b10101010; // █ █
DB 0b01100110; // ██
DB 0b10101010; // █ █
DB 0b10101010; // █ █
DB 0b11101110; // ███

black_rook_representation:
DB 0b00000000;
DB 0b11101110; // ███
DB 0b10101010; // █ █
DB 0b11101110; // ███
DB 0b01100110; // ██
DB 0b10101010; // █ █
DB 0b10101010; // █ █

black_queen_representation:
DB 0b00000000;
DB 0b11101110; // ███
DB 0b10101010; // █ █
DB 0b10101010; // █ █
DB 0b10101010; // █ █
DB 0b01100110; // ██
DB 0b10001000; //   █

white_pawn_representation:
DB 0b00000000;
DB 0b00000000;
DB 0b01100110; // ██
DB 0b10101010; // █ █
DB 0b01100110; // ██
DB 0b00100010; // █
DB 0b00100010; // █

white_king_representation:
DB 0b00000000;
DB 0b00000000;
DB 0b00100010; // █
DB 0b00100010; // █
DB 0b10101010; // █ █
DB 0b01100110; // ██
DB 0b10101010; // █ █

white_knight_representation:
DB 0b00000000;
DB 0b00000000;
DB 0b00100010; // █
DB 0b00100010; // █
DB 0b01100110; // ██
DB 0b10101010; // █ █
DB 0b10101010; // █ █

white_bishop_representation:
DB 0b00000000;
DB 0b00000000;
DB 0b00100010; // █
DB 0b00100010; // █
DB 0b01100110; // ██
DB 0b10101010; // █ █
DB 0b01100110; // ██ 

white_rook_representation:
DB 0b00000000;
DB 0b00000000;
DB 0b00000000;
DB 0b01000100; //  █
DB 0b10101010; // █ █
DB 0b00100010; // █
DB 0b00100010; // █

white_queen_representation:
DB 0b00000000;
DB 0b00000000;
DB 0b01000100; //  █
DB 0b10101010; // █ █
DB 0b11001100; //  ██
DB 0b10001000; //   █
DB 0b10001000; //   █

piece_representation:
DW empty_square_representation;
DW black_pawn_representation;
DW black_king_representation;
DW black_knight_representation;
DW black_bishop_representation;
DW black_rook_representation;
DW black_queen_representation;
DW empty_square_representation;
DW empty_square_representation;
DW white_pawn_representation;
DW white_king_representation;
DW white_knight_representation;
DW white_bishop_representation;
DW white_rook_representation;
DW white_queen_representation;


// *************************************
// Constants

INT_RAM_START EQU 0xA000;

SQUARE_INDEX_A8 EQU 21;

// *************************************
// draw_piece

draw_piece_return_address: DW;
draw_piece_square_index: DB;
draw_piece_board_value: DB;
draw_piece_piece_value: DB;
draw_piece_piece_representation_address: DW;
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
LD.B R0, (R2);
ST.B draw_piece_board_value, R0;            //     board_value = board[square_index]; 

LD.B R3, #0b00001111;
AND R0, R3;
ST.B draw_piece_piece_value, R0;            //     piece_value = board_value & 0b00001111; 

LD.W R2, #piece_representation;
ADD R2,R0;
ADD R2,R0; // twice because each address is a word
LD.W R0, (R2);
ST.B draw_piece_piece_representation_address, R0; //  piece_representation_address = piece_representation[piece_value]; 


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