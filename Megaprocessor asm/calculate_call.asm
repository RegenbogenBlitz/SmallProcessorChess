LD.B R1, #CALCULATE_LengthOf_Args;
MOVE R0, SP;
SUB R0,R1;
MOVE SP, R0;

JSR calculate;

LD.B R1, #CALCULATE_LengthOf_Args;
MOVE R0, SP;
ADD R0,R1;
MOVE SP, R0;

LD.W R0, calculate_returnValue;