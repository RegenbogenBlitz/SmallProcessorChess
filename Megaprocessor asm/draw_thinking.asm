                                     //  1 x                x                x
                                     //  2 x████████████████x████████████████x
                                     //  3 x                x                x
                                     //  4 x ███ █ █ █ █  █ x█ █ █ █  █ ████ x
                                     //  5 x  █  █ █ █ ██ █ x██  █ ██ █ █    x
                                     //  6 x  █  ███ █ █ ██ x█ █ █ █ ██ █  █ x
                                     //  7 x  █  █ █ █ █  █ x█ █ █ █  █ ████ x
                                     //  8 x                x                x
                                     //  9 x                x                x
                                     // 10 x                x                x
                                     // 11 x                x                x
                                     // 12 x                x                x
                                     // 13 x                x                x
                                     // 14 x                x                x
                                     // 15 x                x                x
                                     // 16 x                x                x
LD.W R2,#0xA0C0;

LD.W R0,#0b0000000000000000;
ST.W (R2++),R0;                    //  1a x                x
ST.W (R2++),R0;                    //  1b x                x
LD.W R0,#0b1111111111111111;
ST.W (R2++),R0;                    //  2a x████████████████x
ST.W (R2++),R0;                    //  2b x████████████████x
LD.W R0,#0b0000000000000000;
ST.W (R2++),R0;                    //  3a x                x
ST.W (R2++),R0;                    //  3b x                x
LD.W R0,#0b0100101010101110;
ST.W (R2++),R0;                    //  4a x ███ █ █ █ █  █ x
LD.W R0,#0b0111101001010101;
ST.W (R2++),R0;                    //  4b x█ █ █ █  █ ████ x
LD.W R0,#0b0101101010100100;
ST.W (R2++),R0;                    //  5a x  █  █ █ █ ██ █ x
LD.W R0,#0b0000101011010011;
ST.W (R2++),R0;                    //  5b x██  █ ██ █ █    x
LD.W R0,#0b0110101011100100;
ST.W (R2++),R0;                    //  6a x  █  ███ █ █ ██ x
LD.W R0,#0b0100101101010101;
ST.W (R2++),R0;                    //  6b x█ █ █ █ ██ █  █ x
LD.W R0,#0b0100101010100100;
ST.W (R2++),R0;                    //  7a x  █  █ █ █ █  █ x
LD.W R0,#0b0111101001010101;
ST.W (R2++),R0;                    //  7b x█ █ █ █  █ ████ x
LD.W R0,#0b0000000000000000;
ST.W (R2++),R0;                    //  8a x                x
ST.W (R2++),R0;                    //  8b x                x
ST.W (R2++),R0;                    //  9a x                x
ST.W (R2++),R0;                    //  9b x                x
ST.W (R2++),R0;                    // 10a x                x
ST.W (R2++),R0;                    // 10b x                x
ST.W (R2++),R0;                    // 11a x                x
ST.W (R2++),R0;                    // 11b x                x
ST.W (R2++),R0;                    // 12a x                x
ST.W (R2++),R0;                    // 12b x                x
ST.W (R2++),R0;                    // 13a x                x
ST.W (R2++),R0;                    // 13b x                x
ST.W (R2++),R0;                    // 14a x                x
ST.W (R2++),R0;                    // 14b x                x
ST.W (R2++),R0;                    // 15a x                x
ST.W (R2++),R0;                    // 15b x                x
ST.W (R2++),R0;                    // 16a x                x
ST.W (R2++),R0;                    // 16b x                x