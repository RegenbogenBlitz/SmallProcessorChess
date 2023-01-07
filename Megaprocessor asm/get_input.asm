                                         // ** no input, returns R0
                                         // int get_input() {
LD.B R0, get_input_input_is_clear;
BNE get_input_wait_for_input;            //     if(get_input_input_is_clear == true) {          // i.e get_input_input_is_clear != 0
                                         //     } else {
LD.W R0,GEN_IO_INPUT;                    //         var invertedInput = GEN_IO_INPUT;
INV R0;                                  //         invertedInput = !invertedInput; // all 0's if nothing pushed
BNE get_input_not_clear;                 //         if (invertedInput != 0) {
                                         //         }
                                         //         else {
LD.B R0, #0xFF; 
ST.B get_input_input_is_clear, R0;       //             get_input_input_is_clear = true;
get_input_not_clear:                     //         }
LD.W R0, #0x0000;   
JMP get_input_return;                    //         return 0;
                                         //     }

get_input_wait_for_input:                //     if(get_input_input_is_clear == true) {          // i.e get_input_input_is_clear != 0
LD.W R0,GEN_IO_INPUT;                    //         var invertedInput = GEN_IO_INPUT;
INV R0;                                  //         invertedInput = !invertedInput; // all 0's if nothing pushed
BEQ get_input_clear;                     //         if (invertedInput == 0) {
                                         //         }
                                         //         else {
LD.B R0, #0x00; 
ST.B get_input_input_is_clear, R0;       //             get_input_input_is_clear = false;
LD.W R0, GEN_IO_INPUT;  
JMP get_input_return;                    //             return GEN_IO_INPUT;
                                         //         }

get_input_clear:                         //         if (invertedInput == 0) {
                                         //             ** R0 = 0 here, because R0 == invertedInput == 0 **
JMP get_input_return;                    //             return 0;
                                         //         }
                                         //     }

// ***************
// ** not reachable, so can store value here **
get_input_input_is_clear: DB 0;
// ***************

get_input_return:
NOP;
                                         // }
