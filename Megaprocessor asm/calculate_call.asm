LD.B R0, #CALCULATE_LengthOf_Args;
MOVE R1, SP;
SUB R1,R0;
MOVE SP, R1;

JSR calculate;

LD.B R0, #CALCULATE_LengthOf_Args;
MOVE R1, SP;
ADD R1,R0;
MOVE SP, R1;

LD.W R0, calculate_returnValue;