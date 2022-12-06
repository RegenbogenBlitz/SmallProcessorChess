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

LD.W R0, draw_board_return_address;
JMP (R0);                           //     return;
                                    // }