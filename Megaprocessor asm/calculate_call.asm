JSR calculate;
POP R0; // POP CALCULATE_ARG_maxGameValueThatAvoidsPruning
POP R0; // POP CALCULATE_ARG_modeMaxDepth
POP R0; // POP CALCULATE_ARG_enPassantPawnIndex
POP R0; // POP CALCULATE_ARG_depth
POP R0; // POP CALCULATE_ARG_opponentPieceColor
LD.W R0, calculate_returnValue;