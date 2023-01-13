// (Switches are HIGH by "default", and go LOW on being pressed).
IO_SWITCH_FLAG_UP               EQU     0x0001;
IO_SWITCH_FLAG_DOWN             EQU     0x0002;
IO_SWITCH_FLAG_LEFT             EQU     0x0004;
IO_SWITCH_FLAG_RIGHT            EQU     0x0008;
IO_SWITCH_FLAG_CROSS            EQU     0x0080;

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

LD.B R3,global_cursor_square_index;
LD.B R2, #board;
ADD R2,R3;
LD.B R0, (R2);                           //         var new_square_value = board[global_cursor_square_index];

LD.B R1,global_selected_square_index;
LD.B R2, #board;
ADD R2,R1;
LD.B R1, (R2);                           //         var old_square_value = board[global_selected_square_index];

BEQ handle_input__change_selection;      //         if(old_square_value == EMPTY_SQUARE_VALUE) {
                                         //             goto change_selection;
                                         //         }
TEST R0;
BEQ handle_input__move_piece;            //         if(new_square_value == EMPTY_SQUARE_VALUE) {
                                         //             goto handle_input__move_piece;
                                         //         }

LD.B R2,#PIECE_COLOUR_MASK;
AND R1,R2;                               //         var old_square_color = old_square_value & PIECE_COLOUR_MASK;
AND R0,R2;                               //         var new_square_color = new_square_value & PIECE_COLOUR_MASK;
CMP R0,R1;
BNE handle_input__move_piece;            //         if(old_square_color != new_square_color) {
                                         //             goto handle_input__move_piece;
                                         //         }
                                         //         else {
handle_input__change_selection:          //             change_selection:
LD.B R1,global_selected_square_index;    //             old_square_index = global_selected_square_index;
ST.B global_selected_square_index,R3;    //             global_selected_square_index = global_cursor_square_index;
JMP handle_input__update_old_square;     //             goto update_old_square;
                                         //         }

handle_input__move_piece:                //         move_piece:

LD.B R2,global_cursor_square_index;
LD.B R3, #board;
ADD R3,R2;

LD.B R1,global_selected_square_index;    //         old_square_index = global_selected_square_index;
LD.B R2, #board;
ADD R2,R1;
LD.B R0, (R2);

ST.B (R3), R0;                           //         board[global_cursor_square_index] = board[global_selected_square_index];
LD.B R0, #EMPTY_SQUARE_VALUE;
ST.B (R2), R0;                           //         board[global_selected_square_index] = EMPTY_SQUARE_VALUE;

handle_input__update_old_square:         //         update_old_square:
LD.W R0, #handle_input_return;
JMP draw_piece;                          //         draw_piece(old_square_index); // clear selected from old square
                                         //         return;

handle_input_cross_is_not_pressed:       //     }

JMP handle_input_return;                 //     return;
                                         // }

                                         // ** R1 = old_square_index, R3 = new_square_index
move_if_new_cursor_still_on_board:       // void move_if_new_cursor_still_on_board(old_square_index, new_square_index) {
LD.B R2,#board;
ADD R2,R3;
LD.B R0,(R2);                            //     var squareValue = board[newCursorIndex];
LD.B R2,#OFFBOARD_SQUARE_VALUE;
CMP R0,R2;
BEQ handle_input_return;                 //     if(squareValue == OFFBOARD_SQUARE_VALUE) { return; }

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