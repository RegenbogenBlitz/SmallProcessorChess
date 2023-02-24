// (Switches are HIGH by "default", and go LOW on being pressed).
IO_SWITCH_FLAG_UP               EQU     0x0001;
IO_SWITCH_FLAG_DOWN             EQU     0x0002;
IO_SWITCH_FLAG_LEFT             EQU     0x0004;
IO_SWITCH_FLAG_RIGHT            EQU     0x0008;
IO_SWITCH_FLAG_CROSS            EQU     0x0080;
IO_SWITCH_FLAG_R1               EQU     0x0400;

                                         // ** R0 = input
                                         // void handle_input(input) {
TEST R0;
BNE handle_input__check_input;           //     if(input == 0) {
JMP handle_input_return;                 //         return;
                                         //     }
handle_input__check_input:
LD.W R1,#IO_SWITCH_FLAG_UP;
AND R1,R0;
BNE handle_input_up_is_not_pressed;      //     if(input & IO_SWITCH_FLAG_UP != 0) {
                                         //     } else {
LD.B R3,global_cursor_square_index;      //         var newCursorIndex = global_cursor_square_index;
MOVE R1, R3;                             //         var oldCursorIndex = newCursorIndex;
LD.B R2,#10;
SUB R3,R2;                               //         newCursorIndex -= 10;
JMP move_if_new_cursor_still_on_board;   //         move_if_new_cursor_still_on_board(oldCursorIndex);
                                         //         return;
handle_input_up_is_not_pressed:          //     }

LD.W R1,#IO_SWITCH_FLAG_DOWN;
AND R1,R0;
BNE handle_input_down_is_not_pressed;    //     if(input & IO_SWITCH_FLAG_DOWN != 0) {
                                         //     } else {
LD.B R3,global_cursor_square_index;      //         var newCursorIndex = global_cursor_square_index;
MOVE R1, R3;                             //         var oldCursorIndex = newCursorIndex;
LD.B R2,#10;
ADD R3,R2;                               //         newCursorIndex += 10;
JMP move_if_new_cursor_still_on_board;   //         move_if_new_cursor_still_on_board(oldCursorIndex);
                                         //         return;
handle_input_down_is_not_pressed:        //     }

LD.W R1,#IO_SWITCH_FLAG_LEFT;
AND R1,R0;
BNE handle_input_left_is_not_pressed;    //     if(input & IO_SWITCH_FLAG_LEFT != 0) {
                                         //     } else {
LD.B R3,global_cursor_square_index;      //         var newCursorIndex = global_cursor_square_index;
MOVE R1, R3;                             //         var oldCursorIndex = newCursorIndex;
LD.B R2,#1;
SUB R3,R2;                               //         newCursorIndex -= 1;
JMP move_if_new_cursor_still_on_board;   //         move_if_new_cursor_still_on_board(oldCursorIndex);
                                         //         return;
handle_input_left_is_not_pressed:        //     }

LD.W R1,#IO_SWITCH_FLAG_RIGHT;
AND R1,R0;
BNE handle_input_right_is_not_pressed;   //     if(input & IO_SWITCH_FLAG_RIGHT != 0) {
                                         //     } else {
LD.B R3,global_cursor_square_index;      //         var newCursorIndex = global_cursor_square_index;
MOVE R1, R3;                             //         var oldCursorIndex = newCursorIndex;
LD.B R2,#1;
ADD R3,R2;                               //         newCursorIndex -= 1;
JMP move_if_new_cursor_still_on_board;   //         move_if_new_cursor_still_on_board(oldCursorIndex);
                                         //         return;
handle_input_right_is_not_pressed:       //     }

LD.W R1,#IO_SWITCH_FLAG_CROSS;
AND R1,R0;
BNE handle_input_cross_is_not_pressed;   //     if(input & IO_SWITCH_FLAG_CROSS != 0) {
                                         //     } else {

LD.W R0, #handle_input__return_from_on_click;
JMP on_click;                            //         on_click();
handle_input__return_from_on_click:
JMP handle_input_return;

handle_input_cross_is_not_pressed:       //     }

LD.W R1,#IO_SWITCH_FLAG_R1;
AND R1,R0;
BNE handle_input_r1_is_not_pressed;      //     if(input & IO_SWITCH_FLAG_R1 != 0) {
                                         //     } else {
JMP start;                               //         goto start;
handle_input_r1_is_not_pressed:          //     }

JMP handle_input_return;                 //     return;
                                         // }

                                         // ** R1 = old_square_index, R3 = new_square_index
move_if_new_cursor_still_on_board:       // void move_if_new_cursor_still_on_board(old_square_index, new_square_index) {
LD.B R2,#boardState;
ADD R2,R3;
LD.B R0,(R2);                            //     var squareValue = boardState[newCursorIndex];
LD.B R2,#PIECE_ENUM_OFFBOARD;
CMP R0,R2;
BEQ handle_input_return;                 //     if(squareValue == PIECE_ENUM_OFFBOARD) { return; }

ST.B global_cursor_square_index, R3;     //     global_cursor_square_index = newCursorIndex;

LD.W R0, #handle_input_return_old_cursor;
JMP draw_piece;                          //     draw_piece(old_square_index); // clear cursor from old square
handle_input_return_old_cursor:
LD.B R1,global_cursor_square_index;
LD.W R0, #handle_input_return;
JMP draw_piece;                          //     draw_piece(global_cursor_square_index); // clear cursor from old square
                                         //     return;
                                         // }
handle_input_return:
NOP;