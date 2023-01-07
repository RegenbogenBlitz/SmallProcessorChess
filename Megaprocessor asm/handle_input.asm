// (Switches are HIGH by "default", and go LOW on being pressed).
IO_SWITCH_FLAG_UP               EQU     0x0001;
IO_SWITCH_FLAG_DOWN             EQU     0x0002;
IO_SWITCH_FLAG_LEFT             EQU     0x0004;
IO_SWITCH_FLAG_RIGHT            EQU     0x0008;

                                         // ** R0 = input
                                         // void handle_input(input) {
TEST R0;
BEQ handle_input_return;                 //     if(input == 0) { return; }
                                         //     else {
                                         //         GEN_IO_INPUT = input;
                                         //     }
LD.W R1,#IO_SWITCH_FLAG_UP;
AND R1,R0;
BNE handle_input_up_is_not_pressed;      //     if(GEN_IO_INPUT & IO_SWITCH_FLAG_UP != 0) {
                                         //     } else {
LD.B R3,global_cursor_square_index;      //         var newCursorIndex = global_cursor_square_index;
MOVE R1, R3;                             //         var oldCursorIndex = global_cursor_square_index;
LD.B R2,#10;
SUB R3,R2;                               //         newCursorIndex -= 10;
LD.B R2,#SQUARE_INDEX_A8;
CMP R3,R2;
BLT handle_input_return;                 //         if(newCursorIndex < SQUARE_INDEX_A8) { return; }

ST.B global_cursor_square_index, R3;     //         global_cursor_square_index = newCursorIndex;
JMP handle_input_remove_old_cursor;      //         remove_old_cursor(oldCursorIndex);
                                         //         return;
handle_input_up_is_not_pressed:          //     }

LD.W R1,#IO_SWITCH_FLAG_DOWN;
AND R1,R0;
BNE handle_input_down_is_not_pressed;    //     if(GEN_IO_INPUT & IO_SWITCH_FLAG_DOWN != 0) {
                                         //     } else {
LD.B R3,global_cursor_square_index;      //         var newCursorIndex = global_cursor_square_index;
MOVE R1, R3;                             //         var oldCursorIndex = global_cursor_square_index;
LD.B R2,#10;
ADD R3,R2;                               //         newCursorIndex += 10;
LD.B R2,#SQUARE_INDEX_H1;
CMP R3,R2;
BGT handle_input_return;                 //         if(newCursorIndex > SQUARE_INDEX_H1) { return; }

ST.B global_cursor_square_index, R3;     //         global_cursor_square_index = newCursorIndex;
JMP handle_input_remove_old_cursor;      //         remove_old_cursor(oldCursorIndex);
                                         //         return;
handle_input_down_is_not_pressed:          //     }


JMP handle_input_return;                 //     return;
                                         // }

                                         // ** R1 = old_square_index
handle_input_remove_old_cursor:          // void remove_old_cursor(old_square_index) {
LD.W R0, #handle_input_return;
JMP draw_piece;                          //     draw_piece(global_cursor_square_index)
                                         //     return;
                                         // }
handle_input_return:
NOP;