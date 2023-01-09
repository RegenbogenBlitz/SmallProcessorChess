draw_board_return_address: DW;

draw_board_loop_rank_index: DB;
draw_board_loop_file_index: DB;
draw_board_square_index: DB;
NOP;
NOP;
NOP;

draw_board:
                                     // void draw_board() R0 return_address
                                     // {
ST.W draw_board_return_address, R0;

LD.B R0, #8;
ST.B draw_board_loop_rank_index, R0; //     loop_rank_index = 8;
ST.B draw_board_loop_file_index, R0; //     loop_file_index = 8;

LD.B R1, #SQUARE_INDEX_A8;           //     square_index = SQUARE_INDEX_A8;
draw_board_loop:
                                     //     do
                                     //     {
ST.B draw_board_loop_rank_index, R0;
ST.B draw_board_square_index, R1;
LD.W R0, #draw_board_return_from_draw_piece;
JMP draw_piece;                      //         draw_piece(Square.A8)
draw_board_return_from_draw_piece:
LD.B R1, draw_board_square_index;
INC R1;                              //         square_index++;
LD.B R0, draw_board_loop_rank_index;
DEC R0;                              //         loop_rank_index--;
BNE draw_board_loop;                 //         if (loop_rank_index != 0) { continue; }
                                     //         else {
LD.B R0, #8;                         //             loop_rank_index = 8;
ADDQ R1,#2;                          //             square_index += 2;
LD.B R2, draw_board_loop_file_index;
DEC R2;
ST.B draw_board_loop_file_index, R2; //             loop_file_index--;
BNE draw_board_loop;                 //             if (loop_file_index != 0) { continue; } else { break; }
                                     //         }
                                     //     }

                                     //  1 x                x                x
                                     //  2 x████████████████x████████████████x
                                     //  3 x                x                x
                                     //  4 x █ █ ██ ██  █   x█  ███ █  █ ██  x
                                     //  5 x █ █ █  █    █ █x   █ █ ██ █ █ █ x
                                     //  6 x █ █ ██ ██    █ x   ███ █ ██ █ █ x
                                     //  7 x █ █  █ █    █ █x   █ █ █  █ █ █ x
                                     //  8 x ███ ██ ██  █   x█  █ █ █  █ ██  x
                                     //  9 x                x                x
                                     // 10 x                x                x
                                     // 11 x   █ ███ █ █ ██ x███ █ ██ █ █    x
                                     // 12 x   █ █ █  █  █  x █  █ █  ██     x
                                     // 13 x   █ █ █  █  ██ x █  █ █  █ █    x
                                     // 14 x   █ █ █  █   █ x █  █ █  █ █    x
                                     // 15 x  ██ ███  █  ██ x █  █ ██ █ █    x
                                     // 16 x                x                x

LD.W R0,#0b0000000000000000;
ST.W (0xA0C0),R0;                    //  1a x                x
ST.W (0xA0C2),R0;                    //  1b x                x
LD.W R0,#0b1111111111111111;
ST.W (0xA0C4),R0;                    //  2a x████████████████x
ST.W (0xA0C6),R0;                    //  2b x████████████████x
LD.W R0,#0b0000000000000000;
ST.W (0xA0C8),R0;                    //  3a x                x
ST.W (0xA0CA),R0;                    //  3b x                x
LD.W R0,#0b0001001101101010;
ST.W (0xA0CC),R0;                    //  4a x █ █ ██ ██  █   x
LD.W R0,#0b0011010010111001;
ST.W (0xA0CE),R0;                    //  4b x█  ███ █  █ ██  x
LD.W R0,#0b1010000100101010;
ST.W (0xA0D0),R0;                    //  5a x █ █ █  █    █ █x
LD.W R0,#0b0101010110101000;
ST.W (0xA0D2),R0;                    //  5b x   █ █ ██ █ █ █ x
LD.W R0,#0b0100001101101010;
ST.W (0xA0D4),R0;                    //  6a x █ █ ██ ██    █ x
LD.W R0,#0b0101011010111000;
ST.W (0xA0D6),R0;                    //  6b x   ███ █ ██ █ █ x
LD.W R0,#0b1010000101001010;
ST.W (0xA0D8),R0;                    //  7a x █ █  █ █    █ █x
LD.W R0,#0b0101010010101000;
ST.W (0xA0DA),R0;                    //  7b x   █ █ █  █ █ █ x
LD.W R0,#0b0001001101101110;
ST.W (0xA0DC),R0;                    //  8a x ███ ██ ██  █   x
LD.W R0,#0b0011010010101001;
ST.W (0xA0DE),R0;                    //  8b x█  █ █ █  █ ██  x
LD.W R0,#0b0000000000000000;
ST.W (0xA0E0),R0;                    //  9a x                x
ST.W (0xA0E2),R0;                    //  9b x                x
ST.W (0xA0E4),R0;                    // 10a x                x
ST.W (0xA0E6),R0;                    // 10b x                x
LD.W R0,#0b0110101011101000;
ST.W (0xA0E8),R0;                    // 11a x   █ ███ █ █ ██ x
LD.W R0,#0b0000101011010111;
ST.W (0xA0EA),R0;                    // 11b x███ █ ██ █ █    x
LD.W R0,#0b0010010010101000;
ST.W (0xA0EC),R0;                    // 12a x   █ █ █  █  █  x
LD.W R0,#0b0000011001010010;
ST.W (0xA0EE),R0;                    // 12b x █  █ █  ██     x
LD.W R0,#0b0110010010101000;
ST.W (0xA0F0),R0;                    // 13a x   █ █ █  █  ██ x
LD.W R0,#0b0000101001010010;
ST.W (0xA0F2),R0;                    // 13b x █  █ █  █ █    x
LD.W R0,#0b0100010010101000;
ST.W (0xA0F4),R0;                    // 14a x   █ █ █  █   █ x
LD.W R0,#0b0000101001010010;
ST.W (0xA0F6),R0;                    // 14b x █  █ █  █ █    x
LD.W R0,#0b0110010011101110;
ST.W (0xA0F8),R0;                    // 15a x  ██ ███  █  ██ x
LD.W R0,#0b0000101011010010;
ST.W (0xA0FA),R0;                    // 15b x █  █ ██ █ █    x
LD.W R0,#0b0000000000000000;
ST.W (0xA0FC),R0;                    // 16a x                x
ST.W (0xA0FE),R0;                    // 16b x                x

LD.W R0, draw_board_return_address;
JMP (R0);                           //     return;
                                    // }