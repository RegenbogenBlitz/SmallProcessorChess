// *******************************************************
// R0 - result
// *******************************************************

                                        // // wait for all inputs to unpressed
                                        // var invertedInput;
wait_for_input_lbl_unpressed_loop:      // do {
LD.W R0,GEN_IO_INPUT;                   //      invertedInput = GEN_IO_INPUT; // all 1's if nothing pushed
INV R0;                                 //      invertedInput = !invertedInput; // all 0's if nothing pushed
BEQ wait_for_input_lbl_pressed_loop;
JMP wait_for_input_lbl_unpressed_loop;  // } while(invertedInput != 0)

                                        // // wait for something to be pressed
wait_for_input_lbl_pressed_loop:        // do {
LD.W R0,GEN_IO_INPUT;                   //      invertedInput = GEN_IO_INPUT; // all 1's if nothing pushed
INV R0;                                 //      invertedInput = !invertedInput; // all 0's if nothing pushed
BNE wait_for_input_lbl_something_pressed;
JMP wait_for_input_lbl_pressed_loop;    // } while(invertedInput == 0)


wait_for_input_lbl_something_pressed:
INV R0;
